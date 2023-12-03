# Bind Komikku and HakuNeko together

On Linux only ;)

## Installation

### Hakuneko settings

1. Open HakuNeko.
2. Go to the settings menu (hamburger menu at the top left).
3. In the **Manga Directory** entry, press the folder icon and go to `/home/<USER>/Documents/Mangas`.
4. In the **Chapter Title Format** entry, write `Chapter %CH%`. *Optionnal but some websites don't order their chapters properly (eg. 0001, 0002, etc) so Komikku might misorder them.*
5. Press the check button at the bottom to save.

### Automatically, or

1. Open a terminal in the current folder (or go to this folder).
2. Type `sudo sh ./run.sh`

### Manually

1. Open a terminal.
2. Type `su` and enter password.
3. Type `mkdir /root/.scripts`.
4. Type `vim /root/.scripts/komikku_bind.sh` and enter:
```sh
#!/usr/bin/env bash

# If not root, exit
if [ ${EUID} -ne 0 ]
then
    echo "Not root"
    exit 1
fi

mount --bind /home/$USER/Documents/Mangas /home/$USER/.var/app/info.febvre.Komikku/data/local
```
5. Type `chmod +x /root/.scripts/komikku_bind.sh`
6. Type `vim /etc/systemd/system/komikku_bind.service` and enter:
```ini
[Unit]
Description=Bind local data of Komikku with Mangas folder in Documents
After=multi-user.target

[Service]
ExecStart=/usr/bin/bash /root/.scripts/komikku_bind.sh
Type=simple

[Install]
WantedBy=multi-user.target
```
7. Type `systemctl daemon-reload`.
8. Type `systemctl start komikku_bind.service`.

