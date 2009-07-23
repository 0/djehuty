
MY_ARCH := $(shell uname)

DC = ldc
OBJCC = gcc
DFLAGS =

# can be changed
PLATFORM = PlatformWindows

LFLAGS_LINUX = -Iplatform/unix-L-lX11 -L-lc -L-lm -L-lrt -L-lcairo -L-lpango-1.0 -L-lpangocairo-1.0 -L-lGL -L-llua5.1 -J./tests
LFLAGS_MAC = -Iplatform/osx -lobjc -framework Cocoa -framework Foundation
LFLAGS_WIN = -Iplatform/win platform/win/lib/gdi32.lib platform/win/lib/user32.lib platform/win/lib/WS2_32.lib platform/win/lib/winmm.lib platform/win/lib/comctl32.lib platform/win/lib/msimg32.lib platform/win/lib/advapi32.lib platform/win/lib/opengl32.lib platform/win/lib/glu32.lib platform/win/lib/lua5.1.lib

ifeq (${MY_ARCH},MINGW32_NT-6.0)
	OBJEXT = .obj
else
	OBJEXT = .o
endif

DFILES_PLATFORM_MAC = platform/osx/console.d platform/osx/definitions.d platform/osx/common.d platform/osx/main.d platform/osx/scaffold.d platform/osx/vars.d platform/osx/scaffolds/graphics.d platform/osx/scaffolds/app.d platform/unix/scaffolds/file.d platform/osx/scaffolds/thread.d platform/osx/scaffolds/socket.d platform/osx/scaffolds/file.d platform/unix/scaffolds/thread.d platform/unix/vars.d platform/unix/scaffolds/socket.d platform/osx/scaffolds/window.d platform/unix/common.d platform/osx/scaffolds/color.d platform/osx/scaffolds/menu.d platform/osx/scaffolds/wave.d platform/osx/scaffolds/view.d
OBJC_FILES = platform/osx/objc/test.m platform/osx/objc/window.m platform/osx/objc/app.m platform/osx/objc/view.m

DFILES_PLATFORM_UNIX = platform/unix/scaffolds/system.d platform/unix/scaffolds/thread.d platform/unix/scaffolds/time.d platform/unix/console.d platform/unix/definitions.d platform/unix/common.d binding/cairo/cairo.d binding/x/Xlib.d binding/x/X.d platform/unix/main.d platform/unix/scaffold.d platform/unix/scaffolds/opengl.d platform/unix/vars.d platform/unix/scaffolds/graphics.d platform/unix/scaffolds/app.d platform/unix/scaffolds/file.d platform/unix/scaffolds/socket.d platform/unix/scaffolds/window.d platform/unix/scaffolds/color.d platform/unix/scaffolds/menu.d platform/unix/scaffolds/wave.d platform/unix/scaffolds/view.d platform/unix/scaffolds/directory.d
DFILES_PLATFORM_WIN = platform/win/scaffold/system.d platform/win/main.d platform/win/common.d platform/win/platform/vars/menu.d platform/win/platform/vars/view.d platform/win/platform/vars/semaphore.d platform/win/platform/vars/mutex.d platform/win/platform/vars/region.d platform/win/platform/vars/library.d platform/win/platform/vars/wave.d platform/win/platform/vars/pen.d platform/win/platform/vars/brush.d platform/win/platform/vars/window.d platform/win/platform/vars/file.d platform/win/platform/vars/directory.d platform/win/platform/vars/font.d platform/win/platform/vars/socket.d platform/win/scaffold/console.d platform/win/platform/definitions.d platform/win/scaffold/wave.d platform/win/scaffold/directory.d platform/win/scaffold/graphics.d platform/win/scaffold/thread.d platform/win/scaffold/menu.d platform/win/scaffold/window.d platform/win/scaffold/view.d platform/win/scaffold/color.d platform/win/scaffold/file.d platform/win/scaffold/socket.d platform/win/gui/osbutton.d platform/win/scaffold/time.d platform/win/widget.d platform/win/scaffold/opengl.d platform/win/widget.d platform/win/gui/apploop.d platform/win/tui/apploop.d
DFILES_PLATFORM_XOMB = platform/xomb/main.d platform/xomb/common.d platform/xomb/scaffold.d platform/xomb/vars.d platform/xomb/console.d platform/xomb/definitions.d platform/xomb/scaffolds/wave.d platform/xomb/scaffolds/graphics.d platform/xomb/scaffolds/thread.d platform/xomb/scaffolds/menu.d platform/xomb/scaffolds/window.d platform/xomb/scaffolds/view.d platform/xomb/scaffolds/color.d platform/xomb/scaffolds/file.d platform/xomb/scaffolds/socket.d platform/xomb/scaffolds/app.d platform/xomb/scaffolds/time.d platform/xomb/oscontrolinterface.d

