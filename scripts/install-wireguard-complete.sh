#!/bin/bash

# Instalar dependências
sudo apt update
sudo apt install -y wireguard qrencode docker.io docker-compose

# Criar diretório para WireGuard
sudo mkdir -p /etc/wireguard
sudo chmod 700 /etc/wireguard

# Copiar scripts
sudo cp setup-wireguard-server.sh /usr/local/bin/
sudo cp add-wireguard-client.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/setup-wireguard-server.sh
sudo chmod +x /usr/local/bin/add-wireguard-client.sh

# Configurar servidor WireGuard
sudo /usr/local/bin/setup-wireguard-server.sh

# Iniciar WireGuard-UI
docker-compose up -d

echo "[+] Instalação completa!"
echo "[*] Interface web disponível em: http://localhost:5000"
echo "[*] Username: admin"
echo "[*] Password: admin"
echo "[*] Para adicionar um cliente: add-wireguard-client.sh <nome_do_cliente>"