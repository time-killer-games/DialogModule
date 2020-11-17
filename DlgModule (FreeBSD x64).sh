cd "${0%/*}"

mkdir "DlgModule (x64)"
mkdir "DlgModule (x64)/FreeBSD"
g++ "DlgModule/dlgmodule.cpp" "DlgModule/xlib/dlgmodule.cpp" "DlgModule/xlib/lodepng/lodepng.cpp" "DlgModule/xlib/ProcInfo/helpers.cpp" "DlgModule/xlib/ProcInfo/FreeBSD/procinfo.cpp" "DlgModule/xlib/ProcInfo/xlib/procinfo.cpp" "DlgModule/xlib/ProcInfo/POSIX/procinfo.cpp" "DlgModule/xlib/ProcInfo/Universal/procinfo.cpp" -o "DlgModule (x64)/FreeBSD/libdlgmod.so" -DPROCINFO_SELF_CONTAINED -std=c++17 -shared -static-libgcc -static-libstdc++ -lX11 -lprocstat -lutil -lc -lpthread -fPIC -m64
