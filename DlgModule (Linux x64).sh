cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/Linux"
g++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" -o "DlgModule (x64)/Linux/libdlgmod.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -lX11 -lprocps -lpthread -fPIC -m64
