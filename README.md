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
    Prepares a fully equipped Kali Linux environment for offensive security testing and lab use.

    🧃 Input: Root privileges required (sudo ./hydrate-2025.sh)

    🚀 Output: Updated, tool-loaded, Docker-configured Kali with cloned repos and installed dependencies

⚠️ Note: Includes the classic Kali ASCII dragon logo, shown before hydration begins.

    ✅ Root check: Ensures script is run as root before proceeding

    🎨 Color functions: Blue, green, red, yellow, purple echo formatting

    🐉 Displays version (v0.2.0) and Kali ASCII dragon banner

    📋 Menu: [1] Start, [2] Exit

    📦 System prep: apt update, upgrade, dist-upgrade

    🏗 Adds i386 architecture support

    🧰 Installs base tools: gpg, build-essential, jq, libkrb5-dev, dos2unix, gcc, tmux, chromium, libnss3-tools

    🐍 Python setup: python3.13-venv, pip3, pipx, with libraries like pandas, requests, bs4, stem, xlsxwriter, lolcat, etc.

    🔧 Installs common pentest tools:

        responder, mitm6, proxychains4, aircrack-ng, hostapd-wpe, gpp-decrypt, impacket, veil, veil-evasion, shellter, steghide, stegcracker, rlwrap, terminator, seclists, open-iscsi, ipmitool, pure-ftpd, rinetd, xrdp, ssh, openssh-server

    🧪 Pip tools installed: netexec, cython, pycryptodome, ssh-audit, shell-gpt

    🐳 Docker setup: Installs and configures Docker + Compose, adds user to docker group

    🧬 BloodHound-CE: Pulls docker-compose.yml, sets up in /opt/bloodhound-ce

    📁 Repos cloned from /opt/Kali-Rehydrate/repositories.txt

    📦 Automatically installs requirements.txt for each cloned repo

    🔁 Recursively installs all requirements.txt under /opt/*/

    📄 Creates badchars.txt in /opt/Kali-Rehydrate/ if missing

    🐾 Pulls gowitness Docker image

    🧠 Clones & installs:

        BloodHound.py, AD-Miner, DeathStar, NetRipper, mimikittenz, autoNTDS, php-reverse-shell, kerbrute, testssl.sh, nishang, mimipenguin, windows-privesc-check, Invoke-Obfuscation, Unicorn, MS17-010, ssh-badkeys, privilege-escalation-awesome-scripts-suite

    🏴 Installs Empire (as user sca)

    🎯 Installs DeathStar via pipx

    🔐 Installs and enables Tailscale SSH with tag tag:ssh

    🖥 Sets up XRDP

    🌐 Starts SSH service

    🧪 Optionally installs: Nessus, TeamViewer

    🧹 Cleans up unused packages with autoremove

    ✅ Final message: "Kali Rehydration is complete. Kali's thirst has been quenched."
