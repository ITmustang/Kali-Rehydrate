#!/bin/zsh
# Hydrate Kali with testing preferences and pentest repos
# Version 0.3.1
# Updated: 2025-03-25

set -euo pipefail

# ----------- Color Functions ------------
color_echo() {
    local color_code="$1"; shift
    echo -e "\033[${color_code}m$*\033[0m"
}
blue_echo()    { color_echo 34 "$@"; }
green_echo()   { color_echo 32 "$@"; }
red_echo()     { color_echo 31 "$@"; }
yellow_echo()  { color_echo 33 "$@"; }
purple_echo()  { color_echo 35 "$@"; }

# ----------- Root Check ------------
if [ "$EUID" -ne 0 ]; then
    red_echo "Error: This script must be run as root."
    green_echo "Use: sudo ./hydrate-2025.sh"
    exit 1
fi

# ----------- Menu Banner ------------
version_number="v0.3.1"
clear
purple_echo "Starting Kali Rehydration - Version $version_number"
blue_echo "MENU:"
green_echo "[1] Start"
red_echo "[2] Exit"
read -p "Enter your choice: " choice

case $choice in
1)
    blue_echo "Updating system and installing base packages..."
    apt-get update -y -qq

    apt-get install -y -qq \
        gpg python3.13-venv dos2unix build-essential libkrb5-dev \
        wine32:i386 python3-pip open-iscsi pipx vmfs-tools kpartx \
        golang-go chromium libnss3-tools proxychains4 mitm6 responder \
        docker.io gcc jq hostapd-wpe aircrack-ng python3-impacket \
        impacket-scripts mingw-w64 pure-ftpd crackmapexec rinetd \
        gcc-9-base libgcc-9-dev libc6-dev terminator seclists \
        steghide stegcracker rlwrap veil veil-evasion shellter \
        airgeddon xrdp ssh openssh-server npm leafpad mitm6 gpp-decrypt

    systemctl enable docker --now
    usermod -aG docker "$USER"
    systemctl enable xrdp ssh
    systemctl start xrdp ssh

    pip3 install --break-system-packages \
        pandas openpyxl requests beautifulsoup4 stem tor \
        shell-gpt xlsxwriter lolcat pycryptodome ssh-audit cython

    pipx install poetry
    pipx install git+https://github.com/Mazars-Tech/AD_Miner.git
    pipx install git+https://github.com/Pennyw0rth/NetExec
    pipx ensurepath

    blue_echo "Installing Nessus..."
    cd /opt
    curl -L -o nessus.deb "https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.8.2-ubuntu1604_amd64.deb"
    dpkg -i nessus.deb || apt-get install -f -y
    rm nessus.deb
    systemctl enable nessusd
    systemctl start nessusd

    if ! command -v teamviewer &>/dev/null; then
        blue_echo "Installing TeamViewer..."
        wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
        dpkg -i teamviewer_amd64.deb || apt-get install -f -y
        rm teamviewer_amd64.deb
    else
        yellow_echo "TeamViewer is already installed."
    fi

    blue_echo "Installing Tailscale..."
    tailscale down || true
    apt-get remove --purge -y tailscale || true
    apt-get autoremove -y
    curl -fsSL https://tailscale.com/install.sh | sh
    apt-get update && dpkg --configure -a
    tailscale up --ssh
    systemctl enable --now tailscaled

    blue_echo "Processing repositories from repositories.txt..."
    REPO_FILE="/opt/Kali-Rehydrate/repositories.txt"
    mkdir -p /opt/Kali-Rehydrate
    dos2unix "$REPO_FILE"

    total_repos=$(wc -l < "$REPO_FILE")
    index=1

    while read -r repo args; do
        repo_name=$(basename "$repo" .git)
        target="/opt/$repo_name"

        echo "--------------------------------------------------"
        blue_echo "[$index/$total_repos] Cloning $repo..."

        if [ -d "$target" ]; then
            yellow_echo "$repo_name already exists. Skipping..."
        else
            git clone $args "$repo" "$target"
            green_echo "Cloned $repo_name."

            if [ -f "$target/requirements.txt" ]; then
                blue_echo "Installing Python requirements for $repo_name..."
                pip3 install -r "$target/requirements.txt" --break-system-packages
            fi
        fi
        ((index++))
    done < "$REPO_FILE"

    blue_echo "Checking all /opt subfolders for requirements.txt..."
    for d in /opt/*/; do
        if [ -f "$d/requirements.txt" ]; then
            green_echo "Installing requirements in: $d"
            pip3 install -r "$d/requirements.txt" --break-system-packages
        fi
    done

    chmod +x /opt/nmapAutomator/nmapAutomator.sh || true

    blue_echo "Installing BloodHound.py..."
    [ ! -d /opt/BloodHound.py ] && git clone https://github.com/dirkjanm/BloodHound.py /opt/BloodHound.py
    cd /opt/BloodHound.py
    pip3 install . --break-system-packages

    cd /opt/wafw00f && pipx install git+https://github.com/EnableSecurity/wafw00f.git

    cd /opt/pywerview
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt --break-system-packages
    deactivate

    chown kali:kali -R /opt/Empire
    su -c 'cd /opt/Empire/setup && bash ./checkout-latest-tag.sh && cd .. && bash ./ps-empire install -y' kali

    cd /opt/DeathStar
    pip3 install -r requirements.txt --break-system-packages
    pipx install deathstar-empire

    # --------- Install smbclient-ng ----------
    blue_echo "Installing smbclient-ng..."
    if [ -d "/opt/smbclient-ng" ]; then
        cd /opt/smbclient-ng
        pipx install smbclientng
    else
        red_echo "smbclient-ng directory not found. Ensure it was cloned properly."
    fi

    apt-get autoremove -y -qq

    green_echo "✅ Kali Rehydration is complete. All tools installed successfully."
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