DFILES_ANALYZING = analyzing/debugger.d
DFILES_CORE = core/event.d core/library.d core/system.d core/random.d core/regex.d core/arguments.d core/definitions.d core/application.d core/format.d core/time.d core/unicode.d core/endian.d core/stream.d core/string.d core/main.d core/color.d
DFILES_GUI = gui/container.d gui/trackbar.d gui/radiogroup.d gui/progressbar.d gui/togglefield.d gui/listfield.d gui/listbox.d gui/vscrollbar.d gui/hscrollbar.d gui/button.d gui/textfield.d gui/window.d gui/widget.d gui/application.d gui/menu.d
DFILES_UTILS = utils/stack.d utils/arraylist.d utils/linkedlist.d
DFILES_PARSING = parsing/lexer.d parsing/cfg.d
DFILES = djehuty.d
DFILES_BINARY_CODECS = codecs/binary/codec.d codecs/binary/base64.d codecs/binary/yEnc.d codecs/binary/deflate.d codecs/binary/zlib.d
DFILES_IMAGE_CODECS = codecs/image/codec.d codecs/image/all.d codecs/image/bmp.d codecs/image/png.d codecs/image/gif.d codecs/image/jpeg.d
DFILES_AUDIO_CODECS = codecs/audio/codec.d codecs/audio/all.d codecs/audio/mp2.d codecs/audio/wav.d
DFILES_GRAPHICS = graphics/bitmap.d graphics/view.d graphics/graphics.d graphics/convexhull.d graphics/region.d graphics/brush.d graphics/font.d graphics/pen.d
DFILES_NETWORKING = networking/http.d networking/telnet.d networking/irc.d
DFILES_IO = io/file.d io/directory.d io/console.d io/audio.d io/wavelet.d io/socket.d
DFILES_RESOURCE = resource/sound.d resource/image.d resource/resource.d
DFILES_CODEC = codecs/codec.d
DFILES_HASHES = hashes/digest.d hashes/all.d hashes/md5.d hashes/sha1.d hashes/sha224.d hashes/sha256.d
DFILES_CONSOLE = console/prompt.d
DFILES_TUI = tui/window.d tui/application.d tui/widget.d tui/telnet.d tui/buffer.d tui/vt100.d tui/listbox.d tui/textfield.d tui/label.d
DFILES_SCRIPTING = scripting/lua.d
DFILES_BINDING = binding/lua.d
DFILES_INTERFACES = interfaces/container.d interfaces/mod.d interfaces/list.d
DFILES_MATH = math/common.d math/vector.d math/matrix.d math/mathobject.d
DFILES_OPENGL = opengl/gl.d opengl/window.d opengl/glu.d opengl/texture.d opengl/light.d
DFILES_SPECS = specs/test.d
DFILES_TESTING = testing/dspec.d testing/support.d testing/logic.d
DFILES_SYNCH = synch/mutex.d synch/semaphore.d synch/thread.d synch/timer.d

DFILES_RSC = 

OBJS_CORE = $(DFILES:.d=.o) $(DFILES_RESOURCE:.d=.o) $(DFILES_IO:.d=.o) $(DFILES_SYNCH:.d=.o) $(DFILES_PARSING:.d=.o) $(DFILES_OPENGL:.d=.o) $(DFILES_TUI:.d=.o) $(DFILES_ANALYZING:.d=.o) $(DFILES_SCRIPTING:.d=.o) $(DFILES_BINDING:.d=.o) $(DFILES_SPECS:.d=.o) $(DFILES_TESTING:.d=.o) $(DFILES_MATH:.d=.o) $(DFILES_GRAPHICS:.d=.o) $(DFILES_HASHES:.d=.o) $(DFILES_RSC:.d=.o) $(DFILES_NETWORKING:.d=.o) $(DFILES_INTERFACES:.d=.o) $(DFILES_UTILS:.d=.o) $(DFILES_CONSOLE:.d=.o) $(DFILES_BINARY_CODECS:.d=.o) $(DFILES_CODEC:.d=.o) $(DFILES_IMAGE_CODECS:.d=.o) $(DFILES_AUDIO_CODECS:.d=.o) $(DFILES_CORE:.d=.o) $(DFILES_GUI:.d=.o) $(DFILES_PARSERS:.d=.o)

OBJS_MAC = $(OBJS_CORE) $(DFILES_PLATFORM_MAC:.d=.o) $(OBJC_FILES:.m=.o)

OBJS_LINUX = $(OBJS_CORE) $(DFILES_PLATFORM_UNIX:.d=.o)

OBJS_WIN = $(OBJS_CORE:.o=.obj) $(DFILES_PLATFORM_WIN:.d=.obj)

OBJS_XOMB = $(OBJS_CORE:.o=_xomb.obj) $(DFILES_PLATFORM_XOMB:.d=_xomb.obj)

TOOLS_DSPEC = tools/dspec/main.d tools/dspec/feeder.d tools/dspec/filelist.d tools/dspec/ast.d tools/dspec/parser.d tools/dspec/parseunit.d tools/dspec/output.d
TOOLS_DSCRIBE = tools/dscribe/main.d tools/dscribe/lexer.d

EXAMPLES_TUITETRIS = examples/tuitetris/app.d examples/tuitetris/gamewindow.d examples/tuitetris/tetris.d examples/tuitetris/gamecontrol.d

libdeps_linux: $(OBJS_LINUX)
	@echo ">> framework compilation complete. <<"

