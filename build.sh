#!/bin/bash

KERNEL_VERSION=5.6.19
# KERNEL_VERSION=6.10.7

KERNEL_MAJOR=$(echo $KERNEL_VERSION | cut -d '.' -f1)
KERNEL_MINOR=$(echo $KERNEL_VERSION | cut -d '.' -f2)
KERNEL_PATCH=$(echo $KERNEL_VERSION | cut -d '.' -f3)


echo "Fetching specified kernel"
wget "https://cdn.kernel.org/pub/linux/kernel/v"$KERNEL_MAJOR".x/linux-"$KERNEL_VERSION".tar.xz"


echo "Extracting Kernel"
tar -xf linux-"$KERNEL_VERSION".tar.xz

echo "Copying dtsi and pyra_defconfig file to kernel folder"

cp config/* linux-"$KERNEL_VERSION"/arch/arm/configs
cp dtsi/* linux-"$KERNEL_VERSION"/arch/arm/boot/dts

# Still need a kernel conf here before this is useful
#echo "Building as a .deb file" 
make ARCH=armhf CROSS_COMPILE=arm-linux-gnueabihf- pyra_defconf bindeb-pkg -j `nproc`

#echo "building DTBS"
make ARCH=armhf CROSS_COMPILE=arm-linux-gnueabihf- pyra_defconfig dtbs -j `nproc`