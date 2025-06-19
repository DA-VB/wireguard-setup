# Documentação do Servidor WireGuard
## 1 Instalação Automatizada
```bash
# Download do script
wget https://raw.githubusercontent.com/DA-VB/wireguard-setup/main/scripts/install-wireguard-complete.sh

# Executar instalação
chmod +x install-wireguard-complete.sh
sudo ./install-wireguard-complete.sh
# Status do serviço
sudo systemctl status wg-quick@wg0