cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/MacOSX"
clang++ -c -ObjC "DlgModule/MacOSX/Cocoa/dlgmodule.m" -fPIC -m64
clang++ "DlgModule/dlgmodule.cpp" "DlgModule/MacOSX/dlgmodule.cpp" "DlgModule/MacOSX/config/config.cpp" "dlgmodule.o" -o "DlgModule (x64)/MacOSX/libdlgmod.dylib" -std=c++17 -framework Cocoa -shared -fPIC -m64
rm -f "dlgmodule.o"
