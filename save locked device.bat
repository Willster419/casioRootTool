ECHO OFF
COLOR 9b
CLS
:menu
CLS
ECHO Casio Lock Screen Saver Add-on by: Willster419
ECHO By using the script you understand that this is done at YOUR own risk.
ECHO Make sure drivers are installed and adb is enabled!
ECHO Phone screen MUST be on!!!
ECHO Due to the different firmware versions of devices I cannot verify
ECHO that this works 100%. But it's worth a try!
pause

ECHO Attempting to save!
adb wait-for-device
ECHO Device detected, attempting fastboot!
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
ECHO you should be in the bootloader now. at this point you want to erase data
ECHO and then reboot
pause
ECHO and by continue i mean exit the script