/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/dart/ast/ast.dart';

import './wxml_node/wxml_node.dart';
import './wxml_node/util.dart';

const mpFlutterUri = "'package:flutter_mp/material.dart'";

class MpVisitor extends RecursiveAstVisitor {

    int diuuValue;
    int tempNameValue;
    int tempDataKeyValue;
    int childTempValue;
    Set<int> validChildTempValues;
    WxmlNode fatherWxmlNode;

    @override
    visitCompilationUnit(CompilationUnit node) {
        // 重新初始化
        this.diuuValue = 1;
        this.tempNameValue = 1;
        this.tempDataKeyValue = 1;
        this.childTempValue = 1;
        this.validChildTempValues = {};
        this.fatherWxmlNode = new RootWxmlNode();

        return super.visitCompilationUnit(node);
    }

    @override
    visitImportDirective(ImportDirective node) {
        // 替换 package:flutter/material.dart 为 mpflutter/material.dart
        if (node.uri.stringValue == 'package:flutter/material.dart') {
            var ssl = SimpleStringLiteralImpl(
                this.stringToken(mpFlutterUri),
                ''
            );
            node.uri = ssl;
        }
        node.visitChildren(this);
        return null;
    }


    stringToken(String str) {
        return Token(
            TokenType(str, TokenType.STRING.name, TokenType.STRING.precedence, TokenType.STRING.kind),
            0
        );
    }


    NamedExpression createNamedExpression(String key, String value) {
        var keyIdenti = SimpleIdentifierImpl(this.stringToken(key));
        var colon = this.stringToken(':');
        var valueLabel = LabelImpl(keyIdenti, colon);

        var valueExpre = SimpleStringLiteralImpl(
            this.stringToken("'$value'"),
            ''
        );

        return NamedExpressionImpl(valueLabel, valueExpre);
    }

    // 给方法添加命名参数
    void addNamedArgument(args, key, value) {
        args.add(this.createNamedExpression(key, value));
    }

