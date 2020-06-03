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
