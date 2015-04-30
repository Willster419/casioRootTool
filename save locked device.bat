ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Locked Device Recovery Add-on by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure drivers are installed and adb is enabled!
ECHO Phone screen MUST be on!
ECHO Due to the different firmware versions of devices I cannot verify
ECHO that this works 100 percent.
ECHO By continuing you understand that this will WIPE YOUR PHONE
pause
ECHO Detecting Device...
ECHO If this hangs for more than a minute, then you don't have adb on.
adb wait-for-device
ECHO Device detected, attempting recovery! Approx time is 20 seconds
ECHO Do NOT touch the screen at this time!
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
ECHO waiting for fastboot...
ping 1.1.1.1 -n 1 -w 20000 > nul
ECHO wiping phone...
fastboot -i 0x0409 erase userdata
fastboot -i 0x0409 erase cache
fastboot -i 0x0409 reboot
ECHO Recovery Complete! You're device is wiped, but you have
ECHO acces to it again! Enjoy!
pause