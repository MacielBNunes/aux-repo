#!/bin/bash
set -e

# ============================================
# Setup auxiliar para DevContainer em execução
# ============================================
# Funções:
#  1. Instala ssh-client no container
#  2. Copia as chaves SSH do WSL (~/.ssh)
#  3. Ativa autocompletar do git no .bashrc
#  4. Cria alias 'py' -> 'python3'
#
# Uso:
#   bash setup_devcontainer_env.sh <container_name>
#
# Dica:
#   Use `docker ps` para listar os containers e achar o nome/ID do DevContainer.
# ============================================

if [ -z "$1" ]; then
    echo "Uso: $0 <container_name>"
    echo "Exemplo: $0 grid-controller-devcontainer"
    exit 1
fi

CONTAINER="$1"

echo "🔍 Verificando container '$CONTAINER'..."
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER}$"; then
    echo "❌ Container '$CONTAINER' não encontrado ou não está em execução."
    echo "Use 'docker ps' para verificar o nome correto."
    exit 1
fi
echo "✅ Container encontrado."

# --- 1. Instalar ssh-client ---
echo "📦 Instalando ssh-client no container..."
docker exec -u root "$CONTAINER" bash -c "apt-get update -qq && apt-get install -y openssh-client bash-completion"

# --- 2. Copiar chaves SSH ---
SSH_DIR="$HOME/.ssh"
if [ ! -d "$SSH_DIR" ]; then
    echo "⚠️  Diretório $SSH_DIR não encontrado — pulando cópia de chaves SSH."
else
    echo "🔑 Copiando chaves SSH para o container..."
    docker exec -u root "$CONTAINER" mkdir -p /home/code/.ssh
    docker cp "$SSH_DIR/." "$CONTAINER:/home/code/.ssh/"
    docker exec -u root "$CONTAINER" chown -R code:code /home/code/.ssh
    docker exec -u root "$CONTAINER" chmod 700 /home/code/.ssh
    docker exec -u root "$CONTAINER" bash -c "chmod 600 /home/code/.ssh/* || true"
    echo "✅ Chaves SSH copiadas."
fi

# --- 3. Ativar git completion no .bashrc ---
echo "⚙️  Configurando autocompletar do git..."
docker exec -u code "$CONTAINER" bash -c "grep -qxF 'source /usr/share/bash-completion/completions/git' ~/.bashrc || echo 'source /usr/share/bash-completion/completions/git' >> ~/.bashrc"

# --- 4. Criar alias para python3 ---
echo "🐍 Adicionando alias 'py=python3'..."
docker exec -u code "$CONTAINER" bash -c "grep -qxF \"alias py='python3'\" ~/.bashrc || echo \"alias py='python3'\" >> ~/.bashrc"

echo "🎉 Ambiente configurado com sucesso!"
echo "💡 Dica: reabra o terminal do DevContainer para carregar o .bashrc."
