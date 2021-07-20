
export AOSP_TOPDIR=../../AOSP_11_Google
export PATH=${AOSP_TOPDIR}/prebuilts/clang/host/linux-x86/clang-r399163b/bin:$PATH
export PATH=${AOSP_TOPDIR}/prebuilts/gas/linux-x86:$PATH
export PATH=${AOSP_TOPDIR}/prebuilts/misc/linux-x86/lz4:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export LLVM=1

#cd hikey-linaro

#cp running.config .config
make meson_defconfig
cp ../running.config .config
make menuconfig

make DTC_FLAGS="-@" -j24

lz4c -f arch/arm64/boot/Image arch/arm64/boot/Image.lz4

KERN_VER=5.4

for f in arch/arm64/boot/dts/amlogic/*{g12b-a311d,sm1}-khadas-vim3*.dtb; do
    cp -v -p $f ${AOSP_TOPDIR}/device/amlogic/yukawa-kernel/${KERN_VER}/$(basename $f)
done

cp -v -p arch/arm64/boot/Image.lz4 ${AOSP_TOPDIR}/device/amlogic/yukawa-kernel/${KERN_VER}/Image.lz4
