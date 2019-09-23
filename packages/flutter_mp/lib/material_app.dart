/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

//TODO
class MaterialApp extends BaseWidget {
    final String title;

    MaterialApp({this.title, String diuu, String tempName, Widget home})
        : super(diuu: diuu, tempName: tempName, child: home, children: null);

    Map<String, String> getUiDes() {
        return {};
    }
}