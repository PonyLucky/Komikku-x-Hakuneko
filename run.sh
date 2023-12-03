#!/usr/bin/env bash

# If not root, exit
if [ ${EUID} -ne 0 ]
then
    echo "Not root"
    exit 1
fi

# 1) Script part
mkdir /root/.scripts
touch /root/.scripts/komikku_bind.sh
echo -e "#!/usr/bin/env bash\n" >> /root/.scripts/komikku_bind.sh
echo -e "# If not root, exit" >> /root/.scripts/komikku_bind.sh
echo -e "if [ \${EUID} -ne 0 ]\nthen" >> /root/.scripts/komikku_bind.sh
echo -e "    echo \"Not root\"" >> /root/.scripts/komikku_bind.sh
echo -e "    exit 1\nfi\n" >> /root/.scripts/komikku_bind.sh
echo -e "mount --bind /home/\$USER/Documents/Mangas /home/\$USER/.var/app/info.febvre.Komikku/data/local" >> /root/.scripts/komikku_bind.sh
chmod +x /root/.scripts/komikku_bind.sh

echo "[1/4] Script created"

# 2) Service part
touch /etc/systemd/system/komikku_bind.service
echo -e "[Unit]" >> /etc/systemd/system/komikku_bind.service
echo -e "Description=Bind local data of Komikku with Mangas folder in Documents" >> /etc/systemd/system/komikku_bind.service
echo -e "After=multi-user.target\n" >> /etc/systemd/system/komikku_bind.service
echo -e "[Service]" >> /etc/systemd/system/komikku_bind.service
echo -e "ExecStart=/usr/bin/bash /root/.scripts/komikku_bind.sh" >> /etc/systemd/system/komikku_bind.service
echo -e "Type=simple\n" >> /etc/systemd/system/komikku_bind.service
echo -e "[Install]" >> /etc/systemd/system/komikku_bind.service
echo -e "WantedBy=multi-user.target" >> /etc/systemd/system/komikku_bind.service

echo "[2/4] Service created"

# 3) Reaload deamon and start the service
systemctl daemon-reload
echo "[3/4] Daemon realoaded"
systemctl start komikku_bind.service
echo "[4/4] Service started"
echo -e "\nDone."