libdeps_mac: $(OBJS_MAC)
	@echo ">> framework compilation complete. <<"

libdeps_win: $(OBJS_WIN)
	@echo ">> framework compilation complete. <<"

libdeps_xomb: $(OBJS_XOMB)
	@echo ">> framework compilation complete. <<"

# compile D files
%.o: %.d
	@echo \-\-\-\> $<
ifeq (${MY_ARCH},Darwin)
	@$(DC) $(DFLAGS) -fversion=PlatformOSX -c $< -o $@ -O3 -J./tests
else
ifeq ("${MY_ARCH}","MINGW32_NT-6.0")
else
	@$(DC) $< $(DFLAGS) -d-version=PlatformLinux -c -of$@ -O3 -J./tests
endif
endif

%_xomb.obj: %.d
	@echo \-\-\-\> $<
ifeq (${MY_ARCH},Darwin)
else
ifeq ("${MY_ARCH}","MINGW32_NT-6.0")
	@dmd.exe -w -c -of$@ -J./tests -version=PlatformXOmB -unittest $<
else
endif
endif

%.obj: %.d
	@echo \-\-\-\> $<
ifeq (${MY_ARCH},Darwin)
else
ifeq ("${MY_ARCH}","MINGW32_NT-6.0")
	@dmd.exe -w -c -of$@ -J./tests $(DFLAGS) -version=PlatformWindows -Iplatform/win -unittest $<
else
endif
endif

# compile Objective-C files
%.o: %.m
	@echo \-\-\-\> \(objc\) $<
ifeq (${MY_ARCH},Darwin)
	@$(OBJCC) $(OBJCFLAGS) -c $< -o $@ -O3
else
endif

# initiates the compilation of the main framework
lib:
	@echo compiling framework... Target: ${MY_ARCH}
ifeq (${MY_ARCH},Darwin)
	@echo OS X detected...
	@make libdeps_mac
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@echo Windows detected...
	@make libdeps_win
else
	@echo UNIX detected...
	@make libdeps_linux
endif
endif



app: libdeps_xomb

	@echo compiling test program...
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@lib -c -p64 djehutyxomb.lib $(OBJS_XOMB) $(LFLAGS_WIN)
endif

	@echo linking...
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@dmd.exe -w -version=PlatformXOmB -unittest app.d djehutyxomb.lib
endif





# compiles the library framework, and then the test app
all: lib

	@echo compiling test program...
ifeq (${MY_ARCH},Darwin)
	@$(DC) -c winsamp.d -o winsamp.o -fversion=PlatformOSX
endif


	@echo linking...
ifeq (${MY_ARCH},Darwin)
	@$(DC) $(LFLAGS_MAC) -o winsamp winsamp.o $(OBJS_MAC)
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	dmd.exe -w -version=$(PLATFORM) winsamp.d $(OBJS_WIN) $(LFLAGS_WIN)
else
	@$(DC) $(LFLAGS_LINUX) -d-version=PlatformLinux winsamp.d $(OBJS_LINUX)
endif
endif

dspec: lib

	@echo compiling DSpec and linking...
ifeq (${MY_ARCH},Darwin)
	#@$(DC) $(LFLAGS_MAC) -o winsamp winsamp.o $(OBJS_MAC)
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@dmd.exe -w -version=$(PLATFORM) -ofdspec.exe $(TOOLS_DSPEC) $(OBJS_WIN) $(LFLAGS_WIN)
else
	@$(DC) $(LFLAGS_LINUX) -ofdspec -d-version=PlatformLinux $(TOOLS_DSPEC) $(OBJS_LINUX)
endif
endif

dscribe: lib

	@echo compiling DScribe and linking...
ifeq (${MY_ARCH},Darwin)
	#@$(DC) $(LFLAGS_MAC) -o winsamp winsamp.o $(OBJS_MAC)
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@dmd.exe -w -version=$(PLATFORM) -ofdscribe.exe $(TOOLS_DSCRIBE) $(OBJS_WIN) $(LFLAGS_WIN)
else
	@$(DC) $(LFLAGS_LINUX) -ofdscribe -d-version=PlatformLinux $(TOOLS_DSCRIBE) $(OBJS_LINUX)
endif
endif

tuitetris: lib

	@echo compiling TuiTetris example and linking...
ifeq (${MY_ARCH},Darwin)
	#@$(DC) $(LFLAGS_MAC) -o tuitetris winsamp.o $(OBJS_MAC)
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	@dmd.exe -w -version=$(PLATFORM) -oftuitetris.exe $(EXAMPLES_TUITETRIS) $(OBJS_WIN) $(LFLAGS_WIN)
else
	@$(DC) $(LFLAGS_LINUX) -oftuitetris -d-version=PlatformLinux $(EXAMPLES_TUITETRIS) $(OBJS_LINUX)
endif
endif



clean:
ifeq (${MY_ARCH},Darwin)
	rm -f $(OBJS_MAC)
else
ifeq (${MY_ARCH},MINGW32_NT-6.0)
	rm -f $(OBJS_WIN)
else
	rm -f $(OBJS_LINUX)
endif
endif
