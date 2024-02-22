if [ ! -d "coremark" ]; then
    git clone https://github.com/eembc/coremark.git
else
    cd coremark
    git fetch origin master
    git reset --hard origin/master
    git clean -fdx
    cd ..
fi
LLVM_PROJECT_BIN_PATH=/home/andres/Dev/llvm-project/build/bin
AARCH_LIB=/usr/lib/gcc/aarch64-linux-gnu/13.2.0/
SYS_ROOT=/usr/aarch64-linux-gnu
export CC=$LLVM_PROJECT_BIN_PATH/clang
CXX=$LLVM_PROJECT_BIN_PATH/clang++
export CC
export CXX
make -C coremark compile XCFLAGS="-B$AARCH_LIB -L$AARCH_LIB -static --target=aarch64-linux-gnu --sysroot=$SYS_ROOT -fuse-ld=lld"
if [ -f "coremark/coremark.exe" ]; then
    cp coremark/coremark.exe .
fi