    /**
     * 是否是独立UI片段
     * 约定子组件的labe名是： child， children
     * 1. 是某个Widget child，不是独立的
     * 2. 是某个Widget children ，不是独立的
     * 3. 是MaterialApp 的home 属性，不是独立的
     * 4. 是Scaffold 的body属性，不是独立的
     * 5. //TODO 其他基本组件情况
     *
     * 如果不是以上情况，则是独立的
     */
    bool isUiBlock(AstNode node) {
        var parent = node.parent;

        // child ，属性传递props
        if (parent is NamedExpression) {
            var labelName = parent.name.label.toString();
            if (labelName == 'child') {
                var pp = parent.parent;
                if (pp is ArgumentList) {
                    var ppp = pp.parent;
                    var callName = this.getPerhapsValidCallName(ppp);
                    if (baseWidgetSet.contains(callName)) {
                        return false;
                    }
                }
            }

            if (labelName == 'home') {
                var pp = parent.parent;
                if (pp is ArgumentList) {
                    var ppp = pp.parent;
                    var callName = this.getPerhapsValidCallName(ppp);
                    if (callName == 'MaterialApp') {
                        return false;
                    }
                }
            }

            if (labelName == 'body') {
                var pp = parent.parent;
                if (pp is ArgumentList) {
                    var ppp = pp.parent;
                    var callName = this.getPerhapsValidCallName(ppp);
                    if (callName == 'Scaffold') {
                        return false;
                    }
                }
            }
        }
        // children
        if (parent is ListLiteral) {
            var pp = parent.parent;
            if (pp is NamedExpression) {
                var labelName = pp.name.label;
                if (labelName.toString() == 'children') {
                    var ppp = pp.parent;
                    if (ppp is ArgumentList) {
                        var pppp = ppp.parent;
                        var callName = this.getPerhapsValidCallName(pppp);
                        if (baseWidgetSet.contains(callName)) {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }

    List<String> getPropsFromArgs(NodeList<Expression> args) {
        var props = new List<String>();
        for (int i = 0; i < args.length; i ++) {
            var arg = args[i];
            if (arg is NamedExpression) {
                props.add(arg.name.label.toString());
            } else {
                props.add('arg_$i');
            }
        }
        return props;
    }

    methodInvokeAndInstanceCreationHandle(AstNode node, String methodName, NodeList<Expression> arguments) {
        if (baseWidgetSet.contains(methodName)) {

            // TODO 暂不处理 AppBar 直接移除
            if (methodName == 'Scaffold') {
                for(int i = 0; i < arguments.length; i ++ ) {
                    var item = arguments[i];
                    if (item is NamedExpression && item.name.label.toString() == 'appBar') {
                        arguments.removeAt(i);
                        break;
                    }
                }
            }


            var diuuV = 'DIUU${this.diuuValue ++}';
            this.addNamedArgument(arguments, 'diuu', diuuV);

            String tnV = null;
            if (this.isUiBlock(node)) {
                tnV = 'TN${this.tempNameValue ++}';
                this.addNamedArgument(
                    arguments, 'tempName', tnV);
            }

            WxmlNode current = wxmlNodeFactory(
                methodName,
                this.getPropsFromArgs(arguments),
                diuuV,
                tnV,
            );

            WxmlNode fatherWxmlNode = this.fatherWxmlNode;
            fatherWxmlNode.children.add(current);
            this.fatherWxmlNode = current;
            node.visitChildren(this);
            this.fatherWxmlNode = fatherWxmlNode;
            return null;
        } else {
            node.visitChildren(this);
            return null;
        }
    }

    @override
    visitInstanceCreationExpression(InstanceCreationExpression node) {
        var arguments = node.argumentList.arguments;
        var typeName = this.getPerhapsValidCallName(node);
        return this.methodInvokeAndInstanceCreationHandle(node, typeName, arguments);
    }

    @override
    visitMethodInvocation(MethodInvocation node) {
        var arguments = node.argumentList.arguments;
        var methodName = this.getPerhapsValidCallName(node);

        return this.methodInvokeAndInstanceCreationHandle(node, methodName, arguments);
    }



    String getPerhapsValidCallName(AstNode node) {
        String callName = null;

        if (node is InstanceCreationExpression) {
            callName = node.constructorName.type.toString();
        } else if (node is MethodInvocation) {
            callName = node.methodName.toString();
            if (node.target != null) {
                callName = '${node.target.toString()}.${callName}';
            }
        }

        return callName;
    }


    MethodInvocation getTempateInvoke(Expression expr, int index, Map<int, TemplateWxmlNode> allChildTemplate, int childTempValue) {
        var tempVnodeIdenti = SimpleIdentifierImpl(
            this.stringToken('tempVnode'),
        );

        var colon = this.stringToken(':');
        var tempVnodeLabel = LabelImpl(tempVnodeIdenti, colon);

        var datakey = 'DK${this.tempDataKeyValue ++}';

        var mii = MethodInvocationImpl(
            null,
            null,
            SimpleIdentifierImpl(
                this.stringToken('Template'),
            ),
            null,
            ArgumentListImpl(
                this.stringToken('('),
                [
                    NamedExpressionImpl(tempVnodeLabel, expr),
                    this.createNamedExpression('datakey', datakey)
                ],
                this.stringToken(')'),
            )
        );

        allChildTemplate[index] = TemplateWxmlNode(datakey, childTempValue);

        return mii;
    }

    @override
    visitNamedExpression(NamedExpression node) {
        var label = node.name.label.toString();

        var childTempValue = this.childTempValue;
        this.childTempValue ++;

        var allChildTemplate = new Map<int, TemplateWxmlNode>();

        if (label == 'children' || label == 'child' || label == 'home' || label == 'body') {
            var p = node.parent;

            if (p is ArgumentList) {
                var pp = p.parent;
                var callName = this.getPerhapsValidCallName(pp);


                if (baseWidgetSet.contains(callName)) {
                    if (label == 'child'
                        || (callName == 'MaterialApp' && label == 'home')
                        || (callName == 'Scaffold' && label == 'body')
                    ) {
                        var expr = node.expression;

                        var exprCallName = this.getPerhapsValidCallName(expr);
                        if (!baseWidgetSet.contains(exprCallName)) {
                            node.expression = this.getTempateInvoke(expr, 0, allChildTemplate, childTempValue);
                            this.validChildTempValues.add(childTempValue);
                        }
                    }

                    if (label == 'children') {
                        var expr = node.expression;
                        if (expr is ListLiteral) {
                            var elements = expr.elements;
                            for (int i = 0; i < elements.length; i ++ ) {
                                var item = elements[i];

                                var itemCallName = this.getPerhapsValidCallName(item);
                                if (!baseWidgetSet.contains(itemCallName)) {
                                    elements[i] = this.getTempateInvoke(item, i, allChildTemplate, childTempValue);
                                    this.validChildTempValues.add(childTempValue);
                                }
                            }
                        } else {
                            node.name.label = SimpleIdentifierImpl(
                                this.stringToken('child'),
                            );
                            node.expression = this.getTempateInvoke(expr, 0, allChildTemplate, childTempValue);
                            this.validChildTempValues.add(childTempValue);
                        }
                    }
                }
            }
        }

        node.visitChildren(this);

        var j = 0;
        var childLength = allChildTemplate.length + this.fatherWxmlNode.children.length;
        var allChildWxml = new List<WxmlNode>();

        for(int i = 0; i < childLength; i ++) {
            if (allChildTemplate.containsKey(i)) {
                //allChildWxml[i] = allChildTemplate[i];
                allChildWxml.add(allChildTemplate[i]);
            } else {
                allChildWxml.add(this.fatherWxmlNode.children[j]);
                j ++;
            }
        }
        this.fatherWxmlNode.children = allChildWxml;
        return null;
    }

}
