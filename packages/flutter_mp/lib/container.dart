/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Container extends BaseWidget {
    final Decoration decoration;
    final double width;
    final double height;
    final EdgeInsets margin;
    final EdgeInsets padding;
    final Color color;

    Container({
                  this.decoration,
                  this.width,
                  this.height,
                  this.margin,
                  this.color,
                  this.padding,
                  String diuu,
                  String tempName,
                  Widget child})
        : super(diuu: diuu, tempName: tempName, child: child, children: null);


    getStyle() {
        var style = '';
        if (this.width != null) {
            style = '$style width: ${this.width}px;';
        }

        if (this.height != null) {
            style = '$style height: ${this.height}px;';
        }

        if (this.color != null) {
            style = '$style background-color: ${this.color.colorString};';
        }

        if (this.padding != null) {
            style = '$style ${this.padding.toStyleString('padding')};';
        }

        if (this.margin != null) {
            style = '$style ${this.margin.toStyleString('margin')};';
        }

        if (this.decoration != null) {
            style = '$style ${this.decoration.toString()};';
        }

        return style;

    }

    @override
    Map<String, String> getUiDes() {
        return {
            'style': this.getStyle()
        };
    }
}
