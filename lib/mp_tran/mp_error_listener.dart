/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';

/// A simple [AnalysisErrorListener] that just collects the reported errors.
class MpErrorListener implements AnalysisErrorListener {
	final _errors = <AnalysisError>[];

	void onError(AnalysisError error) {
		// Fasta produces some semantic errors, which we want to ignore so that
		// users can format code containing static errors.
		if (error.errorCode.type != ErrorType.SYNTACTIC_ERROR) return;

		_errors.add(error);
	}

	/// Throws a [FormatterException] if any errors have been reported.
	void throwIfErrors() {
		if (_errors.isEmpty) return;

		print('errors happen: \n$_errors');
		throw 'Analysis error!';
	}
}