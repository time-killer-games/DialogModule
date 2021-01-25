cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/PureDarwin"
clang++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" -o "DlgModule (x64)/PureDarwin/libdlgmod.dylib" -std=c++17 -shared -I/opt/X11/include/X11 -L/opt/X11/lib -lX11 -fPIC -m64
