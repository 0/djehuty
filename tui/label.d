module tui.label;

import core.string;
import core.main;
import core.definitions;

import console.main;

import tui.widget;

// Section: Console

// Description: This console control abstracts a simple static text field.
class TuiLabel : TuiWidget {

	this( uint x, uint y, uint width, String text,
		  fgColor fgclr = fgColor.BrightBlue,
		  bgColor bgclr = bgColor.Black )
	{
		super(x,y,width,1);

		_forecolor = fgclr;
		_backcolor = bgclr;

		_value = new String(text);
	}

	this( uint x, uint y, uint width, string text,
		  fgColor fgclr = fgColor.BrightBlue,
		  bgColor bgclr = bgColor.Black )
	{
		super(x,y,width,1);

		_forecolor = fgclr;
		_backcolor = bgclr;

		_value = new String(text);
	}

	override void onAdd() {
	}

	override void onInit() {
		draw();
	}

	void text(String newValue) {
		_value = new String(newValue);
		draw();
	}

	void text(string newValue) {
		_value = new String(newValue);
		draw();
	}

	String text() {
		return new String(_value);
	}

	void forecolor(fgColor fgclr) {
		forecolor = fgclr;
	}

	void backcolor(bgColor bgclr) {
		_backcolor = bgclr;
	}

protected:

	void draw() {
		if (canDraw) {
			Console.setPosition(_x, _y);
			Console.setColor(_forecolor, _backcolor);

			// draw as much as we can

			if (_value.length > _width) {
				Console.put((new String(_value[0.._width])));
			}
			else {
				Console.put(_value);
			}
		}
	}

	fgColor _forecolor = fgColor.BrightBlue;
	bgColor _backcolor = bgColor.Black;

	String _value;
}