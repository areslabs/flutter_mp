/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:io';
import 'dart:convert' show utf8;
import 'package:resource/resource.dart' show Resource;

void codeToFs(String path, String code, recursive) {
    File file = File(path);
    file.createSync(recursive: recursive);
    file.writeAsStringSync(code);
}


Future<String> getTempString(filePath) async {
    var resource = new Resource("package:flutter_mp_cli/mp_temp/${filePath}");
    var str = await resource.readAsString(encoding: utf8);
    return str;
}