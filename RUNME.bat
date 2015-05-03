ECHO OFF
COLOR 9b
CLS
rem display the menu
:menu
CLS
ECHO #Casio Root Tool Plus version 2.1 by: Willster419
ECHO #By using the script you understand that this is done at YOUR own risk.
ECHO #Make sure your phone has usb debugging mode enabled!
ECHO #Make sure drivers are installed!
ECHO #Phone screen MUST be on and unlocked!!!
ECHO 1 - Root/Unroot menu
ECHO 2 - Flash menu
ECHO 3 - Install (old working) ES root file manager
ECHO 4 - Install Unroot tool
ECHO 5 - Dump boot and recovery images
ECHO     *Requires busybox and root
ECHO 6 - Install busybox
ECHO     *Requires root
ECHO 7 - View Phone Version
ECHO 8 - Fix Wifi Error
ECHO     *Requries root
ECHO 9 - Save your locked device
ECHO.
ECHO 10 - Exit this tool
ECHO.
ECHO #To stop the script at any time, press Ctrl+C
ECHO.
SET /P M=#Type your choice then press ENTER:
ECHO.
IF %M%==1 GOTO RU
IF %M%==2 GOTO FM
IF %M%==3 GOTO RFM
IF %M%==4 GOTO UK
IF %M%==5 GOTO DBR
IF %M%==6 GOTO IB
IF %M%==7 GOTO VPV
IF %M%==8 GOTO FWE
IF %M%==9 GOTO SLD
IF %M%==10 GOTO EXIT

rem the root options menu
:RU
cls
ECHO 1 - ROOT (top-down)
ECHO 2 - ROOT (bottom-up)
ECHO 3 - Unroot (quick)
ECHO 4 - Unroot (full)
ECHO 5 - Back to main menu
ECHO.
SET /P N=#Type your choice then press ENTER:
IF %N%==1 GOTO TD
IF %N%==2 GOTO BU
IF %N%==3 GOTO UR
IF %N%==4 GOTO URF
IF %N%==5 GOTO menu

rem the flashing menu
:FM
cls
ECHO 1 - Enable fastboot
ECHO 2 - Flash stock boot image for your phone version
ECHO     *Fastboot required
ECHO 3 - Flash custom boot image for your phone version
ECHO     *Fastboot required
ECHO 4 - Flash stock recovery image for your phone version
ECHO     *Fastboot required
ECHO 5 - Flash GNM recovery
ECHO     *Fastboot required
ECHO 6 - Flash a boot animation(must have busybox and root)
ECHO     *Root and Busybox required
ECHO 7 - Flash an "update.zip"
ECHO     *Requires root GNM recovery
ECHO 8 - Flash Inopath update 
ECHO     *Requires root
ECHO 9 - Back to main menu
ECHO.
SET /P O=#Type your choice then press ENTER:
IF %O%==1 GOTO EF
IF %O%==2 GOTO FSBI
IF %O%==3 GOTO FCBI
IF %O%==4 GOTO FSRI
IF %O%==5 GOTO FGNM
IF %O%==6 GOTO FBA
IF %O%==7 GOTO FUZ
IF %O%==8 GOTO FIU
IF %O%==9 GOTO MENU

