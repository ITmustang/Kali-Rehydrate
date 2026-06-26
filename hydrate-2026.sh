#!/bin/zsh
#Hydrate Kali with testing preferences and pentest repos
#Version 3.0
#Updated:

# Function to echo text in blue
blue_echo() {
    echo -e "\033[34m$1\033[0m"
}

# Function to echo text in green
green_echo() {
    echo -e "\033[32m$1\033[0m"
}

# Function to echo text in red
red_echo() {
    echo -e "\033[31m$1\033[0m"
}

# Function to echo text in yellow
yellow_echo() {
    echo -e "\033[33m$1\033[0m"
}

# Function to echo text in purple
purple_echo() {
    echo -e "\033[35m$1\033[0m"
}

# ------ Idempotency Helpers ------
# Install apt packages only if not already installed (uses dpkg for accuracy)
apt_install_if_missing() {
    local missing=()
    for pkg in "$@"; do
        if ! dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -gt 0 ]; then
        apt-get install -y -qq --no-install-recommends "${missing[@]}"
    fi
}

# Install pipx package only if not already installed
pipx_install_if_missing() {
    local pkg="$1"
    local name
    name=$(basename "$pkg" .git)
    if ! pipx list --short 2>/dev/null | grep -qi "$name"; then
        pipx install "$pkg"
    fi
}

# Install pip3 package only if not already installed (checks import)
pip3_install_if_missing() {
    local pkg="$1"
    if ! python3 -c "import $pkg" 2>/dev/null; then
        pip3 install "$pkg" --break-system-packages
    fi
}

# Pull docker image only if not present locally
docker_pull_if_missing() {
    if ! docker image inspect "$1" &>/dev/null; then
        docker pull "$1"
    fi
}

# ------ Root Checker ------
if [ "$EUID" -ne 0 ]; then
    red_echo "Error: "
    echo "This script must be run as root. Use "
    green_echo "sudo ./hydrate-2025.sh"
    echo "Exiting..."
    exit 1
fi

# ----- Kali Rehydrate Menu -----
version_number="v0.3.0"
blue_echo "
                                   .^
                                   :PB7
                                  :G!.PJ
                                 :B!   PY
                                ^B~     5Y
      ....::::::::.....        !B^       55
    ..:::^^~~!!!7??JJJJJJJ?7!~^J^         JP.
                 ...:::^~!7?JY555Y?!^..    7G:
       ..::^~!77?JJJYYYYYYYYYYYY5PGG#^..    7G.
  .:^~~!77777!!!~~~^^^^^^^~!7?JY55P5GJ..     JY
 .......          .:^!7JY55PP55YYJJJ!G7...    :::..
             .:~7JYYYJ?!~^YJ.........~#GYJ??7!~^^^~~^:.
         .^!7??7!^:.     ~#:     ..^?G&#BGPPGGBBGB5?J77~.
       :^~~^:.          .B7     ..7#&Y!::.....:7B?YPBGB5J~..
       .                YP     ..7@#~...       .B~ .:~?#@&J:.
                       ^#:     .:G@J...         J5   ..~JP#P!^.
                       5J      .:G@5:..         ~B       .:7P?.
                      :#:      ..7&@J:..        :#.
                      ?G        ..!B@B?~:..     :#:
                      5J         ..:7P##BP5YJJJJJB?!!~^..
                      B!             .:~7?JJYYY5GGGB#&&BPY?7~:
                      #^                       .G!.::~7J5GPJJYJ!.
                      G!                       !B      ..^?PJ^~JY!
                      YY                       G7         .:YG^.^J7
                      ^#:                     JP           ..7G^..!^
                       ?P                    7G.            . 75....
                        JP:                 JP:                J~
                         ~5J!^.          :75?                  :!
                           ^!?JJ?7!!!!!?JJ!.                    :
                                .:^~~~^:.                       :"
purple_echo "
    __ __ ___    __    ____
   / //_//   |  / /   /  _/
  / ,<  / /| | / /    / /
 / /| |/ ___ |/ /____/ /
