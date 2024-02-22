# Clean previous runs
git clean -fdx
# Clone official 'coremark' repository or fetch latest changes/clean previous executions
if [ ! -d "coremark" ]; then
    git clone https://github.com/eembc/coremark.git
else
    cd coremark
    git fetch origin master
    git reset --hard origin/master
    git clean -fdx
    cd ..
fi
LLVM_PROJECT_BIN_PATH=/home/andres/Dev/llvm-project/build/bin/
AARCH_LIB=/usr/lib/gcc/aarch64-linux-gnu/13.2.0/
SYS_ROOT=/usr/aarch64-linux-gnu
export CC=$LLVM_PROJECT_BIN_PATH/clang
export CXX=$LLVM_PROJECT_BIN_PATH/clang++
make -C coremark compile XCFLAGS="-B$AARCH_LIB -L$AARCH_LIB -static --target=aarch64-linux-gnu --sysroot=$SYS_ROOT -fuse-ld=lld"
if [ -f "coremark/coremark.exe" ]; then
    mv coremark/coremark.exe ./coremark_nochange
fi
make -C coremark clean
make -C coremark compile XCFLAGS="-B$AARCH_LIB -L$AARCH_LIB -static --target=aarch64-linux-gnu --sysroot=$SYS_ROOT -fuse-ld=lld -mllvm -pa-emu"
if [ -f "coremark/coremark.exe" ]; then
    cp coremark/coremark.exe ./coremark_wchange
fi