rem the process for the top down root process
:TD
ECHO #Starting Top Down root...
rem make sure device is there and set proper variables
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopRoot1_1
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopRoot1_1
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
rem if the wifi is on, turn it off
FOR /F "tokens=* USEBACKQ" %%F IN (`adb shell "dumpsys wifi | grep Wi-Fi"`) DO (
SET var=%%F
)
ECHO #%var%
adb shell sleep 1
if "%var%"=="Wi-Fi is enabled" (
ECHO #Turning off wifi...
adb shell am start -a android.intent.action.MAIN -n com.android.settings/.wifi.WifiSettings
adb shell sleep 1
adb shell input keyevent 20
adb shell input keyevent 23
)
rem copy a modified script to be run at startup
ECHO #copying modded file over to device...
adb push tools\init.qcom.sdio.sh.mod /system/etc/init.qcom.sdio.sh
ECHO #rebooting...
adb shell sleep 1
adb reboot
ECHO #waiting for full boot...
adb wait-for-device
adb shell sleep 10
:checkLoop1
rem checks to see if the phone is fully booted or not
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "running"=="%var4%" (
goto checkLoop1
)
adb shell sleep 1
ECHO #rooting...
rem copy the superuser binary and application to the device
adb push tools\su /system/bin/su
adb push tools\superuser.apk /system/app/Superuser.apk
ECHO #rebooting..
adb shell sleep 1
adb reboot
ECHO #waiting for full boot...
adb wait-for-device
adb shell sleep 10
rem wait for a full boot again
:checkLoop2
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "running"=="%var4%" (
goto checkLoop2
)
adb shell sleep 1
ECHO #verifying root...
ping 1.1.1.1 -n 1 -w 1000 > nul
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var7=%%i
if "su:"=="%var7%" (
ECHO #root failed!
adb shell sleep 3
GOTO MENU
)
adb shell su -c "cp /system/bin/rm /system/etc/rm"
adb shell su -c "rm /system/etc/rm"
rem copies the busybox binary to the phone, then uses the busybox binary
rem itself to copy to the system partition and set the proper permissions
ECHO #Installing busybox...
adb push tools\busybox /data/local/tmp/busybox
adb shell su -c "chmod 755 /data/local/tmp/busybox"
adb shell su -c "/data/local/tmp/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/tmp/busybox mkdir /system/xbin"
adb shell su -c "/data/local/tmp/busybox cp /data/local/tmp/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb shell sleep 2
ECHO #rebooting...
adb reboot
adb wait-for-device
ECHO #waiting full boot...
adb wait-for-device
adb shell sleep 10
:checkLoop3
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "running"=="%var4%" (
goto checkLoop3
)
adb shell sleep 1
rem installs the apks in the main directory
ECHO #installing unroot tool, root file manager and busybox updater...
adb install tools\unroot.apk
adb install tools\es.apk
adb install tools\busybox.apk
rem remounts the system to be re-writeable, removes any files copied, and
rem verifies all correct permissions are set
ECHO #cleaning up...
adb shell su -c "system/xbin/busybox mount -o remount,rw /system"
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push tools\init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "system/xbin/busybox cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
ECHO #Done!
pause
GOTO MENU

:BU
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopRoot2_1
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopRoot2_1
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
ECHO #Checking if your phone build version is supported...
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "bootImage/modded/%var5% modded boot.img" (
GOTO NS
)
ECHO #Your phone version is supported!
ping 1.1.1.1 -n 1 -w 500 > nul
if not exist recoveryImage/GNM.img (
ECHO #recovery.img not detected
goto ND
)
set var3=running
ECHO #Device is ready for root!
adb shell sleep 1
ECHO #Enabling fastboot!
adb wait-for-device
adb shell input keyevent 5
ECHO #If a "complete application using" window has shown
ECHO #please select the stock dialer and then
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
pause
ECHO #Continuing with root...
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
ECHO #flashing custom reocvery and boot images...
fastboot -i 0x0409 flash boot "bootImage/modded/%var5% modded boot.img"
fastboot -i 0x0409 flash recovery recoveryImage\GNM.img
fastboot -i 0x0409 reboot
adb wait-for-device
adb reboot recovery
ECHO #Waiting for recovery...
ping 1.1.1.1 -n 1 -w 15000 > nul
ECHO #If your computer is installing drivers, please wait
ECHO #untill it finishes
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
pause
ECHO #Rooting...
adb shell mount /system
adb push tools\su /system/bin/su
adb shell chown root.root /system/bin/su
adb shell chmod 06755 /system/bin/su
adb push tools\superuser.apk /system/app/Superuser.apk
adb shell chmod 644 /system/app/Superuser.apk
adb shell chmod 777 /system/etc/init.qcom.sdio.sh
ECHO #Rebooting...
adb shell reboot
adb wait-for-device
adb shell sleep 10
:checkLoopRoot2_2
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "running"=="%var4%" (
goto checkLoopRoot2_2
)
adb shell sleep 1
ECHO #Installing busybox and other root tools...
adb push tools\busybox /data/local
adb shell su -c "chmod 755 /data/local/busybox"
adb shell su -c "/data/local/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/busybox mkdir /system/xbin"
adb shell su -c "/data/local/busybox cp /data/local/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb install tools\busybox.apk
adb install tools\unroot.apk
adb install tools\es.apk
ECHO #Done!
pause
GOTO MENU

