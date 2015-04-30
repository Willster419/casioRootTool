ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Root Kit plus by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure your phone has usb debugging mode enabled!
ECHO thanks to monkeytools for his script!
ECHO you may have to enlarge the length of this window to view everything...
ECHO Make sure drivers are installed!
ECHO Phone screen MUST be on and unlocked!!!
ECHO 1 - ROOT (top-down)
ECHO 2 - ROOT (bottom-up)
ECHO 3 - Unroot (quick)
ECHO 4 - Unroot (full) REQUIRES CORRECT STOCK BOOT IMAGE/RECOVERY
ECHO 5 - Install (old working) root file manager
ECHO 6 - Install Unroot kit
ECHO 7 - Dump boot and recovery images (most likely for me)
ECHO 8 - Install busybox
ECHO 9 - View Phone Version to get right boot/recovery images version
ECHO 10 - Flash stock boot
ECHO 11 - Flash stock recovery
ECHO 12 - Flash Mod boot
ECHO 13 - Flash Mod Recovery
ECHO 14 - Reboot Recovery
ECHO 15 - Reboot Bootloader
ECHO 16 - Flash a boot animation
ECHO 17 - Flash an "update.zip"
ECHO.
ECHO 16 - Exit this tool
ECHO.
SET /P M=Type your choice then press ENTER:
IF %M%==1 GOTO TD
IF %M%==2 GOTO BU
IF %M%==3 GOTO UR
IF %M%==4 GOTO URF
IF %M%==5 GOTO RFM
IF %M%==6 GOTO UK
IF %M%==7 GOTO DBR
IF %M%==8 GOTO IB
IF %M%==9 GOTO VPV
IF %M%==10 GOTO FSB
IF %M%==11 GOTO FSR
IF %M%==12 GOTO FMB
IF %M%==13 GOTO FMR
IF %M%==14 GOTO RBR
IF %M%==15 GOTO RBB
IF %M%==16 GOTO FBA
IF %M%==17 GOTO FUZ
IF %M%==18 GOTO EXIT


:TD
ECHO Turning off wifi
adb wait-for-device
adb shell svc wifi disable
ECHO.
ECHO copying modded file over to device!
adb push init.qcom.sdio.sh.mod /system/etc/init.qcom.sdio.sh
ECHO rebooting
adb reboot
ECHO waiting for the device
adb wait-for-device
ECHO rooting...
adb push su /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
ECHO rebooting again...
adb reboot
adb wait-for-device
ECHO copying origional file to device
adb push init.qcom.sdio.sh.orig /system/etc/init.qcom.sdio.sh
ECHO verifying root...
adb shell chown root.root /system/bin/su
adb shell chmod 06755 /system/bin/su
ECHO waiting for phone to fully boot for 20 sec..do not touch the phone!!!
adb shell sleep 20
ECHO installing unroot tool and file manager
adb install unroot.apk
adb install es.apk
adb shell mount -o remount,rw /system
adb shell chmod 777 /system/etc/init.qcom.sdio.sh
adb shell mount -o remount,ro /system
adb shell mount -o remount,rw /system
ECHO Done!
GOTO MENU


:BU
ECHO Enabling fastboot!
adb wait-for-device
adb shell input keyevent 5
adb shell sleep 2
adb shell sendevent /dev/input/event1 3 53 340
adb shell sendevent /dev/input/event1 3 54 650
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 340
adb shell sendevent /dev/input/event1 3 54 625
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell input keyevent 14
adb shell input keyevent 14
adb shell input keyevent 13
adb shell input keyevent 11
adb shell input keyevent 14
adb shell input keyevent 9
adb shell input keyevent 13
adb shell input keyevent 5
adb shell input keyevent 7
adb shell input keyevent 7
adb shell input keyevent 7
adb shell input keyevent 7
adb shell input keyevent 7
adb shell input keyevent 7

adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 650
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 625
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 600
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 575
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 550
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 525
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 525
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 500
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 475
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 450
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sleep 1
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 650
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 250
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 750
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 500
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0

adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb reboot bootloader
ECHO rebooting...
fastboot -i 0x0409 flash boot modBoot\boot.img
fastboot -i 0x0409 flash recovery modRecovery\recovery.img
fastboot -i 0x0409 reboot
ECHO rebooting...
adb wait-for-device
adb reboot recovery
adb kill-server
adb start-server
adb kill-server
adb start-server
adb kill-server
adb start-server
adb kill-server
adb start-server
ECHO rooting...
adb shell mount /system
adb push su /system/bin/su
adb shell chown root.root /system/bin/su
adb shell chmod 06755 /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
adb shell chmod 644 /system/app/Superuser.apk
adb shell reboot
GOTO MENU

