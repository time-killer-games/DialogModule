cd "${0%/*}"

mkdir "DlgModule (x86)"
mkdir "DlgModule (x86)/FreeBSD"
g++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" -o "DlgModule (x86)/FreeBSD/libdlgmod.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -lX11 -lutil -lpthread -fPIC -m32
