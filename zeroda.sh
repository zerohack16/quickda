#!/bin/bash
# Descripción: mini script para la validacion de directadmin
echo "                    ˍ▂▃▄▄
                   ◢████████◤
          ◢        ██████████▆▄
          ◥◣     ███████████████◣
            ◥◣◢███████████████████◤
               ◥████████████████◤
        █◣  ▌██████████████◣
        ███◣▌█▄▄ ◥███████████◣
        █ ◥█▌█     ◥██████████
        █  ◥▌████    ◥████████◣
             ▇▇◣  ██   ◥███████
             █  █ ██   ◢███████▌
             ███◤ ██ ◢◤   ◥█████◣
             █ ◥◣ ██◤       ◥████
  GOD'S IN HIS HEAVEN,        ◥██
    ALL'S RIGHT WITH THE WORLD. ◥"

echo ""
echo "++++++++++++++++++++++++++++++++++++"
echo "Fixing up DirectAdmin license"
echo "++++++++++++++++++++++++++++++++++++"

echo "Setting up DA channel to current"
CHANNEL=current
echo "Done"
echo ""

echo "Setting up OS (currently only works for AMD64 and compatible)"
OS_SLUG=linux_amd64
echo "Done"
echo ""

echo "Setting up DA version"
COMMIT=$(dig +short -t txt "$CHANNEL-version.directadmin.com" | sed 's|.*commit=\([0-9a-f]*\).*|\1|')
echo "$COMMIT"
echo ""

echo "File to download"
FILE="directadmin_${COMMIT}_${OS_SLUG}.tar.gz"
echo "$FILE"

echo "Downloading file: "
curl --location --progress-bar --connect-timeout 10 "https://download.directadmin.com/${FILE}" --output "/root/${FILE}"
echo "Done"
echo ""

echo "Untar the file in path: /root"
tar xzf "/root/${FILE}" -C /usr/local/directadmin
echo "Done"
echo ""

echo "Setting up permissions "
/usr/local/directadmin/directadmin permissions || true
echo "Done"
echo ""

echo "Updating"
/usr/local/directadmin/scripts/update.sh
echo "Done"
echo ""

echo "restarting DirectAdmin service"
service directadmin restart
echo ""

echo "clean up files"
rm "/root/${FILE}"
echo "Done"
echo ""

echo ""
echo "++++++++++++++++++++++++++++++++++++"
echo "Fixed up DirectAdmin License"
echo "++++++++++++++++++++++++++++++++++++"