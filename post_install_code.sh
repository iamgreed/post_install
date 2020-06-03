JETBRAINS_TOOLBOX=jetbrains-toolbox-1.14.5179

function askCodeDialog() {
    # dialog menu
    cmd=(dialog --separate-output --checklist "Please select code utility to be installed:" 22 76 16)

    options=(
        1 "vsCode" off
        2 "chrome" off
        3 "jetbrains toolbox" off
        4 "telegram" off
        5 "teams" off
        6 "kubectl" off
        7 "slack" off
    )
    codeChoices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
}

function installCodeChoice() {
    for codeChoice in $codeChoices; do
        case $codeChoice in
        1)
            echo PRE INSTALLING VS CODE
            installVsCode
            ;;
        2)
            echo PRE INSTALL CHROME
            installChrome
            ;;
        3)
            echo PRE INSTALL JETBRAINS_TOOLBOX
            installJetbrainsToolbox
            ;;
        4)
            echo PRE INSTALL TELEGRAM
            installTelegram
            ;;
        5)
            echo PRE INSTALL TEAMS
            installTeams
            ;;
        6)
            echo PRE INSTALL KUBECTL
            installKubectl
            ;;
        7)
            echo PRE INSTALL SLACK
            installSlack
            ;;
        esac

    done
}

function installVsCode() {
    if ! [ -x "$(command -v code)" ]; then
        echo INSTALLING VSCODE
        sudo snap install code --classic
        yay -S libdbusmenu-glib
        yay -S gconf
    else
        echo VSCODE ALREADY INSTALLED
    fi

}

function installChrome() {
    if ! [ -x "$(command -v google-chrome-stable)" ]; then
        echo INSTALLING CHROME
        yay -S --noconfirm google-chrome
    else
        echo CHROME ALREADY INSTALLED
    fi
}

function installJetbrainsToolbox() {
    if ! [ -f ~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ]; then
        echo INSTALLING JETBRAINS TOOLBOX
        wget https://download.jetbrains.com/toolbox/$JETBRAINS_TOOLBOX.tar.gz -q --show-progress
        tar xvzf $JETBRAINS_TOOLBOX.tar.gz >/dev/null
        ./$JETBRAINS_TOOLBOX/jetbrains-toolbox
    else
        echo JETBRAINS TOOLBOX ALREADY INSTALLED
    fi
}

function installTelegram() {
    if ! [ -x "$(command -v telegram-desktop)" ]; then
        echo INSTALLING TELEGRAM
        yay -S --noconfirm telegram-desktop
    else
        echo TELEGRAM ALREADY INSTALLED
    fi
}

function installTeams() {
    if ! [ -x "$(command -v teams)" ]; then
        echo INSTALLING TEAMS
        yay -Sy --noconfirm teams
    else
        echo TEAMS ALREADY INSTALLED
    fi
}

function installKubectl() {
    if ! [ -x "$(command -v kubectl)" ]; then
        echo INSTALLING KUBECTL
        sudo snap install kubectl --classic
    else
        echo KUBECTL ALREADY INSTALLED
    fi
}

function installSlack() {
    if ! [ -x "$(command -v slack)" ]; then
        echo INSTALLING SLACK
        sudo snap install slack --classic
    else
        echo SLACK ALREADY INSTALLED
    fi
}
