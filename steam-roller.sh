#!/bin/bash

# Initialize variables
file1=""
file2=""
file1name=""
file2name=""

function installDecky() {
    # Decky Loader Install - There is also a fast install for those who can use Konsole. https://github.com/SteamDeckHomebrew/decky-loader
    curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
}

function installLutris() {
    # Installs lutris from flathub https://lutris.net/downloads#:~:text=To%20install%20Lutris%20on%20the,choose%20%22Create%20Steam%20shortcut%22.
    flatpak install flathub net.lutris.Lutris
}

function installCrocShare() {
    # Installs croc from git via curl https://github.com/schollz/croc.
    curl https://getcroc.schollz.com | bash
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

function installSGDBoop() {
    # Install SteamGridDB Boop from flathub
    flatpak install flathub com.steamgriddb.SGDBoop
}

function setPasswd() {
    #!/bin/bash

    # Check if the password file exists
    if [ -e "/etc/passwd" ]; then
        echo "Password exists."
    else
        echo "Password not set. Please set a password."
        passwd  # Run the passwd command to set a password
    fi

}

function store_keys() {
    read -p "Enter the file path for prod keys: " file1
    read -p "Enter the file path for title keys: " file2

    # Read file contents into variables
    file1name=$(basename "$file1")
    file2name=$(basename "$file2")
    file1=$(base64 -w 0 "$file1")
    file2=$(base64 -w 0 "$file2")

    # Update script with key variables
    update_script

    echo "Keys stored successfully!"
}

function write_keys() {
    # Write keys to the file system
    base64 -d <<< $file1 > $file1name
    base64 -d <<< $file1 > $file2name

    echo "Keys written to the file system!"
}

function clear_keys() {
    file1=""
    file2=""
    file1name=""
    file2name=""
    echo "Keys cleared!"
}

function update_script() {
    # Create a copy of the script
    cp "$0" script_temp.sh

    # Modify the copy with updated key variables
    sed -i "s/^file1=.*/file1=\"$file1\"/" script_temp.sh
    sed -i "s/^file2=.*/file2=\"$file2\"/" script_temp.sh
    sed -i "s/^file1name=.*/file1name=\"$file1name\"/" script_temp.sh
    sed -i "s/^file2name=.*/file2name=\"$file2name\"/" script_temp.sh

    # Open the new script in a separate terminal
    xterm -e "bash script_temp.sh" &

    # Delete the original script
    rm "$0"
}

function show_about() {
    clear
    echo "=== About ==="
    echo "This is a simple menu system in Bash."
    echo "Author: Oisin Hickey"
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
    echo "5. Install Croc Share"
    echo "6. Install CryoUtilities"
    echo "7. Install SGDBoop"
    if [ -z "$file1" ] || [ -z "$file2" ]; then
        echo "8. Store Keys"
    else
        echo "8. Write Keys"
    fi
    echo "9. Clear Keys"
    echo "10. Set Password"
    echo "11. About"
    echo "12. Exit"
    echo "================="
}

function execute_function() {
    case $1 in
        1 | "Decky" | "decky")
            installDecky
            ;;
        2 | "Lutris" | "lutris")
            installLutris
            ;;
        3 | "Heroic" | "heroic")
            installHeroic
            ;;
        4 | "EmuDeck" | "emudeck")
            installEmuDeck
            ;;
        5 | "CrocShare" | "crocshare")
            installCrocShare
            ;;
        6 | "Cryoutilities" | "cryoutilities")
            installCryoutilities
            ;;
        7 | "SGDBoop" | "sgdboop")
            installSGDBoop
            ;;
        8)
            if [ -z "$file1" ] || [ -z "$file2" ]; then
                store_keys
            else
                write_keys
            fi
            ;;
        9 | "Clear Keys" | "clear keys")
            clear_keys
            ;;
        10 | "Set Password" | "set password")
            setPasswd
            ;;
        11 | "About" | "about")
            show_about
            ;;
        12 | "Exit" | "exit")
            exit 0
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
        read -p "Enter your choice (1-12 or name): " choice
        execute_function "$choice"
    done
else
    # If arguments are provided, execute the corresponding function
    for arg in "$@"; do
        execute_function "$arg"
    done
fi
