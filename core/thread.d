module core.thread;

// TODO: Awww... my only runtime dependency
version(LDC)
{
	import Tango = tango.core.Thread;
}
else
{
	import Phobos = std.thread;
}

import platform.imports;
mixin(PlatformGenericImport!("vars"));
mixin(PlatformGenericImport!("definitions"));
mixin(PlatformScaffoldImport!());

// Access to the threads array
import core.main;

// Section: Core/Synchronization

// Description: This class represents a thread.  You can create and override the call function to use, or use a delegate to specify an external function to call.
class Thread
{

public:

	// Description: Will create a normal thread that does not have any external callback functions.
	this()
	{
		stdThread = new overrideThread();
		stdThread.thread = this;

		startTime = time = Scaffold.TimeGet();
	}

	// Description: Will create a thread using the given delegate as the callback function.
	this(void delegate(bool) callback)
	{
		_thread_callback = callback;
		_thread_f_callback = null;

		stdThread = new overrideThread();
		stdThread.thread = this;

		startTime = time = Scaffold.TimeGet();
	}

	// Description: Will create a thread using the given function as the callback function.
	this(void function(bool) callback)
	{
		_thread_f_callback = callback;
		_thread_callback = null;

		stdThread = new overrideThread();
		stdThread.thread = this;
	}

	~this()
	{
		stop();
	}

	// the common function for the thread

	// Description: This will be called upon execution of the thread.  Normally, it will call the delegate, but if overriden, you can provide a function within the class to use as the execution space.
	void run()
	{
		if (_thread_callback !is null)
		{
			_thread_callback(false);
		}
		else if (_thread_f_callback !is null)
		{
			_thread_f_callback(false);
		}

		_inited = false;
	}

	// Description: This will allow an arbitrary member function to be used as the execution space.
	// callback: An address to a member function or a delegate literal.
	void setDelegate(void delegate(bool) callback)
	{
		_thread_callback = callback;
		_thread_f_callback = null;
	}

	// Description: This will allow an arbitrary function to be used as the execution space.
	// callback: An address to a function or a function literal.
	void setDelegate(void function(bool) callback)
	{
		_thread_f_callback = callback;
		_thread_callback = null;
	}

	// Description: This function will tell whether or not the current thread being executed is the thread created via this class.
	// Returns: Will return true when this thread is the current thread executing and false otherwise.
	bool isCurrentThread()
	{
		if (_inited)
		{
			return cast(bool)stdThread.isSelf(); //return Scaffold.ThreadIsCurrent(_pfvars);
		}

		return false;
	}

	// Description: This function will yield the thread for a certain amount of time.
	// milliseconds: The number of milliseconds to yield.
	void sleep(ulong milliseconds)
	{
		// we are given a long for length, windows only has an int function
		if (_inited)
		{
			Scaffold.ThreadSleep(_pfvars, milliseconds);
		}
	}

	// Description: This function will start the thread and call the threadProc() function, which will in turn execute an external delegate if provided.
	void start()
	{
		RegisterThread(this);

		if (!_inited)
		{
			//Scaffold.ThreadStart(_pfvars, this);

			startTime = time = Scaffold.TimeGet();

			if (stdThread is null)
			{
				stdThread = new overrideThread();
			}

			stdThread.start();
			_inited = true;
		}
	}

	// Description: This function will stop the thread prematurely.
	void stop()
	{
		if (_inited)
		{
			//Scaffold.ThreadStop(_pfvars);
			stdThread = null;
		}
		_inited = false;
	}

	void pleaseStop()
	{
		if (_thread_callback !is null)
		{
			_thread_callback(true);
		}
		else if (_thread_f_callback !is null)
		{
			_thread_f_callback(true);
		}
	}

	uint getElapsed()
	{
		return Scaffold.TimeGet() - time;
	}

	uint getDelta()
	{
		uint oldTime = time;
		time = Scaffold.TimeGet();

		return time - oldTime;
	}

protected:

	void delegate (bool) _thread_callback = null;
	void function (bool) _thread_f_callback = null;

	int _threadProc()
	{
		run();

		stdThread = null;

		return 0;
	}

	bool _inited;

	uint startTime;
	uint time;

	ThreadPlatformVars _pfvars;

	overrideThread stdThread;

version(GNU)
{
}
version(LDC)
{
	class overrideThread : Tango.Thread
	{
		Thread thread;

		this()
		{
			super(&run);
		}

		void run()
		{
			Thread.run();

			stdThread = null;

			UnregisterThread(thread);

			return 0;
		}

		bool isSelf()
		{
			// TODO: IMPLEMENT
			return false;
		}
	}
}
else
{
	class overrideThread : Phobos.Thread
	{
		Thread thread;

		override int run()
		{
			Thread.run();

			stdThread = null;

			UnregisterThread(thread);

			return 0;
		}
	}
}
}

ThreadPlatformVars* ThreadGetPlatformVars(ref Thread t)
{
	return &t._pfvars;
}


void ThreadUninit(ref Thread t)
{
	t._inited = false;
}
