#!/bin/bash
function Script() {
tmpfile=$(mktemp tmp.XXXXXXX --tmpdir=/tmp 2>/dev/null) || tmpfile=/tmp/test$$

dialog          --backtitle "Pbis Grupo6"  \
                --title "Pbis Grupo6" \
                --clear \
                --menu "Elige una opcion:" 15 50 4 \
                1 "Instalar y configurar Pbis" \
                2 "Añadir usuarios a el archivo sudoers"  2> ${tmpfile}

if [ "$?" -eq "0" ]; then

grep -o 1 $tmpfile > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
	
      clear
      wget https://github.com/BeyondTrust/pbis-open/releases/download/9.1.0/pbis-open-9.1.0.551.linux.x86_64.deb.sh
      bash pbis-open-9.1.0.551.linux.x86_64.deb.sh
      clear
	  cd /opt/pbis/bin/
	  echo "Introduce contraseña de el usuario Administrador"
	  read Contrasena
	  /opt/pbis/bin/domainjoin-cli join grupo6.local Administrador $Contrasena
	  /opt/pbis/bin/domainjoin-cli query
	  echo 'greeter-show-manual-login=true' >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
	  clear
	  /opt/pbis/bin/config LoginShellTemplate /bin/bash
	  /opt/pbis/bin/config AssumeDefaultDomain true
      Script
    fi

grep -o 2 $tmpfile > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
      clear
    Script
    fi

else
    clear
    echo "Operacion Cancelada"

fi
}
apt update
apt install dialog ssh -y
apt remove avahi-daemon -y
clear
Script
