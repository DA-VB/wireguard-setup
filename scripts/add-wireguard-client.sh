#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <nome_do_cliente>"
    exit 1
fi

CLIENT_NAME=$1
CLIENT_IP="10.0.0.$(( $(ls /etc/wireguard/clients/ | wc -l) + 2 ))/32"

# Criar diretório para clientes
sudo mkdir -p /etc/wireguard/clients

# Gerar chaves do cliente
wg genkey | tee "/etc/wireguard/clients/${CLIENT_NAME}_private.key" | wg pubkey > "/etc/wireguard/clients/${CLIENT_NAME}_public.key"

# Criar configuração do cliente
cat << EOF > "/etc/wireguard/clients/${CLIENT_NAME}.conf"
[Interface]
PrivateKey = $(cat "/etc/wireguard/clients/${CLIENT_NAME}_private.key")
Address = ${CLIENT_IP}
DNS = 8.8.8.8

[Peer]
PublicKey = $(sudo cat /etc/wireguard/public.key)
AllowedIPs = 0.0.0.0/0
Endpoint = $(curl -s ifconfig.me):51820
PersistentKeepalive = 25
EOF

# Adicionar cliente ao servidor
cat << EOF | sudo tee -a /etc/wireguard/wg0.conf

# Cliente: ${CLIENT_NAME}
[Peer]
PublicKey = $(cat "/etc/wireguard/clients/${CLIENT_NAME}_public.key")
AllowedIPs = ${CLIENT_IP}
EOF

# Gerar QR Code
qrencode -t ansiutf8 < "/etc/wireguard/clients/${CLIENT_NAME}.conf"
qrencode -t png -o "/etc/wireguard/clients/${CLIENT_NAME}_qr.png" < "/etc/wireguard/clients/${CLIENT_NAME}.conf"

# Recarregar configuração
sudo wg-quick down wg0
sudo wg-quick up wg0

echo "[+] Cliente ${CLIENT_NAME} adicionado com sucesso!"
echo "[+] Configuração: /etc/wireguard/clients/${CLIENT_NAME}.conf"
echo "[+] QR Code: /etc/wireguard/clients/${CLIENT_NAME}_qr.png"