FIRACODE_VERSION=2
FONTAWESOME_VERSION=5.12.1
NERDFONT_VERSION=2.0.0

function askGeneralDialog() {
    # dialog menu
    cmd=(dialog --separate-output --checklist "Please select gereal library to be installed:" 22 76 16)

    options=(
        1 "yay" off
        2 "snap" off
        3 "git" off
        4 "lsd" off
        5 "oh my zsh" off
        6 "bd" off
        7 "dot net sdk" off
        8 "node" off
        9 "yarn" off
        10 "docker" off
        11 "docker compose" off
        # 12 "i3" off
        13 "emacs" off
        14 "dustn" off
        15 "kitty" off
        16 "firacode" off
        17 "furacode" off
        18 "font awesome" off
        19 "rust" off
    )
    genealChoices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
}

function installGeneralChoice() {
    for genealChoice in $genealChoices; do
        case $genealChoice in
        1)
            echo PRE INSTALLING YAY
            installYay
            ;;
        2)
            echo PRE INSTALLING SNAP
            installSnap
            ;;
        3)
            echo PRE INSTALLING GIT
            installGit
            ;;
        4)
            echo PRE INSTALLING LSD
            installLsd
            ;;
        5)
            echo PRE INSTALLING OH MY ZSH
            installOhMyZsh
            ;;
        6)
            echo PRE INSTALLING Bd
            installBd
            ;;
        7)
            echo PRE INSTALLING DOT NET SDK
            installDotnetSdk
            ;;
        8)
            echo PRE INSTALLING NODE
            installNode
            ;;
        9)
            echo PRE INSTALLING YARN
            installYarn
            ;;
        10)
            echo PRE INSTALLING DOCKER
            installDocker
            ;;
        11)
            echo PRE INSTALLING DOCKER COMPOSE
            installDockerCompose
            ;;
        13)
            echo PRE INSTALLING EMACS
            installEmacs
            ;;
        14)
            echo PRE INSTALLING DUNST
            installDunst
            ;;
        15)
            echo PRE INSTALLING KITTY
            installKitty
            ;;
        16)
            echo PRE INSTALLING FIRACODE
            installFiraCode
            ;;
        17)
            echo PRE INSTALLING PATCHED FIRACODE
            installFuraCode
            ;;
        18)
            echo PRE INSTALLING FONTAWESOME
            installFontAwesome
            ;;
        19)
            echo PRE INSTALLING RUST
            installRust
            ;;

        esac

    done

}

function installYay() {
    if ! [ -x "$(command -v yay)" ]; then
        echo INSTALLING YAY
        git clone https://aur.archlinux.org/yay.git
        cd yay && makepkg -si --noconfirm && cd ..
        rm -rf yay
    else
        echo YAY ALREADY INSTALLED
    fi

}

function installSnap() {
    if ! [ -x "$(command -v snap)" ]; then
        echo INSTALLING SNAP
        yay -Sy --noconfirm snapd
        sudo systemctl enable --now snapd.socket
        echo Either log out and back in again, or restart your system, to ensure snap’s paths are updated correctly.
        echo Once done, restart the script!
        exit 1
    else
        echo SNAP ALREADY INSTALLED
    fi

}

function installGit() {
    if ! [ -x "$(command -v git)" ]; then
        echo INSTALLING GIT
        yay -S --noconfirm git
    else
        echo GIT ALREADY INSTALLED
    fi

}

function installLsd() {
    if ! [ -x "$(command -v lsd)" ]; then
        echo INSTALLING LSD
        sudo snap install lsd --devmode
    else
        echo LSD ALREADY INSTALLED
    fi
}

function installFiraCode() {
    if ! [ "$(fc-list | grep -c 'FiraCode')" -ge 1 ]; then
        echo INSTALLING FIRACODE
        wget https://github.com/tonsky/FiraCode/releases/download/$FIRACODE_VERSION/FiraCode_$FIRACODE_VERSION.zip -O $TEMP_DIR/FiraCode.zip

        unzip $TEMP_DIR/FiraCode.zip -d ~/.fonts

        fc-cache

    else
        echo FIRACODE ALREADY INSTALLED
    fi
}

