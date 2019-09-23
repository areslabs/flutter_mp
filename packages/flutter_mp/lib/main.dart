/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

import './base.dart';
import './instancer_manager.dart';
import './util/gene_uuid.dart';
import './dart_mp_interop/index.dart';
import './template.dart';

void runApp(Widget widget) {
	registerDartToJs();
	//TOOD 自动化
	widget.diuuValue = '__main__';

	final bc = new BuildContext();

	Map<String, Object> uiDes = {};
	runAppInner(widget, bc, uiDes);
}

void runAppInner(Widget widget, BuildContext bc, Map<String, Object> uiDes) {
	String tempName = widget.tempName;
	if (tempName != null) {
		uiDes['tempName'] = tempName;
	}

	if (widget is Template) {
		var temp = widget;
		var datakey = temp.datakey;
		var tempVnode = temp.tempVnode;
		if (tempVnode == null) {
			// do nothing
		} else if (tempVnode is List<Widget>) {
			List<Map<String, Object>> subUiDesList = [];
			uiDes[datakey] = subUiDesList;
			for(int i = 0; i < tempVnode.length; i ++) {
				Map<String, Object> itemUiDes = {};
				subUiDesList.add(itemUiDes);
				runAppInner(tempVnode[i], bc, itemUiDes);
			}
		} else {
			Map<String, Object> tempUiDes = {};
			uiDes[datakey] = tempUiDes;
			runAppInner(tempVnode, bc, tempUiDes);
		}
	} else if (widget is BaseWidget) {
		var diuu = widget.diuu;
		var des = widget.getUiDes();
		des.forEach((k, v) {
			uiDes['$diuu$k'] = v;
		});

		for(int i = 0; i < widget.children.length; i ++) {
			Widget child = widget.children[i];
			runAppInner(child, bc, uiDes);
		}
	} else {
		if (widget.diuuValue != '__main__') {
			var uuid = geneUuid();
			widget.diuuValue = uuid;
		}
		widgetsMap[widget.diuuValue] = widget;

		Widget w = widget.build(bc);
		runAppInner(w, bc, uiDes);

		widget.uiDes = uiDes;
	}
}
