/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Image extends BaseWidget {
    final double width;
    final double height;
    final BoxFit fit;
    String name;

    Image.asset(String name, {
        this.width,
        this.height,
        this.fit,
        String diuu,
        String tempName
    }) :super(diuu: diuu, tempName: tempName, child: null, children: null) {
        this.name = name;
    }


    getStyle() {
        var style = '';
        if (this.width != null) {
            // TODO dart 机制和小程序不同？
            style = '$style width: 100%;';
        }

        if (this.height != null) {
            style = '$style height: ${this.height}px;';
        }
        return style;
    }

    Map<String, String> getUiDes() {

        return {
            'src': '/${this.name}',
            'style': this.getStyle(),
            'mode': 'scaleToFill' //TODO fit获取
        };
    }
}
