cd "${0%/*}"

mkdir "DlgModule (x86)"
mkdir "DlgModule (x86)/Linux"
g++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" -o "DlgModule (x86)/Linux/libdlgmod.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -lX11 -lprocps -lpthread -fPIC -m32