:UR
ECHO Unrooting!
adb wait-for-device
adb shell am start -n com.universal.unroot/com.universal.unroot.MainActivity
adb shell sleep 1
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 644
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sleep 3
adb shell sendevent /dev/input/event1 3 53 141
adb shell sendevent /dev/input/event1 3 54 495
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sleep 2
adb shell sendevent /dev/input/event1 3 53 163
adb shell sendevent /dev/input/event1 3 54 520
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
ECHO device will now reboot
adb shell sleep 10
adb kill-server
adb start-server
ECHO fixing some permissions...
adb reboot recovery
adb kill-server
adb start-server
adb kill-server
adb start-server
adb kill-server
adb start-server
adb reboot recovery
adb kill-server
adb start-server
adb reboot recovery
adb kill-server
adb start-server
adb reboot recovery
adb kill-server
adb start-server
adb reboot recovery
adb kill-server
adb start-server
adb reboot recovery
adb kill-server
adb start-server
adb kill-server
adb start-server
adb shell mount /system
adb shell mount -o remount,rw /system
adb shell chmod 777 /system/etc/init.qcom.sdio.sh
adb shell mount -o remount,ro /system
adb shell reboot
ECHO done!
GOTO MENU

:URF
ECHO Unrooting fully to COMPLETE STOCK...
adb wait-for-device
adb shell am start -n com.universal.unroot/com.universal.unroot.MainActivity
adb shell sleep 1
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 644
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sleep 3
adb shell sendevent /dev/input/event1 3 53 141
adb shell sendevent /dev/input/event1 3 54 495
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sleep 2
adb shell sendevent /dev/input/event1 3 53 163
adb shell sendevent /dev/input/event1 3 54 520
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
ECHO device will now reboot
adb shell sleep 10
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash boot stockBoot\boot.img
fastboot -i 0x0409 flash recovery stockRecovery\recovery.img
fastboot -i 0x0409 reboot
adb wait-for-device
ECHO you are now fully stock. be carefull!
GOTO MENU



:RFM
ECHO Installing Root support file manager...
adb wait-for-device
adb install es.apk
GOTO MENU


:UK
ECHO Installing Unroot kit...
adb wait-for-device
adb install unroot.apk
GOTO MENU

:DBR
ECHO Dumping boot and recovery images...
adb wait-for-device
adb shell busybox mount -o remount,rw /system
adb shell rm -r /mnt/sdcard/clockworkmod/backup/casioRootPlus
del dumpedImages\recovery.img
del dumpedImages\boot.img
adb push mkyaffs2image /system/bin/mkyaffs2image
adb push onandroid /system/bin/onandroid
adb shell chmod 755 /system/bin/mkyaffs2image
adb shell chmod 755 /system/bin/onandroid
adb shell onandroid -c casioRootPlus -a boot,recovery
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img dumpedImages\boot.img
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img dumpedImages\recovery.img
ECHO Images are in the dumpedImages folder!
adb shell sleep 2
GOTO MENU


:IB
ECHO Installing busybox...
adb wait-for-device
adb push busybox /data/local
adb shell chmod 755 /data/local/busybox
adb shell /data/local/busybox mount -o remount,rw /system
adb shell /data/local/busybox mkdir /system/xbin
adb shell /data/local/busybox cp /data/local/busybox /system/xbin/busybox
adb shell chmod 755 /system/xbin/busybox
adb shell /system/xbin/busybox --install /system/xbin
ECHO Done!
adb shell sleep 2
GOTO MENU


:VPV
ECHO opening the phone version...
adb wait-for-device
adb shell am start -n com.android.settings/.DeviceInfoSettings
adb shell sleep 1
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 650
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 625
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 600
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 575
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 550
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 525
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 525
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 500
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 475
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 240
adb shell sendevent /dev/input/event1 3 54 450
adb shell sendevent /dev/input/event1 3 50 5
adb shell sendevent /dev/input/event1 3 48 122
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
adb shell sendevent /dev/input/event1 3 53 0
adb shell sendevent /dev/input/event1 3 54 0
adb shell sendevent /dev/input/event1 3 50 0
adb shell sendevent /dev/input/event1 3 48 0
adb shell sendevent /dev/input/event1 0 2 0
adb shell sendevent /dev/input/event1 0 0 0
GOTO MENU


:FSB
adb reboot bootloader
fastboot -i 0x0409 flash boot stockBoot\boot.img
fastboot -i 0x0409 reboot
GOTO MENU


:FSR
adb reboot bootloader
fastboot -i 0x0409 flash recovery stockRecovery\recovery.img
fastboot -i 0x0409 reboot
GOTO MENU


:FMB
adb reboot bootloader
fastboot -i 0x0409 flash boot modBoot\boot.img
fastboot -i 0x0409 reboot
GOTO MENU


:FMR
adb reboot bootloader
fastboot -i 0x0409 flash recovery modRecovery\recovery.img
fastboot -i 0x0409 reboot
GOTO MENU


:RBR
adb wait-for-device
adb reboot recovery
GOTO MENU


:RBB
adb wait-for-device
adb reboot bootloader
GOTO MENU


:FBA
ECHO Flashing your boot animation!
adb shell busybox mount -o remount,rw /system
adb push bootAnimation\bootanimation /system/bin/bootanimation
adb push bootAnimation\bootanimation.zip /system/media/bootanimation.zip
adb push bootAnimation\Bootsound.mp3 /system/media/audio/ui/Bootsound.mp3
adb shell chmod 755 /system/bin/bootanimation
adb shell chmod 755 /system/media/bootanimation.zip
adb shell chmod 755 /system/media/audio/ui/Bootsound.mp3
ECHO install complete!
adb shell sleep 2
GOTO MENU


:FUZ
ECHO comming soon!
adb shell sleep 2
GOTO MENU