ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Root Kit plus version 1.5 by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure your phone has usb debugging mode enabled!
ECHO thanks to monkeytools for his script!
ECHO you may have to enlarge the length of this window to view everything...
ECHO Make sure drivers are installed!
ECHO Phone screen MUST be on and unlocked!!!
ECHO 1 - ROOT (top-down)
ECHO 2 - ROOT (bottom-up) REQUIRES CORECT MODDED BOOT/RECOVERY IMAGE IN EACH FOLDER
ECHO 3 - Unroot (quick)
ECHO 4 - Unroot (full) REQUIRES CORRECT STOCK BOOT IMAGE/RECOVERY IN STOCKIMAGES FOLDER
ECHO 5 - Install (old working) root file manager
ECHO 6 - Install Unroot kit
ECHO 7 - Dump boot and recovery images(must have busybox and root)
ECHO 8 - Install busybox(must be rooted)
ECHO 9 - View Phone Version to get right boot/recovery images version
ECHO 10 - Flash boot image(must have fastboot enabled)
ECHO 11 - Flash recovery image(must have fastboot enabled)
ECHO 12 - Flash a boot animation(must have busybox and root)
ECHO 13 - Flash an "update.zip"
ECHO 14 - Flash Inopath update REQUIRES ROOT AND CORRECT STOCK BOOT IMAGE/RECOVERY IN STOCKIMAGES FOLDER
ECHO.
ECHO 15 - Exit this tool
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
IF %M%==10 GOTO FBI
IF %M%==11 GOTO FRI
IF %M%==12 GOTO FBA
IF %M%==13 GOTO FUZ
IF %M%==14 GOTO FIU
IF %M%==15 GOTO EXIT


:TD
ECHO Turning off wifi
adb wait-for-device
adb shell svc wifi disable
ECHO copying modded file over to device!
adb push init.qcom.sdio.sh.mod1 /system/etc/init.qcom.sdio.sh
ECHO rebooting
adb reboot
ECHO waiting for the device
adb wait-for-device
adb shell sleep 3
ECHO rooting...
adb push su /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
ECHO verifying root...
adb shell sleep 5
adb push init.qcom.sdio.sh.mod2 /system/etc/init.qcom.sdio.sh
ECHO rebooting again...
adb shell sleep 2
adb reboot
adb wait-for-device
adb shell sleep 3
ECHO verifying root...
adb shell sleep 2

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
fastboot -i 0x0409 flash boot bootImage\boot.img
fastboot -i 0x0409 flash recovery recoveryImage\recovery.img
fastboot -i 0x0409 reboot
ECHO rebooting again...
adb wait-for-device
adb reboot recovery
ECHO Waiting for recovery...
ping 1.1.1.1 -n 1 -w 15000 > nul
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
ping 1.1.1.1 -n 1 -w 3000 > nul
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
fastboot -i 0x0409 flash boot stockImages\boot.img
fastboot -i 0x0409 flash recovery stockImages\recovery.img
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
adb shell su -c "busybox mount -o remount,rw /system"
adb shell su -c "rm -r /mnt/sdcard/clockworkmod/backup/casioRootPlus"
del dumpedImages\recovery.img
del dumpedImages\boot.img
adb push mkyaffs2image /sdcard/mkyaffs2image
adb push onandroid /sdcard/onandroid
adb shell su -c "busybox cp /sdcard/mkyaffs2image /system/bin/mkyaffs2image"
adb shell su -c "busybox cp /sdcard/onandroid /system/bin/onandroid"
adb shell su -c "rm /sdcard/onandroid"
adb shell su -c "rm /sdcard/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/onandroid"
adb shell su -c "onandroid -c casioRootPlus -a boot,recovery"
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img dumpedImages\boot.img
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img dumpedImages\recovery.img
ECHO Images are in the dumpedImages folder!
adb shell sleep 2
GOTO MENU


:IB
ECHO Installing busybox...
adb wait-for-device
adb push busybox /data/local
adb shell su -c "chmod 755 /data/local/busybox"
adb shell su -c "/data/local/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/busybox mkdir /system/xbin"
adb shell su -c "/data/local/busybox cp /data/local/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
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


:FBI
ECHO flashing the boot image
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash boot bootImage\boot.img
fastboot -i 0x0409 reboot
ECHO Done!
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO Menu


:FRI
ECHO flashing the recovery image
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash recovery recoveryImage\recovery.img
fastboot -i 0x0409 reboot
ECHO Done!
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO Menu


:FBA
ECHO Flashing your boot animation!
adb wait-for-device
adb shell su -c "busybox mount -o remount,rw /system"
adb push bootAnimation\bootanimation /sdcard/bootanimation
adb push bootAnimation\bootanimation.zip /sdcard/bootanimation.zip
adb push bootAnimation\Bootsound.mp3 /sdcard/Bootsound.mp3
adb shell su -c "busybox cp /sdcard/bootanimation /system/bin/bootanimation" 
adb shell su -c "busybox cp /sdcard/bootanimation.zip /system/media/bootanimation.zip
adb shell su -c "busybox cp /sdcard/Bootsound.mp3 /system/media/audio/ui/Bootsound.mp3"
adb shell su -c "busybox chmod 755 /system/bin/bootanimation"
adb shell su -c "busybox chmod 755 /system/media/bootanimation.zip"
adb shell su -c "busybox chmod 755 /system/media/audio/ui/Bootsound.mp3"
adb shell su -c "busybox rm /sdcard/bootanimation"
adb shell su -c "busybox rm /sdcard/bootanimation.zip"
adb shell su -c "busybox rm /sdcard/Bootsound.mp3"
ECHO install complete!
adb shell sleep 2
GOTO MENU


:FUZ
ECHO comming soon!
adb shell sleep 1
GOTO MENU


:FIU
ECHO preparing for update...
adb reboot bootloader
fastboot -i 0x0409 flash boot stockImages\boot.img
fastboot -i 0x0409 flash recovery stockImages\recovery.img
fastboot -i 0x0409 reboot
adb wait-for-device
ECHO device detected, waiting for full boot and sdcard mount...
adb shell sleep 60
ECHO pushing update and rebooting...
adb shell su -c "rm /mnt/sdcard/ipth_package.bin"
adb push inopathUpdate\ipth_package.bin /sdcard/ipth_package.bin
adb shell su -c "echo '--update_package=/sdcard/ipth_package.bin' >> /cache/recovery/command"
adb reboot recovery
ECHO You will NEED to do a battery pull AFTER the update is done
ECHO a.k.a. when the progress bar goes away and its just
ECHO the android guy with the exclamation point.
ECHO Also please keep in mind that if you want modded boot/
ECHO recovery images you MUST reflash them from the menu
ECHO also you will have to delete the ipth_update from your sdcard
ping 1.1.1.1 -n 1 -w 30000 > nul
GOTO MENU