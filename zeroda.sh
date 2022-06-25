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
echo "Proceso de actualización Licencia DA"
echo "++++++++++++++++++++++++++++++++++++"

echo "creando variable canal para con el canal actual"
CHANNEL=current

echo "creando variable en donde se define el sistema operativo"
OS_SLUG=linux_amd64

echo "Obteniendo el numero de serie de la version actual de directadmin"
COMMIT=$(dig +short -t txt "$CHANNEL-version.directadmin.com" | sed 's|.*commit=\([0-9a-f]*\).*|\1|')
echo "$COMMIT"

echo "Definiendo en enlace de descarga"
FILE="directadmin_${COMMIT}_${OS_SLUG}.tar.gz"
echo "$FILE"

echo "Descargando el archivo"
curl --location --progress-bar --connect-timeout 10 "https://download.directadmin.com/${FILE}" --output "/root/${FILE}"

echo "Descompresion del archivo dentro de la carpeta /root"
tar xzf "/root/${FILE}" -C /usr/local/directadmin

echo "arreglando los permisos "
/usr/local/directadmin/directadmin permissions || true

echo "realiznado el update de la licencia"
/usr/local/directadmin/scripts/update.sh

echo "reiniciando servicio de DirectAdmin"
service directadmin restart

echo ""
echo "++++++++++++++++++++++++++++++++++++"
echo "Licencia de directadmin actualizada"
echo "++++++++++++++++++++++++++++++++++++"