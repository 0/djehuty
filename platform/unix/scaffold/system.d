/*
 * system.d
 *
 * This Scaffold holds the System implementations for the Linux platform
 *
 * Author: Dave Wilkinson
 * Originated: May 19th, 2007
 *
 */

module scaffold.system;

import platform.vars.library;

import core.definitions;
import core.string;
import core.locale;

import platform.unix.common;

// Querying displays:

// Xinerama Extension:
// -----------------------
// XineramaQueryExtension
// XineramaQueryScreens

int SystemGetDisplayWidth(uint screen) {
	return 0;
}

int SystemGetDisplayHeight(uint screen) {
	return 0;
}

uint SystemGetPrimaryDisplay() {
	// The primary display is 0

	return 0;
}

uint SystemGetDisplayCount() {
	return 0;
}

ulong SystemGetTotalMemory() {
	return 0;
}

ulong SystemGetAvailableMemory() {
	return 0;
}

bool SystemLoadLibrary(ref LibraryPlatformVars vars, string libraryPath) {
	char[] path = libraryPath.dup ~ "\0";
	//vars.handle = dlopen(path.ptr,RTLD_LAZY);
	return vars.handle !is null;
}

void SystemFreeLibrary(ref LibraryPlatformVars vars) {
	if (vars.handle is null) { return; }
	//dlclose(vars.handle);
	vars.handle = null;
}

void* SystemLoadLibraryProc(ref LibraryPlatformVars vars, string procName) {
	if (vars.handle is null) {
		return null;
	}

	char[] proc = procName.dup ~ "\0";
	//return cast(void*)dlsym(vars.handle, proc.ptr);
	return null;
}

LocaleId SystemGetLocaleId() {
	char* res = getenv("LANG\0"c.ptr);
	string locale = cast(char[])res[0..strlen(res)];

	if (locale.length > 5) {
		locale = locale[0..5];
	}

	LocaleId ret;

	switch(locale) {
		default:
		case "en_US":
			ret = LocaleId.English_US;
			break;
		case "fr_FR":
			ret = LocaleId.French_FR;
			break;
	}

	return ret;
}
