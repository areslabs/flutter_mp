/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Row extends BaseWidget {
    final TextDirection textDirection;
    final MainAxisAlignment mainAxisAlignment;
    final MainAxisSize mainAxisSize;
    final CrossAxisAlignment crossAxisAlignment;

    Row({
            this.textDirection,
            this.mainAxisAlignment = MainAxisAlignment.start,
            this.mainAxisSize = MainAxisSize.max,
            this.crossAxisAlignment = CrossAxisAlignment.center,
            String diuu,
            String tempName,
            Widget child,
            List<Widget> children})
        : super(diuu: diuu, tempName: tempName, child: child, children: children);


    getStyle() {
        var style = '';

        if (this.mainAxisAlignment == MainAxisAlignment.start) {
            style = '$style justify-content: flex-start;';
        }
        if (this.mainAxisAlignment == MainAxisAlignment.end) {
            style = '$style justify-content: flex-end;';
        }
        if (this.mainAxisAlignment == MainAxisAlignment.center) {
            style = '$style justify-content: center;';
        }
        if (this.mainAxisAlignment == MainAxisAlignment.spaceAround) {
            style = '$style justify-content: space-around;';
        }
        if (this.mainAxisAlignment == MainAxisAlignment.spaceBetween) {
            style = '$style justify-content: space-between;';
        }
        if (this.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
            style = '$style justify-content: space-evenly;';
        }
        if (this.crossAxisAlignment == CrossAxisAlignment.start) {
            style = '$style align-items: flex-start;';
        }
        if (this.crossAxisAlignment == CrossAxisAlignment.end) {
            style = '$style align-items: flex-end;';
        }
        if (this.crossAxisAlignment == CrossAxisAlignment.center) {
            style = '$style align-items: center;';
        }
        if (this.crossAxisAlignment == CrossAxisAlignment.stretch) {
            style = '$style align-items: stretch;';
        }
        if (this.crossAxisAlignment == CrossAxisAlignment.baseline) {
            style = '$style align-items: baseline;';
        }
        return style;
    }

    Map<String, String> getUiDes() {
        return {'style': this.getStyle()};
    }

}
