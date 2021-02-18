#!/usr/bin/env bash

# Halt the execution as soon as any line trows non true exit.
set -e


#==============================================================================

if [ "$1" == "" ] ;
then
        echo "Choose one of: [build, install]"
        exit 0
fi

#==============================================================================

# Change the export path for your system.

# Export path to Arm cross compiler.
if ! [[ $PATH == *"aarch64-none-linux-gnu"* ]] ;
then
        ##echo "exporting path"
        export PATH=$HOME/ExternalPackages/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin:$PATH
fi

#==============================================================================

# Show each command before executing it.
set -x

if [ "$1" == "build" ] ;
then
	make -j"$(nproc)" KERNEL_DIR=../ti-linux-kernel ARCH=arm64 \
	CROSS_COMPILE=aarch64-none-linux-gnu- build > \
	./buildmodules_log.not_patch.patch 2>&1

	exit 0

elif [ "$1" == "install" ] ;
then
	#Change installation paths according to your own need
	sudo make KERNEL_DIR=../ti-linux-kernel ARCH=arm64 \
	CROSS_COMPILE=aarch64-none-linux-gnu- prefix=run/media/varodek/ROOT/usr \
	INSTALL_MOD_PATH=/run/media/varodek/ROOT install
	
	exit 0

else
        echo "Choose one of: [build, install]"
        exit 0

fi

#==============================================================================

#End
