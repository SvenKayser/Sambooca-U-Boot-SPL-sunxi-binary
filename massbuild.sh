#!/bin/bash
task(){
	echo -e "[ .. ] \033[1;33m$1\033[0m" 
}
tdone(){
	echo -e "[ \033[1;32mok\033[0m ] \033[0;32mDone\033[0m\n"
}
terror(){
	echo -e "[ \033[1;31m!!\033[0m ] \033[0;31m$1\033[0m\n"
}

tinfo(){
	echo -e "[ .. ]		\033[0;33m$1\033[0m" 
}


platforms=("bananapi-m2-plus" "beelink-x2" "nanopi-m1" "nanopi-neo" "orangepi-2" "orangepi-lite" "orangepi-pc" "orangepi-pc-plus" "orangepi-one")

pushd ..

cp .config .config.sav
for pf in "${platforms[@]}"
do
	task "cardboot for ${pf}"
	cat sambooca/cfg/h3base sambooca/cfg/${pf} > .config
	make -s CROSS_COMPILE=armv7a-hardfloat-linux-gnueabihf- ARCH="arm"
	cp u-boot-sunxi-with-spl.bin sambooca/cardboot/${pf}-u-boot-sunxi-with-spl.bin
	tdone
done

for pf in "${platforms[@]}"
do
	task "usbboot for ${pf}"
	cat sambooca/cfg/h3base sambooca/cfg/${pf} usbbot > .config
	make -s CROSS_COMPILE=armv7a-hardfloat-linux-gnueabihf- ARCH="arm"
	cp u-boot-sunxi-with-spl.bin sambooca/usbboot/${pf}-u-boot-sunxi-with-spl.bin
	tdone
done

cp .config.sav .config

popd 
