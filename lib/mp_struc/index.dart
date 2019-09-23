/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';
import 'package:path/path.dart' as p;

import '../util/util.dart';

void generateFileFromFile(fileName, outputDic) async {
    var tempStr = await getTempString(fileName);
    var outPath = p.join(outputDic, fileName);

    new File(outPath)
        ..writeAsStringSync(tempStr);
}

void generateMpStruc (String outputPath) async {
    await generateFileFromFile('app.js', outputPath);
    await generateFileFromFile('app.wxss', outputPath);
    await generateFileFromFile('dartMpInterop.js', outputPath);
    await generateFileFromFile('project.config.json', outputPath);
    await generateFileFromFile('sitemap.json', outputPath);

    // Icon wxss
    await generateFileFromFile('icons.wxss', outputPath);

    generateMpAppJson(outputPath);
}


//TODO 根据路由生成 app.json
const appJsonStr = '''
{
	"pages": [
		"lib/main"
	],
	"window": {
		"backgroundTextStyle": "light",
		"backgroundColor": "#E9E9E9",
		"enablePullDownRefresh": false,
		"navigationBarTitleText": "HelloWorld",
		"navigationBarBackgroundColor": "#eee",
		"navigationBarTextStyle": "black"
	}
}
''';

void generateMpAppJson(String outputPath) {
    var appJsonPath = p.join(outputPath, 'app.json');
    new File(appJsonPath)
        ..writeAsStringSync(appJsonStr);
}