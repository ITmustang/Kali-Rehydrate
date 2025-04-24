# Kali-Rehydrate


                                    .^                                
                                   :PB7                               
                                  :G!.PJ                              
                                 :B!   PY                             
                                ^B~     5Y                            
      ....::::::::.....        !B^       55                           
    ..:::^^~~!!!7??JJJJJJJ?7!~^J^         JP.                         
                 ...:::^~!7?JY555Y?!^..    7G:                        
       ..::^~!77?JJJYYYYYYYYYYYY5PGG#^..    7G.                       
      :^~~!77777!!!~~~^^^^^^^~!7?JY55P5GJ..  JY.                    
             .:~7JYYYJ?!~^YJ.........~#GYJ??7!~^^^~~^:                
         .^!7??7!^:.     ~#:     ..^?G&#BGPPGGBBGB5?J77~.             
       :^~~^:.          .B7     ..7#&Y!::.....:7B?YPBGB5J~..          
       .                YP     ..7@#~...       .B~ .:~?#@&J:.         
                       ^#:     .:G@J...         J5   ..~JP#P!^.       
                       5J      .:G@5:..         ~B       .:7P?.       
                      :#:      ..7&@J:..        :#.                   
                      ?G        ..!B@B?~:..     :#:                   
                      5J         ..:7P##BP5YJJJJJB?!!~^:..            
                      B!             .:~7?JJYYY5GGGB#&&BPY?7~:        
                      #^                       .G!.::~7J5GPJJYJ!.     
                      G!                       !B      ..^?PJ^~JY!    
                      YY                       G7         .:YG^.^J7   
                      ^#:                     JP           ..7G^..!^  
                       ?P                    7G.            . 75....  
                        JP:                 JP:                J~     
                         ~5J!^.          :75?                  :!     
                           ^!?JJ?7!!!!!?JJ!.                    :     
                                .:^~~~^:.                       :                       
                      __ __ ___    __    ____ 
                     // //  /  |  / /   /  _/                              
                    / ,<  / /| | / /    / /                                
                   / /| |/ ___ |/ /____/ /                                 
                  /_/ |_/_/ _|_/_____/___/ ______  ____  ___  ____________
                  / __ \/ ____/ / / /\ \/ / __ \/ __ \/   |/_  __/ ____/
                 / /_/ / __/ / /_/ /  \  / / / / /_/ / /| | / / / __/   
                / _, _/ /___/ __  /   / / /_/ / _, _/ ___ |/ / / /___   
               /_/ |_/_____/_/ /_/   /_/_____/_/ |_/_/  |_/_/ /_____/   

🛠️ What It Does

    Fully rehydrates Kali Linux with your preferred pentest tools, services, configurations, and repositories — all from a single script run.

    🧃 Input: Must be run with sudo or as root

    🚀 Output: A Kali system loaded with tools, frameworks, Docker containers, remote access configs, and cloned GitHub repositories

🐉 Includes the classic Kali ASCII dragon logo and version banner for a dramatic launch!
🔧 Features & Workflow

    🛑 Root Privilege Check

        Exits if not executed as root

    🎨 Colorized Output

        Custom blue_echo, green_echo, red_echo, yellow_echo, purple_echo functions

    📟 Menu Display

        Option 1: Start hydration

        Option 2: Exit

💾 System Setup

    Updates package lists

    Upgrades and dist-upgrades system packages

    Adds 32-bit architecture (i386)

    Installs core utilities:

        gpg, build-essential, libkrb5-dev, jq, gcc, tmux, chromium, dos2unix, python3.13-venv, pipx, pip3, npm

🧪 Python & Pip Tools

    Installs:

        pandas, openpyxl, requests, bs4, stem, tor, xlsxwriter, shell-gpt, lolcat

    Ensures pipx is available and paths are set

📦 Pentest Tools & Utilities

    Tools installed via apt or pipx:

        responder, mitm6, hostapd-wpe, aircrack-ng, proxychains4, veil, veil-evasion, netexec, ssh-audit, gpp-decrypt, vmfs-tools, kpartx, golang-go, libnss3-tools, impacket, impacket-scripts, mingw-w64, pure-ftpd, rinetd, terminator, seclists, steghide, stegcracker, rlwrap, xrdp, ssh, openssh-server, shellter, airgeddon

🐳 Docker Setup & BloodHound

    Installs Docker and Docker Compose

    Enables Docker and adds user to group

    Deploys BloodHound-CE with preloaded docker-compose.yml

🧬 GitHub Repo Cloning & Setup

    Converts repositories.txt to Unix format

    Loops through each repo in /opt/Kali-Rehydrate/repositories.txt

        Clones to /opt/

        Checks for and installs requirements.txt

    Recursively scans all /opt/*/ directories for additional requirements.txt files and installs them

🐾 Specialized Setup

    Creates and places badchars.txt if missing

    Pulls and installs:

        gowitness Docker image

        BloodHound.py

        AD-Miner

        DeathStar

        NetRipper

        mimikittenz

        Invoke-Obfuscation

        autoNTDS

        php-reverse-shell

        kerbrute

        testssl.sh

        TrustedSec Unicorn

        MS17-010 repo

        windows-privesc-check

        privilege-escalation-awesome-scripts-suite

        ssh-badkeys

        nishang

        mimipenguin

🎯 Empire & DeathStar Install

    Clones Empire repo and installs it (via user sca)

    Installs DeathStar and required dependencies

🔐 Remote Access

    Installs and starts:

        xrdp

        ssh services

    Installs and configures Tailscale with:

        Tag tag:ssh

        SSH enabled

        Automatic startup via systemctl

🔍 Extra Optional Installs

    Installs Tenable Nessus

    Installs TeamViewer if not already installed

🧹 Cleanup & Final Touches

    Runs autoremove to clean unused packages

    Ends with message:

        ✅ “Kali Rehydration is complete. Kali’s thirst has been quenched.”
