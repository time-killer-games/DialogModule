cd "${0%/*}"

mkdir "DlgModule (x86)"
mkdir "DlgModule (x86)/Linux"
g++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" "DlgModule/xlib/ProcInfo/helpers.cpp" "DlgModule/xlib/ProcInfo/Linux/procinfo.cpp" "DlgModule/xlib/ProcInfo/xlib/procinfo.cpp" "DlgModule/xlib/ProcInfo/POSIX/procinfo.cpp" "DlgModule/xlib/ProcInfo/Universal/procinfo.cpp" -o "DlgModule (x86)/Linux/libdlgmod.so" -DPROCINFO_SELF_CONTAINED -std=c++17 -shared -static-libgcc -static-libstdc++ -lX11 -lprocps -lpthread -fPIC -m32
