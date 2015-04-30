ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Root Kit plus version 1.6.1 by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure your phone has usb debugging mode enabled!
ECHO Make sure drivers are installed!
ECHO Phone screen MUST be on and unlocked!!!
ECHO 1 - Root/Unroot menu
ECHO 2 - Flash menu
ECHO 3 - Install (old working) root file manager
ECHO 4 - Install Unroot kit
ECHO 5 - Dump boot and recovery images(must have busybox and root)
ECHO 6 - Install busybox(must be rooted)
ECHO 7 - View Phone Version to get right boot/recovery images version
ECHO.
ECHO 8 - Exit this tool
ECHO.
SET /P M=Type your choice then press ENTER:
IF %M%==1 GOTO RU
IF %M%==2 GOTO FM
IF %M%==3 GOTO RFM
IF %M%==4 GOTO UK
IF %M%==5 GOTO DBR
IF %M%==6 GOTO IB
IF %M%==7 GOTO VPV
IF %M%==8 GOTO EXIT

:RU
cls
ECHO 1 - ROOT (top-down)
ECHO 2 - ROOT (bottom-up) *REQUIRES MODDED BOOT AND RECOVERY IMAGES
ECHO     OF CURRENT DEVICE FIRMWARE IN EACH FOLDER
ECHO 3 - Unroot (quick)
ECHO 4 - Unroot (full) *REQUIRES STOCK BOOT AND RECOVERY IMAGES
ECHO     OF CURRENT DEVICE FIRMWARE IN THE STOCKIMAGES FOLDER
ECHO 5 - Back to main menu
ECHO.
SET /P N=Type your choice then press ENTER:
IF %N%==1 GOTO TD
IF %N%==2 GOTO BU
IF %N%==3 GOTO UR
IF %N%==4 GOTO URF
IF %N%==5 GOTO menu

:FM
cls
ECHO 1 - Flash boot image from bootImage folder(fastboot required)
ECHO 2 - Flash recovery image from recoveryImage folder(fastboot required)
ECHO 3 - Flash a boot animation(must have busybox and root)
ECHO 4 - Flash an "update.zip" (Don't try to flash a ROM this way)
ECHO     *REQUIRES GNM RECOVERY
ECHO 5 - Flash Inopath update *REQUIRES ROOT AND STOCK BOOT/RECOVERY
ECHO     IMAGES OF CURRENT DEVICE FIRMWARE IN THE STOCKIMAGES FOLDER
ECHO 6 - Back to main menu
ECHO.
SET /P O=Type your choice then press ENTER:
IF %O%==1 GOTO FBI
IF %O%==2 GOTO FRI
IF %O%==3 GOTO FBA
IF %O%==4 GOTO FUZ
IF %O%==5 GOTO FIU
IF %O%==6 GOTO menu

:TD
adb wait-for-device
FOR /F "tokens=* USEBACKQ" %%F IN (`adb shell "dumpsys wifi | grep Wi-Fi"`) DO (
SET var=%%F
)
ECHO %var%
adb shell sleep 1
set var2=Wi-Fi is enabled
if "%var%"=="%var2%" (
ECHO Turning off wifi...
adb shell am start -a android.intent.action.MAIN -n com.android.settings/.wifi.WifiSettings
adb shell sleep 1
adb shell input keyevent 20
adb shell input keyevent 23
)
ECHO copying modded file over to device!
adb push init.qcom.sdio.sh.mod /system/etc/init.qcom.sdio.sh
ECHO rebooting
adb reboot
ECHO waiting for the device
adb wait-for-device
adb shell sleep 2
ECHO rooting...
adb push su /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
ECHO rebooting again...
adb shell sleep 2
adb reboot
adb wait-for-device
adb shell sleep 3
ECHO verifying root...
adb push su /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
adb shell sleep 2
ECHO rebooting again...
adb reboot
adb wait-for-device
ECHO waiting for phone to fully boot for 20 sec..do not touch the phone!!!
adb shell sleep 20
ECHO installing unroot tool and file manager
adb install unroot.apk
adb install es.apk
ECHO cleaning up...
adb push init.qcom.sdio.sh.orig /system/etc/init.qcom.sdio.sh
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
ECHO Done!
adb shell sleep 3
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
ECHO this has not been tested yet. If you don't want ot risk it,
ECHO press ctrl+c now
adb wait-for-device
adb shell sleep 10
ECHO preparing for update...
adb shell su -c "rm /mnt/sdcard/update.zip"
adb push updateZip\update.zip /sdcard/update.zip
ECHO device is ready!
adb shell su -c "echo '--update_package=/sdcard/update.zip' >> /cache/recovery/command"
adb reboot recovery
ECHO flashing...
ECHO use the menu key on the phone to press "reboot system now"
ECHO when the update is done
GOTO MENU

:FIU
ECHO preparing for update...
adb shell su -c "rm /mnt/sdcard/ipth_package.bin"
adb push inopathUpdate\ipth_package.bin /sdcard/ipth_package.bin
adb reboot bootloader
fastboot -i 0x0409 flash boot stockImages\boot.img
fastboot -i 0x0409 flash recovery stockImages\recovery.img
fastboot -i 0x0409 reboot
adb wait-for-device
ECHO device prepared, waiting for full boot and sdcard mount...
adb shell sleep 60
ECHO setting phone to update and rebooting...
adb shell su -c "echo '--update_package=/sdcard/ipth_package.bin' >> /cache/recovery/command"
adb reboot recovery
ECHO You will NEED to do a battery pull AFTER the update is done
ECHO (When its just the android guy with the exclamation point).
ECHO Also please keep in mind that if you want GNM recovery
ECHO of the modded boot image of the new firmware (if it exists yet)
ECHO you need to reflash it from the menu of "flash recovery"
ECHO also you will have to delete the ipth_update from your sdcard
pause
GOTO MENU