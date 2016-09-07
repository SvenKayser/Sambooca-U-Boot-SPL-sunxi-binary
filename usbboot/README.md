Here you find U-Boot with SPL for the respective boards mentioned, with detection of USB devices and also, as opposed to standard u-Boot, preference to boot from USB device.

Effectively this means: While SPL and U-Boot come from the SD card or eMMC, U-Boot will boot any connected USB Mass Storage that has the required files on it even if the SD-Card or the eMMC contains a valid system as well.

You can write the bootloader to any working SD card or eMMC installation, or just use it on an empty sd card or eMMC by invoking:
```
dd if=(yourboard)-u-boot-sunxi-with-spl.bin of=/dev/(yourblockdevice) bs=8192 seek=1 oflag=direct
```
