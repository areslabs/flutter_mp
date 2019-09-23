/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

abstract class WxmlNode {
    final tag;
    final props;
    final diuu;
    final tempName;
    List<String> wxmlProps = [];
    List<WxmlNode> children = new List<WxmlNode>();

    WxmlNode(this.tag, this.props, this.diuu, this.tempName);

    String getOpenWxml(bool selfClose);

    String getCloseWxml() {
        return '';
    }

    String getPropsWxml() {
        var diuu = this.diuu;
        var str = ' diuu="{{$diuu}}"';
        var wxmlProps = this.wxmlProps;

        for(int i = 0; i < wxmlProps.length; i ++ ) {
            var k = wxmlProps[i];
            str += ' $k="{{$diuu$k}}"';
        }
        return str;
    }
}

class RootWxmlNode extends WxmlNode {
    RootWxmlNode(): super('Root', null, null, null);

    @override
    String getOpenWxml(bool selfClose) {
        return '';
    }
    @override
    String getPropsWxml() {
        return '';
    }
}

class SimpleViewWxmlNode extends WxmlNode{
    final wxmlProps = [
        'style'
    ];

    SimpleViewWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    String getOpenWxml(bool selfClose) {
        return '<view class="${this.tag}"${this.getPropsWxml()}${selfClose ? '/' : ''}>';
    }

    String getCloseWxml() {
        return '</view>';
    }
}


class ScrollViewWxmlNode extends WxmlNode{
    final wxmlProps = [
        'style'
    ];

    ScrollViewWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    String getOpenWxml(bool selfClose) {
        return '<scroll-view class="${this.tag}"${this.getPropsWxml()}${selfClose ? '/' : ''}>';
    }

    String getCloseWxml() {
        return '</scroll-view>';
    }
}

class TextWxmlNode extends SimpleViewWxmlNode {
    TextWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    @override
    String getOpenWxml(bool selfClose) {
        return '<view class="${this.tag}"${this.getPropsWxml()}>{{${this.diuu}data}}</view>';
    }
}

class ImageWxmlNode extends WxmlNode {

    final wxmlProps = [
        'style',
        'src',
        'mode'
    ];

    ImageWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    @override
    String getOpenWxml(bool selfClose) {
        return '<image class="${this.tag}"${this.getPropsWxml()}/>';
    }
}

class TemplateWxmlNode extends WxmlNode {
    final String datakey;
    final int childTempValue;

    TemplateWxmlNode(this.datakey, this.childTempValue)
        : super(null, null, null, null);

    @override
    String getOpenWxml(bool selfClose) {
        return '<template wx:if="{{${this.datakey}}}" is="childTemp${this.childTempValue}" data="{{d: ${this.datakey}}}"/>';
    }

}

class IconWxmlNode extends WxmlNode {
    final wxmlProps = [
        'style'
    ];

    IconWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    @override
    String getOpenWxml(bool selfClose) {
        return '<text class="Icon"${this.getPropsWxml()}>{{${this.diuu}icon}}</text>';
    }
}

//TODO 占位？
class BlockWxmlNode extends WxmlNode {
    BlockWxmlNode(String tag, List<String> props, String diuu, String tempName)
        : super(tag, props, diuu, tempName);

    @override
    String getOpenWxml(bool selfClose) {
        return '<block${selfClose ? '/' : ''}>';
    }

    @override
    String getCloseWxml() {
        return '</block>';
    }
}
