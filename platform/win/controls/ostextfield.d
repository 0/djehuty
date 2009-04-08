module platform.win.controls.ostextfield;

import controls.textfield;
import core.string;

import platform.win.definitions;
import platform.win.vars;
import platform.win.common;
import platform.win.oscontrolinterface;

import bases.window;

import platform.win.main;
import core.view;
import core.control;

class OSTextField : TextField, OSControl
{
public:
	this(int x, int y, int width, int height, String value)
	{
		super(x,y,width,height,value);
	}

	this(int x, int y, int width, int height, StringLiteral value)
	{
		super(x,y,width,height,value);
	}

	// support Events
	mixin(ControlAddDelegateSupport!("OSTextField", "TextFieldEvent"));

	override void OnAdd()
	{
	   _hWnd = CreateWindowExW(WS_EX_CLIENTEDGE, "EDIT\0", null, WS_CHILD | WS_VISIBLE | ES_AUTOHSCROLL , _x,_y,_width,_height,
			WindowGetPlatformVars(_window).hWnd,null, cast(HINSTANCE)GetWindowLongW(WindowGetPlatformVars(_window).hWnd,GWLP_HINSTANCE), null);

		SetWindowPos(_hWnd, cast(HWND)HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);

		SetWindowLongW(_hWnd, GWLP_USERDATA, cast(ulong)(cast(void*)(cast(OSControl)this)));
		_oldproc = cast(WNDPROC)SetWindowLongW(_hWnd, GWLP_WNDPROC, cast(ulong)&CtrlProc);

		SetWindowTextW(_hWnd, cast(wchar*)_value.ptr);

		SendMessageW( _hWnd, WM_SETFONT, cast(WPARAM)win_button_font, 1);
	}

	override void OnRemove()
	{
		//retrieve the data from the control's window
		wchar str[];

		int i = SendMessageW(_hWnd, WM_GETTEXTLENGTH, 0, 0);

		str = new wchar[i+2];

		GetWindowTextW(_hWnd, cast(wchar*)str.ptr, i+2);

		_value = new String(cast(StringLiteral)str);

		DestroyWindow(_hWnd);
	}

	override void setText(StringLiteral txt)
	{
		if (_window !is null)
		{
			SetWindowTextW(_hWnd, cast(wchar*)txt.ptr);
		}
		else
		{
			_value = new String(txt);
		}
	}

	override void setText(String txt)
	{
		if (_window !is null)
		{
			SetWindowTextW(_hWnd, cast(wchar*)txt.ptr);
		}
		else
		{
			_value = new String(txt);
		}
	}

	override String getText()
	{
		if (_window !is null)
		{
			//retrieve the data from the control's window
			wchar str[];

			int i = SendMessageW(_hWnd, WM_GETTEXTLENGTH, 0, 0);

			str = new wchar[i+2];

			GetWindowTextW(_hWnd, cast(wchar*)str.ptr, i+2);

			_value = new String(cast(StringLiteral)str);
		}

		return _value;
	}

protected:

	LRESULT _AppLoopMessage(uint message, WPARAM wParam, LPARAM lParam)
	{
		switch (message)
		{
		case EN_CHANGE:
			FireEvent(TextFieldEvent.Changed);
			break;
		default:
			break;
		}

		return CallWindowProcW(_oldproc, _hWnd, message, wParam, lParam);
	}

	View _ReturnView(out int x, out int y, out int w, out int h)
	{
		x = _x;
		y = _y;
		w = _width;
		h = _height;
		return _view;
	}

	HWND _hWnd;
	WNDPROC _oldproc;
}
