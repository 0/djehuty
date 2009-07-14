/*
 * textfield.d
 *
 * This module implements a text field widget for TUI applications.
 *
 * Author: Dave Wilkinson, Lindsey Bieda
 *
 */

module tui.textfield;

import core.string;
import core.main;
import core.definitions;
import core.unicode;

import console.main;

import tui.widget;

// Section: Console

// Description: This console control abstracts a simple one line text field.
class TuiTextField : TuiWidget {

	// Constructors

	this( uint x, uint y, uint width, string value = "") {
		super(x,y,width,1);

		_max = width-2;

		_value = new String(value);
	}

	// Events

	override void onAdd() {
	}

	override void onInit() {
		draw();
	}


	override void onKeyDown(uint keyCode) {

		Console.setColor(_forecolor, _backcolor);
		if (keyCode == KeyBackspace) {
			if (_pos > 0) {
				if (_pos == _max) {
					Console.put(' ');
					_value = _value.subString(0,_value.length-1);
				}
				else {
					Console.put(cast(char)0x8);
					Console.put(' ');
					_value = _value.subString(0, _pos-1) ~ _value.subString(_pos);
				}

				Console.put(cast(char)0x8);

				_pos--;
			}
		}
		else if (keyCode == KeyTab || keyCode == KeyReturn || keyCode == 10) {
			_window.tabForward();
		}
	}

	override void onKeyChar(dchar keyChar) {

		Console.setColor(_forecolor, _backcolor);
		if (keyChar != 0x8 && keyChar != '\t' && keyChar != '\n' && keyChar != '\r') {
			if (_pos <= _max) {
				Console.put(keyChar);

				_pos++;

				if (_pos >= _max) {
					_pos = _max;
					_value = _value.subString(0, _value.length-1) ~ keyChar;
					Console.put(cast(char)(0x8));
				}
				else {
					_value = _value.subString(0, _pos-1) ~ keyChar ~ _value.subString(_pos-1);
				}
			}
		}
	}

	override void onGotFocus() {
		Console.showCaret();

		positionCursor();

		Console.setColor(_forecolor, _backcolor);
	}

	// Properties

	// Description: This property returns the current text within the field.
	// Returns: The value of the field.
	string text() {
		return _value.toString();
	}

	// Description: This property sets the current text within the field.
	// text: The new value for the field.
	void text(string text) {
		_value = new String(text);
		draw();
	}

	fgColor forecolor() {
		return _forecolor;
	}

	void forecolor(fgColor value) {
		_forecolor = value;
		draw();
	}

	bgColor backcolor() {
		return _backcolor;
	}

	void backcolor(bgColor value) {
		_backcolor = value;
		draw();
	}

	fgColor basecolor() {
		return _color;
	}

	void basecolor(fgColor value) {
		_color = value;
	}

	// Methods

	override bool isTabStop() {
		return true;
	}

protected:

	fgColor _color = fgColor.BrightBlue;
	fgColor _forecolor = fgColor.BrightWhite;
	bgColor _backcolor = bgColor.Black;

	uint _pos = 0;
	uint _max = 0;

	String _value;

	void draw() {
		if (canDraw) {
			Console.setPosition(_x, _y);
			Console.setColor(_color, bgColor.Black);
			Console.put("[");

			Console.setColor(_forecolor, _backcolor);

			foreach(chr; _value.subString(0,_width-2)) {
				Console.put(chr);
			}

			_pos = _value.length;

			for (int i=_value.length; i<_max; i++) {
				Console.put(' ');
			}

			Console.setColor(_color, bgColor.Black);

			Console.put("]");
			
			positionCursor();
		}
	}
	
	void positionCursor() {
		if (_pos == _max) {
			Console.setPosition(_x+_max, _y);
		}
		else {
			Console.setPosition(_x+1+_pos, _y);
		}
	}
}