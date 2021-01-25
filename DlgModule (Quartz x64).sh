cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/Quartz"
clang++ -c -ObjC "DlgModule/xlib/quartz/dlgmodule.m" "DlgModule/xlib/quartz/subclass.m" -fPIC -m64
clang++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "dlgmodule.o" "subclass.o" -o "DlgModule (x64)/Quartz/libdlgmod.dylib" -std=c++17 -shared -framework Cocoa -fPIC -m64
rm -f "dlgmodule.o" "subclass.o"
