/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Expanded extends BaseWidget {
    int flex;

    Expanded({this.flex = 1, String diuu, String tempName, Widget child})
        : super(diuu: diuu, tempName: tempName, child: child, children: null);


    getStyle() {
        var style = '';
        if (this.flex != null) {
            style = '$style flex: ${this.flex};';
        }
        return style;
    }

    Map<String, String> getUiDes() {
        return {'style': getStyle()};
    }
}