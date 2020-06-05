function askI3Dialog() {
    # dialog menu
    cmd=(dialog --separate-output --checklist "Please select i3 package to be installed:" 22 76 16)

    options=(
        1 "i3" off
        2 "i3 lock" off
        3 "scrot" off
        4 "picom" off
        5 "conky" off
        6 "polybar" off
        7 "rofi" off
        8 "rofi greenclip" off
        9 "fhe" off
        10 "i3 battery popup git" off
    )
    i3Choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
}

function installI3Choice() {
    for i3Choice in $i3Choices; do
        case $i3Choice in
        1)
            echo PRE INSTALLING I3
            installI3
            ;;
        2)
            echo PRE INSTALL I3 LOCK
            installI3Lock
            ;;
        3)
            echo PRE INSTALL SCROT
            installScrot
            ;;
        4)
            echo PRE INSTALL PICOM
            installPicom
            ;;
        5)
            echo PRE INSTALL CONKY
            installConky
            ;;
        6)
            echo PRE INSTALL POLYBAR
            installPolybar
            ;;
        7)
            echo PRE INSTALL ROFI
            installRofi
            ;;
        8)
            echo PRE INSTALL ROFI GREENCLIP
            installRofiGreenclip
            ;;
        9)
            echo PRE INSTALL FEH
            installFeh
            ;;
        10)
            echo PRE INSTALL I3 BATTERY POPUP GIT
            installI3BatteryPopupGit
            ;;

        esac

    done
}

function installI3() {
    if ! [ -x "$(command -v i3)" ]; then
        echo INSTALLING I3
        yay -Sy --noconfirm i3
    else
        echo I3 ALREADY INSTALLED
    fi
}

function installI3Lock() {
    if ! [ -x "$(command -v i3lock)" ]; then
        echo INSTALLING I3 LOCK
        yay -Sy --noconfirm i3lock
    else
        echo I3 LOCK ALREADY INSTALLED
    fi
}

function installScrot() {
    if ! [ -x "$(command -v scrot)" ]; then
        echo INSTALLING SCROT
        # used for lock
        yay -Sy --noconfirm scrot
    else
        echo SCROT ALREADY INSTALLED
    fi
}

function installPicom() {
    if ! [ -x "$(command -v picom)" ]; then
        echo INSTALLING PICOM
        # used for overall opacity
        yay -Sy --noconfirm picom
    else
        echo PICOM ALREADY INSTALLED
    fi
}

function installConky() {
    if ! [ -x "$(command -v conky)" ]; then
        echo INSTALLING CONKY

        # used for overall system-monitor
        yay -Sy --noconfirm conky
    else
        echo CONKY ALREADY INSTALLED
    fi
}

function installPolybar() {
    if ! [ -x "$(command -v polybar)" ]; then
        echo INSTALLING POLYBAR

        # status bar
        yay -Sy --noconfirm polybar
    else
        echo POLYBAR ALREADY INSTALLED
    fi
}

function installRofi() {
    if ! [ -x "$(command -v rofi)" ]; then
        echo INSTALLING ROFI

        # launcher
        yay -Sy --noconfirm rofi
    else
        echo ROFI ALREADY INSTALLED
    fi
}

function installRofiGreenclip() {
    if ! [ -x "$(command -v rofi-greenclip)" ]; then
        echo INSTALLING ROFI GREENCLIP

        # clipboard manager
        yay -Sy --noconfirm rofi-greenclip
        systemctl --user enable greenclip.service
    else
        echo ROFI GREENCLIP ALREADY INSTALLED
    fi
}

function installFeh() {
    if ! [ -x "$(command -v feh)" ]; then
        echo INSTALLING FEH

        # background
        yay -Sy --noconfirm feh
    else
        echo FEH ALREADY INSTALLED
    fi
}

function installI3BatteryPopupGit() {
    if ! [ -x "$(command -v i3-battery-popup-git)" ]; then
        echo INSTALLING I3 BATTERY POPUP GIT
        # background
        yay -Sy --noconfirm i3-battery-popup-git
    else
        echo I3 BATTERY POPUP GIT ALREADY INSTALLED
    fi
}