:UR
ECHO #Verifying phone is ready for unroot...
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopUnRoot1
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopUnRoot1
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
ECHO #Preparing for phone unrooting...
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push tools\init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
ECHO #Unrooting!
adb install tools\unroot.apk
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
ECHO #Device will soon reboot..
ping 1.1.1.1 -n 1 -w 5000 > nul
ECHO #done!
pause
GOTO MENU

:URF
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopUnRoot2
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopUnRoot2
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
ECHO #Checking if your phone build version is supported...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "bootImage/stock/%var5% stock boot.img" (
GOTO NS
)
if not exist "recoveryImage/%var5% stock recovery.img" (
GOTO NS
)
ECHO #Your phone version is supported!
ping 1.1.1.1 -n 1 -w 500 > nul
ECHO #Preparing phone for unroot...
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push tools\init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
adb shell su -c "chmod 755 /system/bin"
adb shell su -c "chmod 755 /system/app"
adb shell su -c "chmod 755 /system"
ECHO #Unrooting fully to COMPLETE STOCK...
adb install tools\unroot.apk
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
ECHO #Device will soon reboot..
ping 1.1.1.1 -n 1 -w 15000 > nul
ECHO #Waiting for boot...
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash boot "bootImage/stock/%var5% stock boot.img"
fastboot -i 0x0409 flash recovery "recoveryImage/%var5% stock recovery.img"
fastboot -i 0x0409 reboot
adb wait-for-device
ECHO #you are now fully stock. be carefull!
pause
GOTO MENU

:RFM
ECHO #Installing Root support file manager...
adb wait-for-device
adb install tools\es.apk
ECHO #Done!
pause
GOTO MENU

:UK
ECHO #Installing Unroot tool...
adb wait-for-device
adb install tools\unroot.apk
ECHO #Done!
pause
GOTO MENU

:DBR
ECHO #Dumping boot and recovery images...
adb wait-for-device
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
rem verifies the existence of busybox
for /f %%i in ('adb shell busybox') do set var10=%%i
if "%var10%"=="busybox:" (
GOTO NBB
)
adb shell su -c "busybox mount -o remount,rw /system"
if exist dumpedImages\recovery.img (
del dumpedImages\recovery.img
)
if exist dumpedImages\boot.img (
del dumpedImages\boot.img
)
adb push tools\mkyaffs2image /sdcard/mkyaffs2image
adb push tools\onandroid /sdcard/onandroid
adb shell su -c "busybox cp /sdcard/mkyaffs2image /system/bin/mkyaffs2image"
adb shell su -c "busybox cp /sdcard/onandroid /system/bin/onandroid"
adb shell su -c "rm /sdcard/onandroid"
adb shell su -c "rm /sdcard/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/mkyaffs2image"
adb shell su -c "chmod 755 /system/bin/onandroid"
ECHO #Loading ONandroid script...
adb shell sleep 1
adb shell su -c "onandroid -c casioRootPlus -a boot,recovery"
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img dumpedImages\boot.img
adb pull /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img dumpedImages\recovery.img
adb shell rm /mnt/sdcard/clockworkmod/backup/casioRootPlus/boot.img
adb shell rm /mnt/sdcard/clockworkmod/backup/casioRootPlus/recovery.img
adb shell su -c "rm -r /mnt/sdcard/clockworkmod/backup/casioRootPlus"
ECHO #Images are in the dumpedImages folder!
ECHO #Done!
pause
GOTO MENU

