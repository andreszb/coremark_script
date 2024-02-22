make clean
CC=/home/andres/Dev/llvm-project/build/bin/clang
CXX=/home/andres/Dev/llvm-project/build/bin/clang++
AARCH_LIB=/usr/lib/gcc/aarch64-linux-gnu/13.2.0/
SYS_ROOT=/usr/aarch64-linux-gnu
export CC
export CXX
make compile XCFLAGS="-B$AARCH_LIB -L$AARCH_LIB -static --target=aarch64-linux-gnu --sysroot=$SYS_ROOT -fuse-ld=lld"