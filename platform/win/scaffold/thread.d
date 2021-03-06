/*
 * thread.d
 *
 * This file implements the Scaffold for platform specific Thread
 * operations in Windows.
 *
 * Author: Dave Wilkinson
 *
 */

module scaffold.thread;

import core.main;
import core.definitions;
import core.string;

import synch.thread;

import platform.win.main;
import platform.win.common;

import platform.vars.mutex;
import platform.vars.semaphore;
import platform.vars.thread;
import platform.vars.condition;

/*extern(Windows)
DWORD _win_djehuty_thread_proc(void* udata)
{
	Thread t = cast(Thread)udata;

	t.run();

	ThreadPlatformVars* threadVars = ThreadGetPlatformVars(t);

	threadVars.thread = null;
	threadVars.thread_id = 0;

	ThreadUninit(t);

	return 0;
}

void ThreadStart(ref ThreadPlatformVars threadVars, ref Thread thread)
{
	threadVars.thread = CreateThread(null, 0, &_win_djehuty_thread_proc, cast(void*)thread, 0, &threadVars.thread_id);
}

void ThreadStop(ref ThreadPlatformVars threadVars)
{
	if (threadVars.thread_id == GetCurrentThreadId())
	{ // soft exit if called from the created thread
		ExitThread(0);
	}
	else
	{ // hard exit if called from another thread
		TerminateThread(threadVars.thread, 0);
	}

	threadVars.thread = null;
	threadVars.thread_id = 0;
}*/

void ThreadSleep(ref ThreadPlatformVars threadVars, ulong milliseconds) {
	while (milliseconds > 0xFFFFFFFF) {
		.Sleep(0xFFFFFFFF);

		milliseconds -= 0xFFFFFFFF;
	}
	.Sleep(cast(uint)milliseconds);
}

//bool ThreadIsCurrent(ref ThreadPlatformVars threadVars)
//{
//	return threadVars.thread_id == GetCurrentThreadId();
//}












// Semaphores

void SemaphoreInit(ref SemaphorePlatformVars semVars, ref uint initialValue) {
	semVars._semaphore = CreateSemaphoreA(null, (initialValue), 0xFFFFFFF, null);
}

void SemaphoreUninit(ref SemaphorePlatformVars semVars) {
	CloseHandle(semVars._semaphore);
}

void SemaphoreUp(ref SemaphorePlatformVars semVars) {
	ReleaseSemaphore(semVars._semaphore, 1, null);
}

void SemaphoreDown(ref SemaphorePlatformVars semVars, uint ms) {
	WaitForSingleObject(semVars._semaphore, ms);
}

void SemaphoreDown(ref SemaphorePlatformVars semVars) {
	WaitForSingleObject(semVars._semaphore, INFINITE);
}





// Mutexes

void MutexInit(ref MutexPlatformVars mutVars) {
//	InitializeCriticalSection(mutVars._mutex);
	mutVars._semaphore = CreateSemaphoreA(null, (1), 0xFFFFFFF, null);
}

void MutexUninit(ref MutexPlatformVars mutVars) {
	//DeleteCriticalSection(mutVars._mutex);
	CloseHandle(mutVars._semaphore);
}

void MutexLock(ref MutexPlatformVars mutVars) {
//	EnterCriticalSection(mutVars._mutex);
	WaitForSingleObject(mutVars._semaphore, INFINITE);
}

void MutexLock(ref MutexPlatformVars mutVars, ref uint ms) {
	// XXX: Use TryEnterCriticalSection in a timed loop here
	//EnterCriticalSection(mutVars._mutex);
	WaitForSingleObject(mutVars._semaphore, ms);
}

void MutexUnlock(ref MutexPlatformVars mutVars) {
	//LeaveCriticalSection(mutVars._mutex);
	ReleaseSemaphore(mutVars._semaphore, 1, null);
}


// Conditions

void ConditionInit(ref ConditionPlatformVars condVars) {
}

void ConditionSignal(ref ConditionPlatformVars condVars) {
}

void ConditionWait(ref ConditionPlatformVars condVars) {
}

void ConditionWait(ref ConditionPlatformVars condVars, ref MutexPlatformVars mutVars) {
}

void ConditionUninit(ref ConditionPlatformVars condVars) {
}