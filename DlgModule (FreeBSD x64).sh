cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/FreeBSD"
clang++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" -o "DlgModule (x64)/FreeBSD/libdlgmod.so" -std=c++17 -shared -lX11 -lutil -lpthread -fPIC -m64
