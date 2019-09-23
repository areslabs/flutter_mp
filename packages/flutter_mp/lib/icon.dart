/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class IconData {
    final String value;
    IconData(this.value);
}

// TODO add more!!
class Icons {
    static IconData add = IconData('add');
    static IconData star = IconData('star');
    static IconData call = IconData('call');
    static IconData near_me = IconData('near_me');
    static IconData share = IconData('share');
}

class Icon extends BaseWidget {
    final TextDirection textDirection;
    final double size;
    final Color color;
    final IconData icon;


    Icon(this.icon, {this.size, this.color, this.textDirection, String diuu, String tempName})
        : super(diuu: diuu, tempName: tempName, child: null, children: null);


    getStyle() {
        var style = '';
        if (this.textDirection == TextDirection.ltr) {
            style = '$style direction: ltr;';
        }
        if (this.textDirection == TextDirection.rtl) {
            style = '$style direction: rtl;';
        }

        if (this.size != null) {
            style = '$style font-size: ${this.size}px;';
        }

        if (this.color != null) {
            style = '$style color: ${this.color.colorString};';
        }

        return style;
    }

    Map<String, String> getUiDes() {
        return {
            'style': this.getStyle(),
            'icon': this.icon.value,
        };
    }
}