:IB
ECHO #Installing busybox binary and apk updater...
adb wait-for-device
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
adb push tools\busybox /data/local/tmp/busybox
adb shell su -c "chmod 755 /data/local/tmp/busybox"
adb shell su -c "/data/local/tmp/busybox mount -o remount,rw /system"
adb shell su -c "/data/local/tmp/busybox mkdir /system/xbin"
adb shell su -c "/data/local/tmp/busybox cp /data/local/tmp/busybox /system/xbin/busybox"
adb shell su -c "chmod 755 /system/xbin/busybox"
adb shell su -c "/system/xbin/busybox --install /system/xbin"
adb install tools\busybox.apk
ECHO #Done!
pause
GOTO MENU

:VPV
ECHO #Opening the phone version...
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopVPV1
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopVPV1
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
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
ECHO #Your "M" number is on the bottom, the Build number
ECHO #Done!
pause
GOTO MENU

:EF
ECHO #Please unlock your phone now
ECHO #Waiting for phone detection
adb wait-for-device
ECHO #Phone detected, waiting for phone unlock detection...
:checkLoopEF
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys window windows | grep -E 'mCurrentFocus' | cut -c 33-40"') do set var8=%%i
if "Keyguard"=="%var8%" (
goto checkLoopEF
)
ECHO #Phone detected, moving to homescreen...
adb shell input keyevent 3
ping 1.1.1.1 -n 1 -w 500 > nul
ECHO #Enabling fastboot!
adb wait-for-device
adb shell input keyevent 5
ECHO #If a "complete application using" window has shown
ECHO #please select the stock dialer and then
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 4b
ping 1.1.1.1 -n 1 -w 500 > nul
COLOR 9b
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
adb reboot
ECHO #Done!
pause
GOTO MENU

:FSBI
ECHO #Checking if your phone build version is supported...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "bootImage/stock/%var5% stock boot.img" (
GOTO NS
)
ECHO #Your build version is supported!
ECHO #flashing the stock boot image
adb reboot bootloader
fastboot -i 0x0409 flash boot "bootImage/stock/%var5% stock boot.img"
fastboot -i 0x0409 reboot
ECHO #Done!
pause
GOTO Menu

:FCBI
ECHO #Checking if your phone build version is supported...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "bootImage/modded/%var5% modded boot.img" (
GOTO NS
)
ECHO #Your build version is supported!
ECHO #flashing the custom boot image
adb reboot bootloader
fastboot -i 0x0409 flash boot "bootImage/modded/%var5% modded boot.img"
fastboot -i 0x0409 reboot
ECHO #Done!
pause
GOTO Menu

:FSRI
ECHO #Checking if your phone build version is supported...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "recoveryImage/%var5% stock recovery.img" (
GOTO NS
)
ECHO #Your build version is supported!
ECHO #flashing the stock recovery image
adb reboot bootloader
fastboot -i 0x0409 flash recovery "recoveryImage/%var5% stock recovery.img"
fastboot -i 0x0409 reboot
ECHO #Done!
pause
GOTO Menu

:FGNM
ECHO #flashing GNM recovery
adb wait-for-device
adb reboot bootloader
fastboot -i 0x0409 flash recovery recoveryImage/GNM.img
fastboot -i 0x0409 reboot
ECHO #Done!
pause
GOTO Menu

