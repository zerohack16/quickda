#!/bin/bash
# Descripción: download and run zeroDa to update directadmin license

echo "Downloading main script:"
wget https://raw.githubusercontent.com/zerohack16/quickda/main/zeroda.sh

echo "moving script to right path: "
mv zeroda.sh /root/

echo "setting up permissions"
chmod +x /root/zeroda.sh

/root/zeroda.sh
rm /root/zeroda.sh

echo "process done."