function installFuraCode() {
    if ! [ "$(fc-list | grep -c 'Fura Code')" -ge 1 ]; then
        echo INSTALLING PATCHED FIRACODE
        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERDFONT_VERSION/FiraCode.zip -O $TEMP_DIR/FuraCode.zip

        unzip $TEMP_DIR/FuraCode.zip -d ~/.fonts

        fc-cache

    else
        echo PATCHED FIRACODE ALREADY INSTALLED
    fi
}

function installFontAwesome() {
    if ! [ "$(fc-list | grep -c 'Font Awesome 5 Free')" -ge 1 ]; then
        echo INSTALLING FONTAWESOME
        wget https://github.com/FortAwesome/Font-Awesome/releases/download/$FONTAWESOME_VERSION/fontawesome-free-$FONTAWESOME_VERSION-desktop.zip -O $TEMP_DIR/FontAwesome.zip

        unzip $TEMP_DIR/FontAwesome.zip -d ~/.fonts

        fc-cache
    else
        echo FONTAWESOME ALREADY INSTALLED
    fi
}

function installOhMyZsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        echo INSTALLING OH-MY-ZSH
        # echo TELL YES TO CHANGE TO SHELL AND THEN EXIT!
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/\s*env\s\s*zsh\s*/d')"

        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
        git clone https://github.com/buonomo/yarn-completion ~/.oh-my-zsh/custom/plugins/yarn-completion
    else
        echo OH-MY-ZSH ALREADY INSTALLED
    fi
}

function installBd() {
    if ! [ -x "$(command -v bd)" ]; then
        echo INSTALLING BD
        mkdir -p ~/.oh-my-zsh/custom/plugins/bd
        curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh >~/.oh-my-zsh/custom/plugins/bd/bd.zsh
        echo -e "\n# zsh-bd\n. ~/.oh-my-zsh/custom/plugins/bd/bd.zsh" >>~/.zshrc
    else
        echo BD ALREADY INSTALLED
    fi
}

function installDotnetSdk() {
    if ! [ -x "$(command -v dotnet)" ]; then
        echo INSTALLING DOTNETCORE SDK
        yay -Sy --noconfirm dotnet-runtime
    else
        echo DOTNETCORE SDK ALREADY INSTALLED
    fi
}

function installNode() {
    if ! [ -x "$(command -v node)" ]; then
        echo INSTALLING NODE
        yay -Sy --noconfirm nvm
    else
        echo NODE ALREADY INSTALLED
    fi
}

function installYarn() {
    if ! [ -x "$(command -v yarn)" ]; then
        echo INSTALLING YARN
        ay -Sy --noconfirm yarn
    else
        echo YARN ALREADY INSTALLED
    fi
}

function installDocker() {
    if ! [ -x "$(command -v docker)" ]; then
        echo INSTALLING DOCKER
        yay -Sy --noconfirm docker
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        sudo systemctl enable docker
        sudo systemctl start docker
    else
        echo DOCKER ALREADY INSTALLED
    fi
}

function installDockerCompose() {
    if ! [ -x "$(command -v docker-compose)" ]; then
        echo INSTALLING DOCKER-COMPOSE
        yay -Sy --noconfirm docker-compose
    else
        echo DOCKER-COMPOSE ALREADY INSTALLED
    fi
}

function installEmacs() {
    if ! [ -x "$(command -v emacs)" ]; then
        echo INSTALLING EMACS
        echo SELECT THE VERSION NEEDED BY DOOM EMACS
        sudo snap install emacs --channel=latest/beta --classic
        yay -Sy --noconfirm ripgrep
        git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
        ~/.emacs.d/bin/doom install
    else
        echo EMACS ALREADY INSTALLED
    fi
}

function installDunst() {
    if ! [ -x "$(command -v dunst)" ]; then
        echo INSTALLING DUNST
        yay -Sy --noconfirm dunst
    else
        echo DUNST ALREADY INSTALLED
    fi
}

function installKitty() {
    if ! [ -x "$(command -v kitty)" ]; then
        echo INSTALLING KITTY
        yay -Sy --noconfirm kitty
    else
        echo KITTY ALREADY INSTALLED
    fi
}

function installRust(){
    if ! [ -x "$(command -v rust)" ]; then
        echo INSTALLING RUST
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    else
        echo RUST ALREADY INSTALLED
    fi
}