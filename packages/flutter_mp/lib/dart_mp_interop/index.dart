/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'dart:js';
import 'dart:convert';
import 'package:js/js.dart';
import '../instancer_manager.dart';

@JS("dartMpInterop.hi")
external String mpHi();


// register dart func to js!

void dartHi() {
    print('dart hi!');
}

String getUiDes(String diuu) {
    var uiDes = widgetsMap['__main__'].uiDes;
    return json.encode(uiDes);
}

void registerDartToJs() {
    context['dartHi'] = dartHi;
    context['getUides'] = getUiDes;
}

