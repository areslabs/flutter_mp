/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';
import 'package:path/path.dart' as p;

import './mp_tran/index.dart';
import './mp_struc/index.dart';
import './mp_code/index.dart';
import './util/util.dart';

const dartTempDir = '.dtmp';
const outJsFileName = '__main__.js';

void tran(inputDir, outputDir) async {
    var inputAbs = p.canonicalize(inputDir);
    var outputAbs = p.canonicalize(outputDir);

    print('输入目录：$inputAbs');
    print('输出目录：$outputAbs');

    var dtmpPath = p.join(inputAbs, 'lib', dartTempDir);

    new Directory(p.join(dtmpPath, 'lib'))
        ..createSync(recursive: true);

    new Directory(outputAbs)
        ..createSync(recursive: true);

    await generateMpStruc(outputAbs);

    var input = new Directory(p.join(inputAbs, 'lib'));
    var allFiles = input.listSync(recursive: true);
    for (int i = 0; i < allFiles.length; i++) {
        var file = allFiles[i];
        if (file.path.contains(dartTempDir)) {
            continue;
        }

        if (file is Directory) {
            var newDirPath = file.path.replaceFirst(new RegExp(inputAbs), dtmpPath);
            new Directory(newDirPath)
                ..createSync();
        } else if (file is File && !file.path.endsWith('.dart')) {
            // 其他类型文件直接copy
            file.copySync(file.path.replaceFirst(new RegExp(inputAbs), dtmpPath));
        } else {
            // dart file
            var dartFile = (file as File);
            String code = dartFile.readAsStringSync();

            var mpResult = mpTran(code);
            var wxmlCode = mpResult['wxml'];
            var dartCode = mpResult['dart'];

            var newDartFilePath =
            file.path.replaceFirst(new RegExp(inputAbs), dtmpPath);
            File newDartFile = File(newDartFilePath);
            newDartFile.createSync();
            newDartFile.writeAsStringSync(dartCode);

            if (wxmlCode != '') {
                var outputPathTemp =
                file.path.replaceFirst(new RegExp(inputAbs), outputAbs);
                codeToFs(outputPathTemp.replaceFirst(new RegExp('.dart'), '.wxml'),
                    wxmlCode, true);

                var mpJs = await generateMpJsCode();
                codeToFs(outputPathTemp.replaceFirst(new RegExp('.dart'), '.js'),
                    mpJs, true);

                codeToFs(outputPathTemp.replaceFirst(new RegExp('.dart'), '.json'),
                    generateMpJsonCode(), true);

                var mpWxss = await generateMpWxssCode();
                codeToFs(outputPathTemp.replaceFirst(new RegExp('.dart'), '.wxss'),
                    mpWxss, true);
            }
        }
    }

    var imageInput = new Directory(p.join(inputAbs, 'images'));
    new Directory(p.join(outputAbs, 'images'))
        ..createSync();
    imageInput.listSync(recursive: true).forEach((file) {
        if (file is Directory) {
            var newDirPath = file.path.replaceFirst(new RegExp(inputAbs), dtmpPath);
            new Directory(newDirPath)
                ..createSync();
        } else if (file is File) {
            file.copySync(file.path.replaceFirst(new RegExp(inputAbs), outputAbs));
        }
    });

    generateJSCode(dtmpPath, outputAbs);
}

void generateJSCode(inputDir, outputDir) {
    var entryDart = p.join(inputDir, 'lib', 'main.dart');
    var outJs = p.join(outputDir, outJsFileName);

    var result = Process.runSync(
        'dart2js',
        ['--out=${outJs}', entryDart],
    );

    if (result.exitCode == 1) {
        print('dart2js error! 请查看所有dart依赖库是否安装');
        new Directory(inputDir)
            ..deleteSync(recursive: true);
        return;
    }

    // remove 所有中间文件
    var sourceMapPath = p.join(outputDir, '$outJsFileName.map');
    new File(sourceMapPath)
        ..deleteSync();
    var depsPath = p.join(outputDir, '$outJsFileName.deps');
    new File(depsPath)
        ..deleteSync();
    new Directory(inputDir)
        ..deleteSync(recursive: true);

    new File(outJs)
        ..writeAsStringSync('''
var dartMpInterop = require('./dartMpInterop')   
var self = {
    dartMpInterop: dartMpInterop
}  
wx.__self = self
function dartMainRunner(main, args) {
    wx.__dartRunner = {
        main: main,
        args: args
    }
}
        ''', mode: FileMode.append);

    print('success!');
}
