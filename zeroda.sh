 #!/bin/bash
# Descripción: mini script para la validacion de directadmin


#echo "                    ˍ▂▃▄▄
#                   ◢████████◤
#          ◢        ██████████▆▄
#          ◥◣     ███████████████◣
#            ◥◣◢███████████████████◤
#               ◥████████████████◤
#        █◣  ▌██████████████◣
#        ███◣▌█▄▄ ◥███████████◣
#        █ ◥█▌█     ◥██████████
#        █  ◥▌████    ◥████████◣
#             ▇▇◣  ██   ◥███████
#             █  █ ██   ◢███████▌
#             ███◤ ██ ◢◤   ◥█████◣
#             █ ◥◣ ██◤       ◥████
#  GOD'S IN HIS HEAVEN,        ◥██
#    ALL'S RIGHT WITH THE WORLD. ◥"
#
#echo ""
#
#echo "          
#                         
#                         
#          --- +=         
#          -%- ++ -.      
#     :::: --- . +++-     
#     :::-:   ** +#++     
#     :::::  ****+++.     
#     ::::   ***+         
#   -: -:     +=  .. ++   
#  -=- .             =+   
#  ---::              .   
#   . ::          ## :=-  
#   :=            ##:=#-  
#  ====           :: ---  
# ==++-#            :    
#  ===+           +*+.*   
#   ===          ****%#.  
#      .         ***#*-   
#     *#: .  ==  *#***    
#    .***   ####:*****    
#     ## .  ####.##+.     
#        *# #### %#       
#        *- ####          
#                        
#********Neubox******** 
#-Supreme web hosting-   
#          "
#


echo "++++++++++++++++++++++++++++++++++++"
echo "Fixing up DirectAdmin license"
echo "++++++++++++++++++++++++++++++++++++"


echo "fixing date to Mx time zone"
getunixtime=$(curl "http://worldtimeapi.org/api/timezone/America/Mexico_City"|cut -d"," -f12|cut -d":" -f2);
echo $getunixtime;
date +%s -s @$getunixtime;

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
curl -k --location --progress-bar --connect-timeout 10 "https://download.directadmin.com/${FILE}" --output "/root/${FILE}"
echo "Done"
echo ""

echo ""
echo "++++++++++++++++++++++++++++++++++++"
echo "Fixed up DirectAdmin License"
echo "++++++++++++++++++++++++++++++++++++"