/_/ |_/_/  |_/_____/___/  \033[32m______  ____  ___  ____________
   / __ \/ ____/ / / /\ \/ / __ \/ __ \/   |/_  __/ ____/
  / /_/ / __/ / /_/ /  \  / / / / /_/ / /| | / / / __/
 / _, _/ /___/ __  /   / / /_/ / _, _/ ___ |/ / / /___
/_/ |_/_____/_/ /_/   /_/_____/_/ |_/_/  |_/_/ /_____/   \033[93;1m$version_number
"

# Display Menu
blue_echo "MENU:"
green_echo "[1] Start"
red_echo "[2] Exit"

# Get User Input
echo -n "Enter your choice: "
read choice

# Process User Choice
case $choice in
    1)
        blue_echo "Kali is thirsty and must rehydrate... Starting \033[35mKali \033[32mRehydrate..."
        sleep 5
        # ----- Install packages and update/upgrade -----
        blue_echo "Installing gpg..."
        apt_install_if_missing gpg

        blue_echo "Updating package lists..."
        apt-get update -y -qq

        blue_echo "Upgrading installed packages..."
        apt-get upgrade -y -qq

        blue_echo "Installing Python3.13-venv..."
        apt_install_if_missing python3.13-venv

        blue_echo "Installing pipx..."
        apt_install_if_missing pipx

        blue_echo "dos2unix install..."
        apt_install_if_missing dos2unix

        blue_echo "Installing build essential..."
        apt_install_if_missing build-essential

        blue_echo "Installing libkrb5-dev..."
        apt_install_if_missing libkrb5-dev

        blue_echo "Configuring architecture for compatibility..."
        dpkg --add-architecture i386
        apt-get update -y -qq

        blue_echo "Installing wine32..."
        apt_install_if_missing wine32 wine32:i386

        blue_echo "Installing Python 3 pip..."
        apt_install_if_missing python3-pip

        blue_echo "Installing tmux..."
        apt_install_if_missing tmux

        blue_echo "Installing open-iscsi..."
        apt_install_if_missing open-iscsi

        blue_echo "Installing ipmitool..."
        apt_install_if_missing ipmitool

        blue_echo "Installing smbclientng..."
        pipx_install_if_missing smbclientng

        blue_echo "Installing gpp-decrypt..."
        apt_install_if_missing gpp-decrypt

        blue_echo "Installing vmfs-tools..."
        apt_install_if_missing vmfs-tools

        blue_echo "Installing kpartx..."
        apt_install_if_missing kpartx

        blue_echo "Installing golang-go..."
        apt_install_if_missing golang-go

        blue_echo "Installing Chromium..."
        apt_install_if_missing chromium

        blue_echo "Installing libnss3-tools..."
        apt_install_if_missing libnss3-tools

        blue_echo "Installing proxychains..."
        apt_install_if_missing proxychains4

        blue_echo "Installing mitm6..."
        apt_install_if_missing mitm6

        blue_echo "Installing responder..."
        apt_install_if_missing responder

        blue_echo "Installing Docker and Docker Compose..."
        apt_install_if_missing docker.io
        if command -v docker &>/dev/null; then
            systemctl enable docker --now 2>/dev/null || true
            if [ -n "$SUDO_USER" ]; then
                usermod -aG docker "$SUDO_USER"
            fi
        fi
        if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
            echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
                tee /etc/apt/sources.list.d/docker.list
            curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            apt-get update -qq
        fi
        apt_install_if_missing docker-ce docker-ce-cli containerd.io

        blue_echo "Installing gcc..."
        apt_install_if_missing gcc

        blue_echo "Installing jq..."
        apt_install_if_missing jq

        blue_echo "Installing hostapd-wpe..."
        apt_install_if_missing hostapd-wpe

        blue_echo "Installing aircrack-suite..."
        apt_install_if_missing aircrack-ng

        blue_echo "Installing Impacket..."
        apt_install_if_missing python3-impacket

        blue_echo "Installing Impacket Scripts..."
        apt_install_if_missing impacket-scripts

        blue_echo "Installing Mingw-w64..."
        apt_install_if_missing mingw-w64

        blue_echo "Installing Pure-FFTPd..."
        apt_install_if_missing pure-ftpd

        blue_echo "Installing Rinetd..."
        apt_install_if_missing rinetd

        blue_echo "Installing Terminator..."
        apt_install_if_missing terminator

        blue_echo "Installing SecLists..."
        apt_install_if_missing seclists

        blue_echo "Installing rlwrap..."
        apt_install_if_missing rlwrap

        blue_echo "Installing Veil..."
        apt_install_if_missing veil

        blue_echo "Installing Veil Evasion..."
        apt_install_if_missing veil-evasion

        blue_echo "Installing Shellter..."
        apt_install_if_missing shellter

        blue_echo "Installing Airgeddon..."
        apt_install_if_missing airgeddon

        blue_echo "Installing XRDP..."
        apt_install_if_missing xrdp
        if command -v xrdp &>/dev/null; then
            systemctl enable xrdp 2>/dev/null || true
            systemctl start xrdp 2>/dev/null || true
        fi

        blue_echo "Installing and starting SSH..."
        apt_install_if_missing ssh openssh-server
        if command -v sshd &>/dev/null; then
            systemctl enable ssh 2>/dev/null || true
            systemctl start ssh 2>/dev/null || true
        fi

        blue_echo "Installing misc PIP3 tools..."
        for pkg in pandas openpyxl requests beautifulsoup4 stem tor shell-gpt xlsxwriter lolcat; do
            pip3_install_if_missing "$pkg"
        done

        blue_echo "Installing misc tools..."
        apt_install_if_missing nuclei sipvicious sipsak

        blue_echo "Installing npm..."
        apt_install_if_missing npm

        blue_echo "Installing AD-Miner..."
        pipx_install_if_missing 'git+https://github.com/Mazars-Tech/AD_Miner.git'
        pipx ensurepath;

        blue_echo "Installing Bloodhound-ce..."
        if [ ! -f /opt/bloodhound-cli-linux-amd64/bloodhound-cli ] && [ ! -f /opt/bloodhound-cli/bloodhound-cli ]; then
            cd /opt/
            wget -q https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-linux-amd64.tar.gz
            tar -xzf bloodhound-cli-linux-amd64.tar.gz
            rm bloodhound-cli-linux-amd64.tar.gz
        fi
        if [ -f /opt/bloodhound-cli-linux-amd64/bloodhound-cli ]; then
            /opt/bloodhound-cli-linux-amd64/bloodhound-cli install
        elif [ -f /opt/bloodhound-cli/bloodhound-cli ]; then
            /opt/bloodhound-cli/bloodhound-cli install
        fi

        blue_echo "Updating package lists..."
        apt-get update -qq

        blue_echo "Performing dist-upgrade..."
        apt-get dist-upgrade -y -qq

        # ----- Tidy up -----
        blue_echo "Removing unnecessary packages..."
        apt autoremove && apt autoclean -y -qq

        # ------ git repositories.txt dos2unix clean-up ------------
        if [ -d /opt/Kali-Rehydrate/ ]; then
            blue_echo "converting repository file dos2unix..."
            dos2unix -q /opt/Kali-Rehydrate/repositories.txt
        fi

        # ----- Clone git repositories loop -----
        repositories_file="/opt/Kali-Rehydrate/repositories.txt"
        if [ -f "$repositories_file" ]; then
            total_repositories=$(wc -l < "$repositories_file")
            current_repo_index=1
            while read -r repo_url args; do
                repo_name=$(basename "$repo_url" .git)
                destination="/opt/$repo_name"

                echo "--------------------------------------------------------------------"
                blue_echo "Processing Git $current_repo_index of $total_repositories: $repo_url"

                if [ -d "$destination" ]; then
                    yellow_echo "Git repository already exists. Skipping..."
                else
                    git clone "$repo_url" "$destination" $args
                    green_echo "Git repository cloned successfully."

                    if [ -f "$destination/requirements.txt" ]; then
                        blue_echo "Found requirements.txt in $repo_name. Installing Python dependencies..."
                        pip3 install -r "$destination/requirements.txt" --break-system-packages
                    fi
                fi

                ((current_repo_index++))
            done < "$repositories_file"
            echo "--------------------------------------------------------------------"
        else
            yellow_echo "Repositories file not found. Skipping git clones."
        fi

        # ------ Scan ALL /opt folders for requirements.txt ------
        blue_echo "Scanning all /opt subdirectories for requirements.txt files..."
        for dir in /opt/*/ ; do
            if [ -f "$dir/requirements.txt" ]; then
                green_echo "Found requirements.txt in: $dir (pip will skip already-satisfied packages)"
                pip3 install -r "$dir/requirements.txt" --break-system-packages
            fi
        done

        # ----- Setup bad characters txt file in /usr/opt/HackRepo ----
        blue_echo "Setting up Bad Characters File..."
        if [ ! -f "/opt/Kali-Rehydrate/badchars.txt" ]; then
            if [ -f "/usr/bin/badchars.txt" ]; then
                cp /usr/bin/badchars.txt /opt/Kali-Rehydrate/badchars.txt
            else
                yellow_echo "Source badchars.txt not found at /usr/bin/badchars.txt. Skipping."
            fi
        else
            yellow_echo "badchars.txt already exists. Skipping..."
        fi

        # ---- docker image installs ------
        blue_echo "Installing gowitness..."
        docker_pull_if_missing ghcr.io/sensepost/gowitness:latest

        # ----- Pip3 Install Respositories -----
        blue_echo "pip3 installing pycryptodome/cython/ssh-audit..."
        for pkg in pycryptodome cython; do
            pip3_install_if_missing "$pkg"
        done
        # ssh-audit provides a binary; check by command
        if ! command -v ssh-audit &>/dev/null; then
            pip3 install ssh-audit --break-system-packages
        fi

        # ----- Install BloodHound Ingestor -----
        blue_echo "Installing BloodHound-CE Ingestor..."
        pipx_install_if_missing bloodhound-ce

        # ---- empty install placeholders (repos cloned from repositories.txt) ----
        blue_echo "Installing windows-privesc-check..."

        # ---- privilege-escalation-awesome-scripts-suite ---
        blue_echo "Installing privilege-escalation-awesome-scripts-suite..."

        # ----- ssh-badkeys -----
        blue_echo "Installing ssh-badkeys..."

        # ---- nishang -----
        blue_echo "Installing nishang..."

        # ---- mimipenguin -----
        blue_echo "Installing mimipenguin..."

        #  ---- netexec -----
        blue_echo "Installing netexec..."
        pipx_install_if_missing git+https://github.com/Pennyw0rth/NetExec;
        pipx ensurepath;

        #  ---- poetry -----
        blue_echo "Installing poetry..."
        pipx_install_if_missing poetry

        # ---- Install Impacket ----
        blue_echo "Installing Impacket..."
        if [ -d /opt/impacket/ ]; then
            if [ -f /opt/impacket/requirements.txt ]; then
                pip3 install -r /opt/impacket/requirements.txt --break-system-packages;
            fi
            pip3_install_if_missing impacket
        fi
        pipx ensurepath;

        # ---- Install MS17-010 ----
        blue_echo "Installing MS17-010 Repo..."

        # ---- Install Kerbrute ----
        blue_echo "Installing Kerbrute..."

        # ---- Install php-reverse-shell ----
        blue_echo "Installing php-reverse-shell..."

        # ---- Install Gobuster ----
        blue_echo "Installing Gobuster..."

        # ---- Install Trustedsec-Unicorn ----
        blue_echo "Installing Trustedsec-Unicorn..."

        # ---- Install NetRipper ----
        blue_echo "Installing NetRipper..."

        # ---- Install mimikittenz ----
        blue_echo "Installing mimikittenz..."

        # ---- Install Invoke-Obfuscation ---
        blue_echo "Invoke-Obfuscation..."

        # ---- Install autoNTDS ---
        blue_echo "Installing autoNTDS..."

        # ---- Install testssl.sh ----
        blue_echo "Installing testssl.sh..."

        # ---- Install ssh-audit ----
        blue_echo "Installing ssh-audit..."

        # ----- install empire -------
        blue_echo "Installing empire..."
        blue_echo "docker run -it -p 1337:1337 bcsecurity/empire:latest"
        blue_echo "username: empireadmin & password: password123"
        blue_echo "install deathstar plugin once logged in..."
        docker_pull_if_missing bcsecurity/empire:latest

        #---------------- install tailscale -----------------
        if command -v tailscale &>/dev/null; then
            blue_echo "Uninstalling existing TailScale..."
            tailscale down 2>/dev/null || true
            apt-get remove --purge -y tailscale
            apt-get autoremove -y
        fi

        blue_echo "Installing TailScale..."
        curl -fsSL https://tailscale.com/install.sh | sh;
        apt-get update && dpkg --configure -a;

        blue_echo "Configuring and Starting TailScale..."
        systemctl enable --now tailscaled 2>/dev/null || true
        tailscale up --ssh --advertise-tags=tag:ssh

        # ----- install nessus ------
        blue_echo "Installing Tenable Nessus..."
        if ! command -v nessusd &>/dev/null && ! dpkg -l nessus 2>/dev/null | grep -q "^ii"; then
            cd /opt/
            curl --request GET \
                --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.10.1-ubuntu1604_amd64.deb' \
                --output 'Nessus-10.10.1-ubuntu1604_amd64.deb'
            dpkg -i Nessus-10.10.1-ubuntu1604_amd64.deb
            rm Nessus-10.10.1-ubuntu1604_amd64.deb
            systemctl enable nessusd 2>/dev/null || true
            systemctl start nessusd 2>/dev/null || true
        else
            yellow_echo "Nessus already installed. Skipping."
        fi

        # ----- Install TeamViewer if not installed -----
        if ! command -v teamviewer &> /dev/null; then
            blue_echo "Installing TeamViewer..."
            wget -q https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
            dpkg -i teamviewer_amd64.deb
            apt-get install -f -y
            rm teamviewer_amd64.deb
        else
            yellow_echo "TeamViewer is already installed."
        fi

        # Display completion message
        green_echo "\033[35mKali \033[32mRehydration is complete. Kali's thirst has been quenched."
        ;;
    2)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac
