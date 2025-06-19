#!/bin/bash
# Update script for WireGuard Server
# Author: DA-VB
# Last Update: 2025-06-19 14:34:07 UTC

echo "[*] Iniciando atualização do WireGuard e componentes..."

# Backup das configurações
backup_dir="/etc/wireguard/backup_$(date +%Y%m%d_%H%M%S)"
sudo mkdir -p "$backup_dir"
sudo cp -r /etc/wireguard/* "$backup_dir/"
echo "[+] Backup criado em: $backup_dir"

# Atualizar sistema
echo "[*] Atualizando pacotes do sistema..."
sudo apt update
sudo apt upgrade -y

# Atualizar WireGuard
echo "[*] Atualizando WireGuard..."
sudo apt install --only-upgrade wireguard wireguard-tools

# Atualizar Docker containers
echo "[*] Atualizando containers Docker..."
cd /etc/wireguard
sudo docker-compose pull
sudo docker-compose up -d

# Verificar serviço
echo "[*] Verificando status dos serviços..."
sudo systemctl restart wg-quick@wg0
sudo systemctl status wg-quick@wg0

echo "[+] Atualização completa!"
echo "[*] Verifique a interface web: http://localhost:5000"