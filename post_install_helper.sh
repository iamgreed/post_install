function installDialog() {
  if ! [ -x "$(command -v dialog)" ]; then
    echo INSTALLING dialog
    pacman -S dialog
  else
    echo "Dialog already intalled"
  fi
}

function askDialog() {
  # dialog menu
  cmd=(dialog --separate-output --checklist "Please select category:" 22 76 16)

  options=(
    1 "General" on
    2 "Code" off
    3 "i3" off
  )
  categories=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
  clear

  for category in $categories; do
    case $category in
    1)
      #geneal dialog*
      askGeneralDialog
      ;;
    2)
      #code dialog*
      askCodeDialog
      ;;
    3)
      #i3 dialog*
      askI3Dialog
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