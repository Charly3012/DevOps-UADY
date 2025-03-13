#!/bin/bash

sudo systemctl stop nginx
pkill ngrok


cd /var/www || exit

if [ ! -d "DevOps-UADY" ]; then
    sudo git clone https://github.com/Charly3012/DevOps-UADY
    echo "Repositorio clonado."
else
    cd DevOps-UADY || exit
    sudo git pull origin main || { echo "Error al actualizar el repositorio."; exit 1; }
    echo "Repositorio actualizado."
    cd ..
fi


sudo rm -rf /var/www/html/*
cd DevOps-UADY/PaginaWeb || exit
sudo cp -r . /var/www/html/


sudo systemctl start nginx || { echo "Error iniciando el servidor web"; exit 1; }

ngrok http 80 --log=stdout &> /tmp/ngrok.log &

sleep 5

NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)

echo "URL de la pagina desplegada: $NGROK_URL"
