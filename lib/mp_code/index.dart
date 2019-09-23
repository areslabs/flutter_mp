/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import '../util/util.dart';

Future<String> generateMpJsCode() async {
    var tempStr = await getTempString('component.js');
    return tempStr;
}

Future<String> generateMpWxssCode() async {
    var tempStr = await getTempString('component.wxss');
    return tempStr;
}

//TODO 根据组件生成usingComponents， componentGenerics字段
const mpJsonCode = '''
{
  "component": true,
  "usingComponents": {},
  "componentGenerics": {},
  "disableScroll": true,
  "navigationBarTitleText": "Flutter layout demo"
}
''';

String generateMpJsonCode() {
    return mpJsonCode;
}

