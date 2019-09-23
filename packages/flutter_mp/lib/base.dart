/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './color.dart';
export './color.dart';

class BuildContext {
    ThemeData theme = new ThemeData();
}

abstract class Widget {
    String diuu;
    String tempName;
    List<Widget> children;


    String diuuValue;
    Map<String, Object> uiDes;

    Widget({this.diuu, this.tempName, Widget child, List<Widget> children}) {
        if (child != null) {
            this.children = [child];
        } else if (children != null) {
            this.children = children;
        } else {
            this.children = [];
        }
    }

    Widget build(BuildContext context) {}

    Map<String, String> getUiDes() {}
}

abstract class StatelessWidget extends Widget {
    StatelessWidget({String diuu, String tempName, Widget child, List<Widget> children})
        : super(diuu: diuu, tempName: tempName, child: child, children: children);
}

abstract class BaseWidget extends StatelessWidget {
    BaseWidget({String diuu, String tempName, Widget child, List<Widget> children})
        : super(diuu: diuu, tempName: tempName, child: child, children: children);
}


class Decoration {}

class BoxDecoration extends Decoration {
    Color color;

    BoxDecoration({this.color});

    @override
    String toString() {
        var s = '';
        if (this.color != null) {
            s = '$s background-color: ${this.color.colorString};';
        }
        return s;
    }
}

class Key {
    final value;

    Key(this.value);
}

enum TextDirection {
    rtl,
    ltr,
}

enum CrossAxisAlignment {
    start,
    end,
    center,
    stretch,
    baseline,
}

enum MainAxisAlignment {
    start,
    end,

    center,
    spaceBetween,

    spaceAround,
    spaceEvenly,
}

enum MainAxisSize {
    min,
    max,
}

class EdgeInsets {
    final double left;
    final double top;
    final double right;
    final double bottom;

    const EdgeInsets.all(double value)
        :   left = value,
            top = value,
            right = value,
            bottom = value;

    const EdgeInsets.only({
                        this.left = 0.0,
                        this.top = 0.0,
                        this.right = 0.0,
                        this.bottom = 0.0,
                    });

    String toStyleString(String name) {
        return '${name}: ${this.top}px ${this.right}px ${this.bottom}px ${this.left}px';
    }
}

enum BoxFit {
    fill,
    contain,
    cover,
    fitWidth,
    fitHeight,
    none,
    scaleDown,
}

class ThemeData {
    Color primaryColor;

    ThemeData({Color primaryColor}) {
        if (primaryColor == null) {
            this.primaryColor = Colors.blue;
        } else {
            this.primaryColor = primaryColor;
        }
    }
}