/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

// TODO 遍历tree 获取
class Theme extends Widget {

    static ThemeData of(BuildContext bc) {
        return bc.theme;
    }
}