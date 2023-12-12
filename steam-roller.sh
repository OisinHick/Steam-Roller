#!/bin/bash

function installDecky() {
    # Decky Loader Install - There is also a fast install for those who can use Konsole. https://github.com/SteamDeckHomebrew/decky-loader
    curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
}

function installLutris() {
    # Installs lutris from flathub https://lutris.net/downloads#:~:text=To%20install%20Lutris%20on%20the,choose%20%22Create%20Steam%20shortcut%22.
    flatpak install flathub net.lutris.Lutris
}

function installHeroic() {
    flatpak install flathub com.heroicgameslauncher.hgl
}

function show_about() {
  clear
  echo "=== About ==="
  echo "This is a simple menu system in Bash."
  echo "Author: Your Name"
  echo "Version: 1.0"
  echo "============="
  read -p "Press Enter to return to the main menu..."
}

function show_menu() {
  clear
  echo "=== Main Menu ==="
  echo "1. About"
  echo "2. Exit"
  echo "================="
}

while true; do
  show_menu
  read -p "Enter your choice (1-2): " choice

  case $choice in
    1)
      show_about
      ;;
    2)
      echo "Exiting..."
      exit 0
      ;;
    3)
      installDecky
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 2."
      read -p "Press Enter to continue..."
      ;;
  esac
done
