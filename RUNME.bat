ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Root Tool Plus version 1.8 by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure your phone has usb debugging mode enabled!
ECHO Make sure drivers are installed!
ECHO Phone screen MUST be on and unlocked!!!
ECHO 1 - Root/Unroot menu
ECHO 2 - Flash menu
ECHO 3 - Install (old working) root file manager
ECHO 4 - Install Unroot tool
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
ECHO 2 - ROOT (bottom-up)
ECHO     *Requires modded boot and recovery images
ECHO 3 - Unroot (quick)
ECHO 4 - Unroot (full)
ECHO     *Requires stock boot and recovery images
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
ECHO     *requires GNM recovery
ECHO 5 - Flash Inopath update 
ECHO     *Requires root, busybox, stock boot and recovery images,
ECHO      and the innopath update file
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
set var6=su:
set var3=running
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
ECHO copying modded file over to device...
adb push init.qcom.sdio.sh.mod /system/etc/init.qcom.sdio.sh
ECHO rebooting...
adb shell sleep 1
adb reboot
ECHO waiting for full boot...
adb wait-for-device
adb shell sleep 10
:checkLoop1
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "%var3%"=="%var4%" (
goto checkLoop1
)
adb shell sleep 1
ECHO rooting...
adb push su /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
ECHO rebooting..
adb shell sleep 1
adb reboot
ECHO waiting for full boot...
adb wait-for-device
adb shell sleep 10
:checkLoop2
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "%var3%"=="%var4%" (
goto checkLoop2
)
adb shell sleep 1
ECHO verifying root...
ping 1.1.1.1 -n 1 -w 1000 > nul
for /f %%i in ('adb shell su -c "cp /system/bin/rm /system/etc/rm"') do set var7=%%i
if "%var6%"=="%var7%" (
ECHO ROOT FAILED!
adb shell sleep 3
GOTO MENU
)
adb shell su -c "cp /system/bin/rm /system/etc/rm"
adb shell su -c "rm /system/etc/rm"
ECHO Installing busybox...
adb push busybox /data/local/tmp/busybox
adb shell su -c "chmod 755 /data/local/tmp/busybox"
adb shell su -c "/data/local/tmp/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/tmp/busybox mkdir /system/xbin"
adb shell su -c "/data/local/tmp/busybox cp /data/local/tmp/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb shell sleep 2
ECHO rebooting...
adb reboot
adb wait-for-device
ECHO waiting full boot...
adb wait-for-device
adb shell sleep 10
:checkLoop3
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "%var3%"=="%var4%" (
goto checkLoop3
)
adb shell sleep 1
ECHO installing unroot tool, root file manager and busybox updater...
adb install unroot.apk
adb install es.apk
adb install busybox.apk
ECHO cleaning up...
adb shell su -c "system/xbin/busybox mount -o remount,rw /system"
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "system/xbin/busybox cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
ECHO Done!
adb shell sleep 3
GOTO MENU

:BU
cls
ECHO This root method requires the following files:
ECHO MXXX modded boot.img (MXXX meaning your phone version)
ECHO placed in the bootImage folder and renamed to boot.img
ECHO GNM recovery.img placed in the reocveryImage folder
ECHO and renamed to recovery.img
pause
if not exist recoveryImage/recovery.img (
ECHO recovery.img not detected
goto ND
)
if not exist bootImage/boot.img (
ECHO boot.img not detected
goto ND
)
set var3=running
ECHO Enabling fastboot!
adb wait-for-device
adb shell input keyevent 5
ECHO If a "complete application using" window has shown
ECHO please select the stock dialer and then press enter
pause
adb shell sleep 1
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
ECHO flashing custom reocvery and boot images...
fastboot -i 0x0409 flash boot bootImage\boot.img
fastboot -i 0x0409 flash recovery recoveryImage\recovery.img
fastboot -i 0x0409 reboot
adb wait-for-device
adb reboot recovery
ECHO Waiting for recovery...
ping 1.1.1.1 -n 1 -w 15000 > nul
ECHO Rooting...
adb shell mount /system
adb push su /system/bin/su
adb shell chown root.root /system/bin/su
adb shell chmod 06755 /system/bin/su
adb push Superuser.apk /system/app/Superuser.apk
adb shell chmod 644 /system/app/Superuser.apk
adb shell chmod 777 /system/etc/init.qcom.sdio.sh
ECHO Rebooting...
set var3=running
adb shell reboot
adb wait-for-device
adb shell sleep 10
:checkLoop1D
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "%var3%"=="%var4%" (
goto checkLoop1D
)
adb shell sleep 1
ECHO Installing busybox and other root tools...
adb push busybox /data/local
adb shell su -c "chmod 755 /data/local/busybox"
adb shell su -c "/data/local/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/busybox mkdir /system/xbin"
adb shell su -c "/data/local/busybox cp /data/local/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb install busybox.apk
adb install unroot.apk
adb install es.apk
ECHO Done!
adb shell sleep 3
GOTO MENU

