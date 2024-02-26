# QARMA library library path
QARMA64_LIB=${QARMA64_LIB:-"/change/to/qarma64/lib/path"}
# LLVM binaries path
LLVM_BIN=${LLVM_BIN:-"/change/to/llvm/bin/path"}
# AArch64-linux-gnu directory
SYSROOT_DIR=${SYSROOT_DIR:-"/change/to/aarch64-linux-gnu/sysroot/directory"}

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
export CC=$LLVM_BIN/clang
export CXX=$LLVM_BIN/clang++
make -C coremark compile XCFLAGS="-static --target=aarch64-linux-gnu --sysroot=$SYSROOT_DIR -fuse-ld=lld -lstdc++"
if [ -f "coremark/coremark.exe" ]; then
    mv coremark/coremark.exe ./coremark_nochange
fi
make -C coremark clean
make -C coremark compile XCFLAGS="-static --target=aarch64-linux-gnu --sysroot=$SYSROOT_DIR -L$QARMA64_LIB -lQarma64 -fuse-ld=lld -mllvm -pa-emu -lstdc++"
if [ -f "coremark/coremark.exe" ]; then
    cp coremark/coremark.exe ./coremark_wchange
fi