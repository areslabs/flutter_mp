/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class ListView extends BaseWidget {
    final EdgeInsets padding;

    ListView({this.padding, String diuu, String tempName, Widget child, List<Widget> children})
        : super(diuu: diuu, tempName: tempName, child: child, children: children);

    getStyle() {
        var style = "";
        if (this.padding != null) {
            style = '$style ${this.padding.toStyleString('padding')}';
        }
        return style;
    }

    Map<String, String> getUiDes() {
        return {
            "style": this.getStyle()
        };
    }
}