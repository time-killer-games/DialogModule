cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/MacOSX"
clang++ "DlgModule/Universal/dlgmodule.cpp" "DlgModule/MacOSX/dlgmodule.mm" "DlgModule/MacOSX/config.cpp" -o "DlgModule (x64)/MacOSX/libdlgmod.dylib" -std=c++17 -ObjC++ -framework Cocoa -shared -fPIC -m64
