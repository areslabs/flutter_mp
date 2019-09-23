/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

enum TextAlign {
    left,
    right,
    center,
}


class FontWeight {
    const FontWeight._(this.index);

    final int index;
    static const FontWeight w100 = FontWeight._(100);
    static const FontWeight w200 = FontWeight._(200);
    static const FontWeight w300 = FontWeight._(300);
    static const FontWeight w400 = FontWeight._(400);
    static const FontWeight w500 = FontWeight._(500);
    static const FontWeight w600 = FontWeight._(600);
    static const FontWeight w700 = FontWeight._(700);
    static const FontWeight w800 = FontWeight._(800);
    static const FontWeight w900 = FontWeight._(900);
    static const FontWeight normal = w400;
    static const FontWeight bold = w700;
    static const List<FontWeight> values = <FontWeight>[
        w100, w200, w300, w400, w500, w600, w700, w800, w900
    ];
}

class TextStyle {
    double fontSize;
    Color color;
    FontWeight fontWeight;
    Color backgroundColor;

    TextStyle({this.fontSize, this.color, this.fontWeight, this.backgroundColor});
}



class Text extends BaseWidget {
    final String data;
    final TextStyle style;
    final TextAlign textAlign;
    final TextDirection textDirection;
    final bool softWrap;

    Text(this.data, {
        this.style,
        this.textAlign,
        this.textDirection,
        this.softWrap,
        String diuu,
        String tempName,
    }) : super(diuu: diuu, tempName: tempName, child: null, children: null);

    getStyle() {
        var style = '';
        if (this.style != null) {
            if (this.style.fontSize != null) {
                style = '$style font-size: ${this.style.fontSize}px;';
            }
            if (this.style.color != null) {
                style = '$style color: ${this.style.color.colorString};';
            }

            if (this.style.fontWeight != null) {
                style = '$style font-weight: ${this.style.fontWeight.index};';
            }

            if (this.style.backgroundColor != null) {
                style = '$style background-color: ${this.style.backgroundColor.colorString};';
            }
        }
        if (this.textAlign == TextAlign.center) {
            style = '$style text-align: center;';
        }
        if (this.textAlign == TextAlign.left) {
            style = '$style text-align: left;';
        }
        if (this.textAlign == TextAlign.right) {
            style = '$style text-align: right;';
        }

        if (this.textDirection == TextDirection.ltr) {
            style = '$style direction: ltr;';
        }
        if (this.textDirection == TextDirection.rtl) {
            style = '$style direction: rtl;';
        }

        return style;
    }

    Map<String, String> getUiDes() {
        return {'data': this.data, 'style': this.getStyle()};
    }
}
