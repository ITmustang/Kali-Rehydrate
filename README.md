🧪 What It Does

🔹 Prepares a fully equipped Kali Linux environment for offensive security testing and lab use.

    📦 Input: Root privileges required (sudo ./hydrate-2025.sh)

    🚀 Output: Updated, tool-loaded, Docker-configured Kali with cloned repos and installed dependencies

    ⚠️ Note: Includes the classic Kali ASCII dragon logo, shown before hydration begins.

    ✅ Root check to ensure script is run with sudo

    🎨 Colorized echo output (blue, green, red, yellow, purple)

    🐉 Displays Kali ASCII dragon and version banner (v0.2.0)

    📋 Menu: [1] Start, [2] Exit

    📦 Runs full system update, upgrade, and dist-upgrade

    🏗 Adds i386 architecture for Wine compatibility

    🧰 Installs core utilities:

        gpg, build-essential, jq, libkrb5-dev, dos2unix, gcc, tmux, chromium, libnss3-tools

    🐍 Sets up Python 3.13 venv and installs tools via pip3 and pipx:

        pandas, requests, bs4, stem, tor, openpyxl, xlsxwriter, lolcat, shell-gpt

    🧪 Installs common pentest tools:

        responder, mitm6, proxychains4, veil, veil-evasion, hostapd-wpe, aircrack-ng, impacket, gpp-decrypt, pure-ftpd, rinetd, steghide, stegcracker, shellter, terminator, seclists, open-iscsi, ipmitool, xrdp, ssh, openssh-server

    🧬 Installs pip tools: netexec, cython, pycryptodome, ssh-audit

    🐳 Installs Docker and Docker Compose

    🧱 Configures BloodHound-CE in /opt/bloodhound-ce with docker-compose.yml

    📁 Clones GitHub repos listed in /opt/Kali-Rehydrate/repositories.txt

    📦 Installs Python dependencies for each repo (requirements.txt)

    🔁 Recursively scans /opt/*/ for additional requirements.txt files

    📄 Adds badchars.txt if missing in /opt/Kali-Rehydrate/

    🧠 Clones and installs:

        BloodHound.py, AD-Miner, DeathStar, NetRipper, mimikittenz, autoNTDS, Invoke-Obfuscation, Unicorn, php-reverse-shell, kerbrute, testssl.sh, nishang, mimipenguin, windows-privesc-check, MS17-010, ssh-badkeys, privilege-escalation-awesome-scripts-suite

    🏴 Installs Empire in /opt/Empire (runs as user sca)

    🎯 Installs DeathStar CLI using pipx

    🔐 Configures and enables Tailscale SSH (--advertise-tags=tag:ssh)

    🖥 Enables and starts XRDP and SSH services

    🧪 Installs Tenable Nessus and TeamViewer (if not present)

    🧹 Final system cleanup with apt autoremove

    ✅ Displays message: “Kali Rehydration is complete. Kali’s thirst has been quenched.”
