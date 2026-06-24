# 1. Instala o NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 2. Carrega o NVM na sessão atual (ou reinicie o terminal)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 3. Instala a versão LTS mais recente do Node.js
nvm install --lts

# 4. Instala a CLI global oficial do DevContainer
npm install -g @devcontainers/cli
