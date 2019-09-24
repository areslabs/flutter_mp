/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:args/args.dart';
import 'package:flutter_mp_cli/main.dart' as cli;

//TODO 根据pubspec.yaml生成
var version = '0.0.1';
main(List<String> arguments) async {
    final ArgParser argParser = new ArgParser()
        ..addOption('input', abbr: 'i')
        ..addOption('output', abbr: 'o')
        ..addFlag('version', abbr: 'v');


    final argResults = argParser.parse(arguments);

    String inputDir = argResults['input'];
    String outputDir = argResults['output'];
    bool version = argResults['version'];

    if (version) {
        print('0.0.1');
        return;
    }

    await cli.tran(inputDir, outputDir);
}
