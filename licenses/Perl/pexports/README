PEXPORTS 0.47 README
============================================

Anders Norlander <anorland@hem2.passagen.se>
URL: hem2.passagen.se/anorland/

Hacked by Paul.Sokolovsky@technologist.com
URL: http://www.is.lg.ua/~paul/devel/binutils.html

Hacked by Tor Lillqvist <tml@iki.fi>

Hacked by Keith Marshall <keithmarshall@users.sourceforge.net>

============================================

PEXPORTS is a program to extract exported symbols from a PE image
(executable). It can perform a simple check on the size of the
arguments of the exported functions, provided there is a header with
prototypes for the functions. This is useful when you want the
decorated function names for functions using the stdcall calling
convention. GCC is used to do the preprocessing so it must be in your
path.

Note that the Windows version uses ';' as path separator,
while if built for Cygwin (or *nix) it uses ':'.

Command line options:
=====================
        -h <header> parse header
        -o print function ordinals
        -p <preprocessor> set preprocessor
        -v verbose mode

Header files are searched for in the following directories:
1. Current directory
2. Directories in C_INCLUDE_PATH
3. Directories in CPLUS_INCLUDE_PATH

NOTE: The header parser is *very* primitive, and might be of
questionable usefulness. It only tries to find function prototypes and
check the number of arguments a function expects. It is NOT a complete
C parser, there are probably many conditions when it will fail
(especially complex parameter types), although I it works fine for me.
Please do not report bugs, but feel free to send patches.

RELEASE 0.47
=================
* Eliminate Microsoft style typedef obfuscation.
* Correct a further potential segmentation fault, resulting from
  overflow when computing 32-bit offset differences, which are then
  applied to 64-bit pointers.

RELEASE 0.46
=================
* Corrects two potential segmentation fault bugs.
* Now supports building "out-of-source", to facilitate parallel builds
  for differing hosts; (verified for mingw32, 32-bit and 64-bit linux).
* Now uses the GNU (autoconf managed) build procedure; run configure
  before make, when building, ("in-source" or "out-of-source").

RELEASE 0.45
=================
* Incorporate patches from 0.44-1-mingw32 release
* Reinstate binary distribution for mingw32 host only;
  (distributed source is host-agnostic).

RELEASE 0.44
=================
* Handle also 64-bit executables. Make it work also if built as 64-bit
  code. Remove all gcc -Wall warnings. Make it compilable also with
  MSVC. Disable Wow64 file system redirection when running as a 32-bit
  process on 64-bit Windows. Distribute just sources.

RELEASE 0.43
=================
* There were bug which led to wrong subcategorizing of symbols as
  code/data. I thought it was fixed in version on the site, but it turns
  out that almost year there was wrong version. I greatly apologize to
  everyone whom it cause problems and confusion.

RELEASE 0.42
=================
* Data/non-data symbols are now distinguished.

RELEASE 0.41
=================
* The header parser now accepts all kinds of parameters.

RELEASE 0.4
=================
* Function pointer parameters are now handled
* Handling of function attributes improved
* It is no longer always necessary to include windows.h for headers
  that required it but did not include it themselves.

RELEASE 0.3
=================
* Completely rewritten parser (the previous one was *very* bad).
  It is now possible to generate .DEF files for windows system
  dlls (kernel32,user32,gdi32,shell32 etc)
* Enhanced symbol handling (symbols are sorted in a tree).

RELEASE 0.2
=================
* Fixed bug with unnamed parameters that are pointers.
* Extra whitespace is no longer printed
* Binary versions available for mingw32 and cygwin32

RELEASE 0.1
=================
* Initial release.
Pexports, Copyright (C) 1998 Anders Norlander
This program has ABSOLUTELY NO WARRANTY; This is free software, and you are
welcome to redistribute it under certain conditions; see COPYING
for details.
