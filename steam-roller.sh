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

function installEmuDeck() {
    # Install EmuDeck from GitHub
    curl -L https://raw.githubusercontent.com/dragoonDorise/EmuDeck/main/install.sh | bash
}

function installCryoutilities() {
    # Install CryoUtilities from GitHub
    curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/install.sh | bash -s --
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
    echo "1. Install Decky"
    echo "2. Install Lutris"
    echo "3. Install Heroic"
    echo "4. Install EmuDeck"
    echo "5. Install CryoUtilities"
    echo "6. About"
    echo "7. Exit"
    echo "================="
}

function execute_function() {
    case $1 in
        Decky)
            installDecky
            ;;
        Lutris)
            installLutris
            ;;
        Heroic)
            installHeroic
            ;;
        EmuDeck)
            installEmuDeck
            ;;
        Cryoutilities)
            installCryoutilities
            ;;
        About)
            show_about
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
}

# Check if an argument is provided
if [ $# -eq 0 ]; then
    while true; do
        show_menu
        read -p "Enter your choice (1-7): " choice
        execute_function "$choice"
    done
else
    # If arguments are provided, execute the corresponding function
    for arg in "$@"; do
        execute_function "$arg"
    done
fi