:UR
adb wait-for-device
ECHO Verifying phone is ready for unroot...
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
ECHO Unrooting!
adb install unroot.apk
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
ECHO Device will soon reboot..
ping 1.1.1.1 -n 1 -w 5000 > nul
ECHO done!
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO MENU

:URF
cls
ECHO This unroot method requires the following files:
ECHO MXXX stock boot.img (MXXX meaning your phone version)
ECHO placed in the stockImages folder and renamed to boot.img
ECHO MXXX stock recovery.img (MXXX meaning your phone version)
ECHO placed in the stockImages folder and renamed to recovery.img
pause
if not exist stockImages/recovery.img (
ECHO recovery.img not detected
goto ND
)
if not exist stockImages/boot.img (
ECHO boot.img not detected
goto ND
)
ECHO Verifying phone is ready for unroot...
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
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
ECHO Device will soon reboot..
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash boot stockImages\boot.img
fastboot -i 0x0409 flash recovery stockImages\recovery.img
fastboot -i 0x0409 reboot
adb wait-for-device
ECHO you are now fully stock. be carefull!
adb shell sleep 3
GOTO MENU

:RFM
ECHO Installing Root support file manager...
adb wait-for-device
adb install es.apk
ECHO Done!
adb shell sleep 3
GOTO MENU

:UK
ECHO Installing Unroot tool...
adb wait-for-device
adb install unroot.apk
ECHO Done!
adb shell sleep 3
GOTO MENU

:DBR
ECHO Dumping boot and recovery images...
adb wait-for-device
adb shell su -c "busybox mount -o remount,rw /system"
if exist dumpedImages\recovery.img (
del dumpedImages\recovery.img
)
if exist dumpedImages\boot.img (
del dumpedImages\boot.img
)
adb push mkyaffs2image /sdcard/mkyaffs2image
adb push onandroid /sdcard/onandroid
adb shell su -c "busybox cp /sdcard/mkyaffs2image /system/bin/mkyaffs2image"
adb shell su -c "busybox cp /sdcard/onandroid /system/bin/onandroid"
adb shell su -c "rm /sdcard/onandroid"
adb shell su -c "rm /sdcard/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/onandroid"
ECHO Loading ONandroid script...
adb shell sleep 1
adb shell su -c "onandroid -c casioRootPlus -a boot,recovery"
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img dumpedImages\boot.img
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img dumpedImages\recovery.img
adb shell rm /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img
adb shell rm /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img
adb shell su -c "rm -r /mnt/sdcard/clockworkmod/backup/casioRootPlus"
ECHO Images are in the dumpedImages folder!
ECHO Done!
adb shell sleep 3
GOTO MENU

:IB
ECHO Installing busybox...
adb wait-for-device
adb push busybox /data/local/tmp/busybox
adb shell su -c "chmod 755 /data/local/tmp/busybox"
adb shell su -c "/data/local/tmp/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/tmp/busybox mkdir /system/xbin"
adb shell su -c "/data/local/tmp/busybox cp /data/local/tmp/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb install busybox.apk
ECHO Done!
adb shell sleep 2
GOTO MENU

