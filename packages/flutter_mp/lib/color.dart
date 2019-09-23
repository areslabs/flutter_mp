/**
 * Copyright (c) Areslabs.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 */

// TODO 参考flutter_web 重新实现

class Colors {
	Colors._();

	static const Color transparent = Color(0x00000000);
	static const Color black = Color(0xFF000000);
	static const Color black87 = Color(0xDD000000);
	static const Color black54 = Color(0x8A000000);
	static const Color black45 = Color(0x73000000);
	static const Color black38 = Color(0x61000000);
	static const Color black26 = Color(0x42000000);
	static const Color black12 = Color(0x1F000000);
	static const Color white = Color(0xFFFFFFFF);
	static const Color white70 = Color(0xB3FFFFFF);
	static const Color white60 = Color(0x99FFFFFF);
	static const Color white54 = Color(0x8AFFFFFF);
	static const Color white30 = Color(0x4DFFFFFF);
	static const Color white24 = Color(0x3DFFFFFF);
	static const Color white12 = Color(0x1FFFFFFF);
	static const Color white10 = Color(0x1AFFFFFF);

	static FakeColor red = FakeColor({
		50: Color(0xFFFFEBEE),
		100: Color(0xFFFFCDD2),
		200: Color(0xFFEF9A9A),
		300: Color(0xFFE57373),
		400: Color(0xFFEF5350),
		500: Color(0xFFF44336),
		600: Color(0xFFE53935),
		700: Color(0xFFD32F2F),
		800: Color(0xFFC62828),
		900: Color(0xFFB71C1C),
	});

	static FakeColor pink = FakeColor({
		50: Color(0xFFFCE4EC),
		100: Color(0xFFF8BBD0),
		200: Color(0xFFF48FB1),
		300: Color(0xFFF06292),
		400: Color(0xFFEC407A),
		500: Color(0xFFE91E63),
		600: Color(0xFFD81B60),
		700: Color(0xFFC2185B),
		800: Color(0xFFAD1457),
		900: Color(0xFF880E4F),
	});

	static FakeColor purple = FakeColor({
		50: Color(0xFFF3E5F5),
		100: Color(0xFFE1BEE7),
		200: Color(0xFFCE93D8),
		300: Color(0xFFBA68C8),
		400: Color(0xFFAB47BC),
		500: Color(0xFF9C27B0),
		600: Color(0xFF8E24AA),
		700: Color(0xFF7B1FA2),
		800: Color(0xFF6A1B9A),
		900: Color(0xFF4A148C),
	});

	static FakeColor deepPurple = FakeColor({
		50: Color(0xFFEDE7F6),
		100: Color(0xFFD1C4E9),
		200: Color(0xFFB39DDB),
		300: Color(0xFF9575CD),
		400: Color(0xFF7E57C2),
		500: Color(0xFF673AB7),
		600: Color(0xFF5E35B1),
		700: Color(0xFF512DA8),
		800: Color(0xFF4527A0),
		900: Color(0xFF311B92),
	});


	static FakeColor blue = FakeColor({
		50: Color(0xFFE3F2FD),
		100: Color(0xFFBBDEFB),
		200: Color(0xFF90CAF9),
		300: Color(0xFF64B5F6),
		400: Color(0xFF42A5F5),
		500: Color(0xFF2196F3),
		600: Color(0xFF1E88E5),
		700: Color(0xFF1976D2),
		800: Color(0xFF1565C0),
		900: Color(0xFF0D47A1),
	});


	static FakeColor green = FakeColor({
		50: Color(0xFFE8F5E9),
		100: Color(0xFFC8E6C9),
		200: Color(0xFFA5D6A7),
		300: Color(0xFF81C784),
		400: Color(0xFF66BB6A),
		500: Color(0xFF4CAF50),
		600: Color(0xFF43A047),
		700: Color(0xFF388E3C),
		800: Color(0xFF2E7D32),
		900: Color(0xFF1B5E20),
	});

	static FakeColor yellow = FakeColor({
		50: Color(0xFFFFFDE7),
		100: Color(0xFFFFF9C4),
		200: Color(0xFFFFF59D),
		300: Color(0xFFFFF176),
		400: Color(0xFFFFEE58),
		500: Color(0xFFFFEB3B),
		600: Color(0xFFFDD835),
		700: Color(0xFFFBC02D),
		800: Color(0xFFF9A825),
		900: Color(0xFFF57F17),
	});

	static FakeColor grey = FakeColor({
		50: Color(0xFFFAFAFA),
		100: Color(0xFFF5F5F5),
		200: Color(0xFFEEEEEE),
		300: Color(0xFFE0E0E0),
		350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
		400: Color(0xFFBDBDBD),
		500: Color(0xFF9E9E9E),
		600: Color(0xFF757575),
		700: Color(0xFF616161),
		800: Color(0xFF424242),
		850: Color(0xFF303030), // only for background color in dark theme
		900: Color(0xFF212121),
	});
}


class Color {
	final int value;

	int get alpha => (0xff000000 & value) >> 24;

	/// The alpha channel of this color as a double.
	///
	/// A value of 0.0 means this color is fully transparent. A value of 1.0 means
	/// this color is fully opaque.
	double get opacity => alpha / 0xFF;

	/// The red channel of this color in an 8 bit value.
	int get red => (0x00ff0000 & value) >> 16;

	/// The green channel of this color in an 8 bit value.
	int get green => (0x0000ff00 & value) >> 8;

	/// The blue channel of this color in an 8 bit value.
	int get blue => (0x000000ff & value) >> 0;

	const Color(int value) : value = value & 0xFFFFFFFF;

	get colorString {
		return 'RGBA(${this.red}, ${this.green}, ${this.blue}, ${this.opacity})';
	}
}

class FakeColor extends Color{

	Map<int, Color> colors;
	FakeColor(Map<int, Color> colors) : super(colors[500].value) {
		this.colors = colors;
	}

	Color operator [](int index) {
		return this.colors[index];
	}
}