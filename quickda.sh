#!/bin/bash
# Descripción: download and run zeroDa to update directadmin license

wget https://raw.githubusercontent.com/zerohack16/quickda/main/zeroda.sh
mv zeroda.sh /root/
chmod +x zeroda.sh
/root/zeroda.sh
rm /root/zeroda.sh