/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

/**
 * 高效生成唯一uuid，需要全局不重复
 */

List<String> _ORDER = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split('');
List<String> _uuid = "a0000000".split('');

String geneUuid() {
    int start = 7;
    while (_incr(start) && start > 0) {
        start = start - 1;
    }

    return _uuid.join('');
}


bool _incr(index) {
    var v = _uuid[index];

    if (v == 'z') {
        _uuid[index] = '0';
        return true;
    } else {
        var nextIndex = _ORDER.indexOf(v) + 1;
        _uuid[index] = _ORDER[nextIndex];
        return false;
    }
}