:VPV
ECHO Opening the phone version...
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
ECHO your "M" number is on the bottom, the Build number
ECHO Done!
adb shell sleep 3
GOTO MENU

:FBI
ECHO verify that your boot image is in bootImage\boot.img
pause
if not exist bootImage/boot.img (
ECHO boot.img not detected
goto BND
)
ECHO flashing the boot image
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash boot bootImage\boot.img
fastboot -i 0x0409 reboot
ECHO Done!
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO Menu

:FRI
ECHO verify that your recovery image is in recoveryImage\recovery.img
pause
if not exist recoveryImage/recovery.img (
ECHO recovery.img not detected
goto RND
)
ECHO flashing the recovery image
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash recovery recoveryImage\recovery.img
fastboot -i 0x0409 reboot
ECHO Done!
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO Menu

:FBA
ECHO verify that your boot animation is in bootAnimation\bootanimation.zip
ECHO and that a bootaimation binary file is ready
pause
if not exist bootAnimation\bootanimation.zip (
ECHO bootanimation.zip not detected
goto ZND
)
if not exist bootAnimation\bootanimation (
ECHO bootanimation binary not detected
goto BBND
)
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
ECHO verify that your update.zip file is in updateZip\update.zip
pause
if not exist updateZip\update.zip (
ECHO update.zip not detected
goto ZND
)
ECHO flashing update.zip...
adb wait-for-device
ECHO preparing for update...
adb shell "rm /mnt/sdcard/update.zip" > nul
adb push updateZip\update.zip /sdcard/update.zip
ECHO device is ready! Rebooting...
adb reboot recovery
ECHO waiting for recovery...
ping 1.1.1.1 -n 1 -w 15000 > nul
ECHO flashing...
adb shell "recovery '--update_package=/sdcard/update.zip'"
cls
ECHO if you see "instalation aborted" use vol down key to 
ECHO get to flash zip menu. press menu button to go into it.
ECHO choose zip from sdcard. navagate to your "update.zip"
ECHO file and press menu twice to flash it!
ECHO if it worked for you ignore this message
pause
adb shell rm /sdcard/update.zip
adb shell reboot
ECHO Done!
ping 1.1.1.1 -n 1 -w 1000 > nul
GOTO MENU

:FIU
cls
ECHO This update requires the following:
ECHO sdcard with FAT or FAT32 format (exFAT will not work!)
ECHO MXXX stock boot.img (MXXX meaning your phone version)
ECHO placed in the stockImages folder and renamed to boot.img
ECHO MXXX stock recovery.img (MXXX meaning your phone version)
ECHO placed in the stockImages folder and renamed to recovery.img
ECHO the inopath update to flash located in inopathUpdate\ipth_package.bin
pause
if not exist stockImages/recovery.img (
ECHO recovery.img not detected
goto ND
)
if not exist stockImages/boot.img (
ECHO boot.img not detected
goto ND
)
if not exist inopathUpdate/ipth_package.bin (
ECHO inopath update not detected
goto UND
)
set var3=running
ECHO preparing for update...
adb shell su -c "rm /mnt/sdcard/ipth_package.bin"
adb push inopathUpdate\ipth_package.bin /sdcard/ipth_package.bin
adb reboot bootloader
fastboot -i 0x0409 flash boot stockImages\boot.img
fastboot -i 0x0409 flash recovery stockImages\recovery.img
fastboot -i 0x0409 reboot
ECHO device prepared, waiting for full boot and sdcard mount...
adb wait-for-device
:checkLoop1F
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "%var3%"=="%var4%" (
goto checkLoop1F
)
adb shell sleep 15
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
ECHO Done!
ping 1.1.1.1 -n 1 -w 1000 > nul
GOTO MENU

:ND
ECHO one or both of the image files were not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:BND
ECHO boot image not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:RND
ECHO recovery image not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:ZND
ECHO zip file not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:UND
ECHO inopath update file not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:BBND
ECHO boot animation binary not detected
ECHO exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU
