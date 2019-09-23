/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Center extends BaseWidget {
    Center({String diuu, String tempName, Widget child})
        : super(diuu: diuu, tempName: tempName, child: child, children: null);

    Map<String, String> getUiDes() {
        return {'style': ''};
    }
}
