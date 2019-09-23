/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/scanner/reader.dart';
import 'package:analyzer/src/dart/scanner/scanner.dart';
import 'package:analyzer/src/generated/parser.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/string_source.dart';

import './mp_error_listener.dart';
import './mp_visitor.dart';
import './wxml_node/util.dart' as util;

Map<String, String> mpTran(String code) {
    final mpErrorLis = new MpErrorListener();

    var reader = CharSequenceReader(code);
    var stringSource = StringSource(code, null);
    var scanner = Scanner(stringSource, reader, mpErrorLis);
    var startToken = scanner.tokenize();

    mpErrorLis.throwIfErrors();

    // Parse it.
    var featureSet = FeatureSet.fromEnableFlags([]);
    var parser = Parser(stringSource, mpErrorLis, featureSet: featureSet);
    parser.enableOptionalNewAndConst = true;
    parser.enableSetLiterals = true;

    AstNode node = parser.parseCompilationUnit(startToken);

    var mpVisitor = MpVisitor();
    node.accept(mpVisitor);

    String wxmlCode = util.generateWxml(mpVisitor.fatherWxmlNode, mpVisitor.validChildTempValues);
    String newCode = node.toSource();

    return {
        "wxml": wxmlCode,
        "dart": newCode,
    };
}
