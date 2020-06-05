FIRACODE_VERSION=2
FONTAWESOME_VERSION=5.12.1
NERDFONT_VERSION=2.0.0

function askGeneralDialog() {
    # dialog menu
    cmd=(dialog --separate-output --checklist "Please select general library to be installed:" 22 76 16)

    options=(
        1 "Git" off
        2 "Lsd" off
        3 "Oh my zsh" off
        4 "bd" off
        5 "dot net sdk" off
        6 "Node" off
        7 "Yarn" off
        8 "Docker" off
        9 "Docker compose" off
        10 "Emacs" off
        11 "Dustn" off
        12 "Kitty" off
        13 "Firacode 2" off
        14 "Furacode 2.0.0" off
        15 "Font awesome 5.12.1" off
        16 "Rust" off
    )
    genealChoices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
}

function installGeneralChoice() {
    for genealChoice in $genealChoices; do
        case $genealChoice in
        1)
            echo PRE INSTALLING GIT
            installGit
            ;;
        2)
            echo PRE INSTALLING LSD
            installLsd
            ;;
        3)
            echo PRE INSTALLING OH MY ZSH
            installOhMyZsh
            ;;
        4)
            echo PRE INSTALLING Bd
            installBd
            ;;
        5)
            echo PRE INSTALLING DOT NET SDK
            installDotnetSdk
            ;;
        6)
            echo PRE INSTALLING NODE
            installNode
            ;;
        7)
            echo PRE INSTALLING YARN
            installYarn
            ;;
        8)
            echo PRE INSTALLING DOCKER
            installDocker
            ;;
        9)
            echo PRE INSTALLING DOCKER COMPOSE
            installDockerCompose
            ;;
        10)
            echo PRE INSTALLING EMACS
            installEmacs
            ;;
        11)
            echo PRE INSTALLING DUNST
            installDunst
            ;;
        12)
            echo PRE INSTALLING KITTY
            installKitty
            ;;
        13)
            echo PRE INSTALLING FIRACODE
            installFiraCode
            ;;
        14)
            echo PRE INSTALLING PATCHED FIRACODE
            installFuraCode
            ;;
        15)
            echo PRE INSTALLING FONTAWESOME
            installFontAwesome
            ;;
        16)
            echo PRE INSTALLING RUST
            installRust
            ;;

        esac

    done

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
        yay -Sy --noconfirm yarn
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