/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

//TODO
class Scaffold extends BaseWidget {
    Scaffold({String diuu, String tempName, Widget body, Widget appBar})
        : super(diuu: diuu, tempName: tempName, child: body, children: null);

    Map<String, String> getUiDes() {
        return {};
    }
}