:FBA
ECHO #Please verify that your boot animation (if you are flashing one)
ECHO #is in bootAnimation\bootanimation.zip
ECHO #and that a bootaimation binary file is ready
pause
if not exist bootAnimation\bootanimation (
goto BBND
)
if not exist bootAnimation\bootanimation.zip (
ECHO #bootanimation.zip not detected
ECHO #Now assuming you are installing the stock bootanimation
pause
)
ECHO #Flashing your boot animation!
adb wait-for-device
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
adb shell su -c "busybox mount -o remount,rw /system"
adb push bootAnimation\bootanimation /sdcard/bootanimation
if exist bootAnimation\bootanimation.zip (
adb push bootAnimation\bootanimation.zip /sdcard/bootanimation.zip
adb shell su -c "busybox cp /sdcard/bootanimation.zip /system/media/bootanimation.zip
adb shell su -c "busybox chmod 755 /system/media/bootanimation.zip"
adb shell su -c "busybox rm /sdcard/bootanimation.zip"
)
if exist bootAnimation\Bootsound.mp3 (
adb push bootAnimation\Bootsound.mp3 /sdcard/Bootsound.mp3
adb shell su -c "busybox cp /sdcard/Bootsound.mp3 /system/media/audio/ui/Bootsound.mp3"
adb shell su -c "busybox chmod 755 /system/media/audio/ui/Bootsound.mp3"
adb shell su -c "busybox rm /sdcard/Bootsound.mp3"
)
adb shell su -c "busybox cp /sdcard/bootanimation /system/bin/bootanimation" 
adb shell su -c "busybox chmod 755 /system/bin/bootanimation"
adb shell su -c "busybox rm /sdcard/bootanimation"
ECHO #install complete!
pause
GOTO MENU

:FUZ
ECHO #Please verify that your update.zip file is in updateZip\update.zip
pause
if not exist updateZip\update.zip (
goto ZND
)
ECHO #flashing update.zip...
adb wait-for-device
ECHO #preparing for update...
adb shell "rm /mnt/sdcard/update.zip" > nul
adb push updateZip\update.zip /sdcard/update.zip
adb shell "echo '--update_package=SDCARD:update.zip' >> /cache/recovery/command"
ECHO #device is ready! Rebooting...
adb reboot recovery
ECHO #waiting for recovery...
ping 1.1.1.1 -n 1 -w 15000 > nul
ECHO #flashing...
ECHO #Wait untill the update is complete to continue
pause
adb shell rm /sdcard/update.zip
adb shell reboot
pause
GOTO MENU

:FIU
ECHO #This update requires the following:
ECHO #root access (will be tested for)
ECHO #a supported phone model (will be tested for)
pause
ECHO #Checking if your phone build version is supported...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if not exist "bootImage/stock/%var5% stock boot.img" (
GOTO NS
)
if not exist "recoveryImage/%var5% stock recovery.img" (
GOTO NS
)
ECHO #Your phone version is supported!
ping 1.1.1.1 -n 1 -w 500 > nul
ECHO #Checking if your phone build version is supported for update...
adb wait-for-device
ping 1.1.1.1 -n 1 -w 500 > nul
for /f %%i in ('adb shell "getprop ro.build.id | cut -c 5-8"') do set var5=%%i
if "%var5%"=="M150"(
ECHO #your phone build is already the latest build version
ping 1.1.1.1 -n 1 -w 3000 > nul
GOTO MENU
)
if "%var5%"=="M140"(
ECHO #your phone build is supported for update!
ping 1.1.1.1 -n 1 -w 2000 > nul
GOTO updateSupported
)
if "%var5%"=="M130"(
ECHO #your phone build is supported for update!
ping 1.1.1.1 -n 1 -w 2000 > nul
GOTO updateSupported
)
ECHO #Error: your phone build version is not supported for update
ECHO #Contact willster419@outlook.com for details
ECHO #Have your build id ready for when you email
pause
GOTO MENU
:updateSupported
ECHO #preparing for update...
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
adb shell su -c "rm /mnt/sdcard/ipth_package.bin" > nul
adb push inopathUpdate\%var5%Update.bin /sdcard/ipth_package.bin
ECHO #rebooting...
adb reboot bootloader
fastboot -i 0x0409 flash boot "bootImage/stock/%var5% stock boot.img"
fastboot -i 0x0409 flash recovery "recoveryImage/%var5% stock recovery.img"
fastboot -i 0x0409 reboot
ECHO #device prepared, waiting for full boot and sdcard mount...
adb wait-for-device
:checkLoopUpdate
adb shell sleep 1
for /f %%i in ('adb shell "getprop init.svc.bootanim"') do set var4=%%i
if "running"=="%var4%" (
goto checkLoopUpdate
)
adb shell sleep 1
ECHO #setting phone to update and rebooting...
adb shell "echo '--update_package=SDCARD:ipth_package.bin' >> /cache/recovery/command"
rem adb shell su -c "ECHO #'--update_package=/sdcard/ipth_package.bin' >> /cache/recovery/command"
adb reboot recovery
ECHO #You will NEED to do a battery pull AFTER the update is done
ECHO #(When its just the android guy with the exclamation point).
ECHO #Also please keep in mind that if you want GNM recovery
ECHO #of the modded boot image of the new firmware (if it exists yet)
ECHO #you need to reflash it from the flash menu. You will also have
ECHO #to delete the ipth_update from your sdcard
pause
GOTO MENU

