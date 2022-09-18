#!/bin/bash
# Descripción: mini script para la validacion de directadmin

#zero color scheme
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

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

echo "          
                         
                         
          --- +=         
          -%- ++ -.      
     :::: --- . +++-     
     :::-:   ** +#++     
     :::::  ****+++.     
   -: -:     +=  .. ++   
  -=- .             =+   
   . ::          ## :=-  
 ==++-#            :     
   ===          ****%#.  
      .         ***#*-    
    .***   ####:*****    
     ## .  ####.##+.     
        *# #### %#       
        *- ####          
                        
********Neubox******** 
-Supreme web hosting-   



echo "++++++++++++++++++++++++++++++++++++"
echo "Fixing up DirectAdmin license"
echo "++++++++++++++++++++++++++++++++++++"


echo "checking redhat release "
centosCheck=$(cat /etc/redhat-release |awk {'print $3'});
echo "La versión del sistema operativo es : $centosCheck"
if [ "$centosCheck" = "6.10" ];
    then
        printf "${RED}";
        echo "  ";
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
        echo "La versión del sistema operativo no está soportada";
        echo "continuar con el script arruinara el servicio de "
        echo "--------------- DirectAdmin -----------------------"
        echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
        printf "${NORMAL}";
        notSupported=1;
    else
        notSupported=0;
        exit 0;
fi


if [ "$notSupported" = "0" ];
    then

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
    else
        exit 0
fi