module gui.trackbar;

import gui.widget;

import core.color;
import core.definitions;
import core.string;
import core.graphics;

template ControlPrintCSTRList()
{
	const char[] ControlPrintCSTRList = `
	this(int x, int y, int width, int height)
	{
		super(x,y,width,height);
	}


	`;
}

class TrackBar : Widget
{

	enum Signal : uint
	{
		Changed,
	}

	// Description: This will create a button with the specified dimensions and text.
	this(int x, int y, int width, int height)
	{
		super(x,y,width,height);
	}

	override void onDraw(ref Graphics g)
	{
		Brush brsh = new Brush(Color.Red);

		g.setBrush(brsh);

		g.drawRect(_x, _y, _r, _b);

		int barWidth;

		barWidth = cast(int)(cast(float)_width * (cast(float)(_value - _min) / cast(float)(_max - _min)));

		//writefln("barwidth: ", barWidth, " width: ", _width, " value: ", _value, " max: ", _max);

		brsh.setColor(Color.Green);
		g.setBrush(brsh);

		g.drawRect(_x, _y, barWidth + _x, _b);

	}

	void setRange(long min, long max)
	{
		_min = min;
		_max = max;

		if (_min > _max) { _min = _max; }
		if (_value < _min) { _value = _min; }
		if (_value > _max) { _value = _max; }
	}

	void getRange(out long min, out long max)
	{
		min = _min;
		max = _max;
	}

	void setValue(long value)
	{
		_value = value;

		if (_value < _min) { _value = _min; }
		if (_value > _max) { _value = _max; }
	}

	long getValue()
	{
		return _value;
	}

	void setTickFrequency(ulong freq)
	{
		_tickFreq = freq;
	}

	ulong getTickFrequency()
	{
		return _tickFreq;
	}

protected:

	long _min = 0;
	long _max = 100;
	long _value = 0;

	ulong _tickFreq;
}