:FWE
ECHO #Fixing the Wifi Error...
adb wait-for-device
rem verifies root by calling the help command to see if the su binary is installed
for /f %%i in ('adb shell su -h') do set var12=%%i
if "%var12%"=="su:" (
GOTO NR
)
adb shell su -c "rm /system/etc/init.qcom.sdio.sh"
adb push tools\init.qcom.sdio.sh.orig /data/local/tmp/init.qcom.sdio.sh
adb shell su -c "system/xbin/busybox cp /data/local/tmp/init.qcom.sdio.sh /system/etc/init.qcom.sdio.sh"
adb shell su -c "rm /data/local/tmp/init.qcom.sdio.sh"
adb shell su -c "chmod 777 /system/etc/init.qcom.sdio.sh"
ECHO #Done!
pause
GOTO MENU

:SLD
CLS
ECHO #Casio Locked Device Recovery Add-on by: Willster419
ECHO #By using the script you understand that this is done at YOUR own risk.
ECHO #Make sure drivers are installed and adb is enabled!
ECHO #Phone screen MUST be on!
ECHO #Due to the different firmware versions of devices I cannot verify
ECHO #that this works 100 percent.
ECHO #By continuing you understand that this will WIPE YOUR PHONE
pause
ECHO #Detecting Device...
ECHO #If this hangs for more than a minute, then you don't have adb on.
adb wait-for-device
ECHO #Device detected, waiting for the screen to be on...
:checkLoopScreenOn
adb shell sleep 1
for /f %%i in ('adb shell "dumpsys input_method | grep mScreenOn | cut -c 31-35"') do set var2=%%i
if "false"=="%var2%" (
goto checkLoopScreenOn
)
ECHO #Screen on, attempting recovery! Approx time is 20 seconds
ECHO #Do NOT touch the screen at this time!
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
ECHO #waiting for fastboot...
ping 1.1.1.1 -n 1 -w 20000 > nul
ECHO #wiping phone...
fastboot -i 0x0409 erase userdata
fastboot -i 0x0409 erase cache
fastboot -i 0x0409 reboot
ECHO #Recovery Complete! You're device is wiped and you have
ECHO #access to it again! Enjoy!
pause
GOTO MENU

:ND
ECHO #Error: one or both of the image files were not detected
ECHO #exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:ZND
ECHO #zip file not detected
ECHO #exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:BBND
ECHO #boot animation binary not detected
ECHO #exiting...
ping 1.1.1.1 -n 1 -w 3000 > nul
goto MENU

:NS
ECHO #Error: Your phone version is not supported. Send an email
ECHO #to willster419@outlook.com to get it supported.
ECHO #Please include your phone version, and run the "dump images"
ECHO #option and attach the boot.img for quick support.
pause
GOTO MENU

:NR
ECHO #Error: Your phone is not rooted. In order to continue
ECHO #with the requested operation, you need to root your
ECHO #phone first.
ping 1.1.1.1 -n 1 -w 7000 > nul
GOTO MENU