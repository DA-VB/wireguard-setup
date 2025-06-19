# Guia de Segurança WireGuard
Autor: DA-VB
Última atualização: 2025-06-19 14:36:26 UTC

## 1. Configurações de Segurança Iniciais

### 1.1 Alteração de Credenciais Padrão
```bash
# 1. Editar docker-compose.yml
nano /etc/wireguard/docker-compose.yml

# 2. Modificar as variáveis
WGUI_USERNAME=seu_novo_usuario
WGUI_PASSWORD=sua_nova_senha_segura

# 3. Reiniciar o container
docker-compose down
docker-compose up -d