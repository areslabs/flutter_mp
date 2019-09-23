/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './wxml_node.dart';

String generateWxml(RootWxmlNode root, Set<int> validChildTempValues) {
    var wxml = '';
    for(int i = 0; i < root.children.length; i ++) {
        var item = root.children[i];
        var itemStr = _geneWxmlInner(item, '');
        wxml = '$wxml$itemStr';
    }

    if (wxml.trim() == '') return '';

    String childTemp = '';
    validChildTempValues.forEach((validIndex) {
        String subChildTemp = '''<template name="childTemp${validIndex}">
   <template wx:if="{{d.tempName}}" is="{{d.tempName}}" data="{{...d}}"/>
   <block wx:else>
       <block wx:for="{{d}}" wx:key="key">
           <template is="{{item.tempName}}" data="{{...item}}"/>
       </block>
   </block>
</template>
''';
        childTemp = '$childTemp$subChildTemp';
    });

    String holderTemp = '<template wx:if="{{(_r && _r.tempName)}}" is="{{_r.tempName}}" data="{{..._r}}"/>';
    wxml = '$childTemp$wxml$holderTemp';
    return wxml;
}

String _geneWxmlInner(WxmlNode wn, String prefixTab) {
    String str = '';
    String tempBefore = '';
    String tempEnd = '';
    if (wn.tempName != null) {
        tempBefore = '$prefixTab<template name="${wn.tempName}">\n';
        tempEnd = '$prefixTab</template>\n';
        prefixTab = '\t$prefixTab';
    }


    if (wn.children.length == 0) {
        str = '$prefixTab${wn.getOpenWxml(true)}\n';
    } else {
        str = '$prefixTab${wn.getOpenWxml(false)}\n';
        for(int i = 0; i < wn.children.length; i ++) {
            var child = wn.children[i];
            var childStr = _geneWxmlInner(child, '\t$prefixTab');
            str = '$str$childStr';
        }
        str += '$prefixTab${wn.getCloseWxml()}\n';
    }

    str = '$tempBefore$str$tempEnd';

    return str;
}


Set<String> baseWidgetSet = {
    'Container',
    'Center',
    'Text',
    'Row',
    'Column',
    'Expanded',
    'Image.asset',
    'Icon',
    'MaterialApp',
    'Scaffold',
    'ListView'
};
WxmlNode wxmlNodeFactory(String tag, List<String> props, String diuu, String tempName) {
    if (tag == 'Container'
        || tag == 'Center'
        || tag == 'Row'
        || tag == 'Column'
        || tag == 'Expanded'
        || tag == 'Scaffold'
    ) {
        return SimpleViewWxmlNode(tag, props, diuu, tempName);
    }

    if (tag == 'Text') {
        return TextWxmlNode(tag, props, diuu, tempName);
    }

    if (tag == 'Image.asset') {
        return ImageWxmlNode('Image', props, diuu, tempName);
    }

    if (tag == 'Icon') {
        return IconWxmlNode('Icon', props, diuu, tempName);
    }

    if (tag == 'MaterialApp') {
        return BlockWxmlNode('MaterialApp', props, diuu, tempName);
    }

    if (tag == 'ListView') {
        return ScrollViewWxmlNode('ListView', props, diuu, tempName);
    }
}

