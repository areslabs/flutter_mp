/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';

class Template extends BaseWidget {
    Object tempVnode;
    String datakey;

    Template({Object tempVnode, String datakey})
        : super(diuu: null, tempName: null, child: null, children: null) {
        this.tempVnode = tempVnode;
        this.datakey = datakey;
    }
}