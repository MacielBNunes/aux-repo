# Como usar

1. No WSL:
   - `sudo cp wsl.conf /etc/wsl.conf`
   - `wsl --shutdown`
2. Reabra o WSL
3. Execute:
   - `./setup.sh`
4. Crie as chaves ssh (Opcional)
    - `ssh-keygen -t ed25519 -f ~/.ssh/github -C "github"`
5. Reinicie o WSL novamente:
    - `wsl --shutdown`
6. Verificações
    - O aggente ssh está em execução: `systemctl status ssh-agent`
    - Se houver chaves ssh:
        - As chaves ssh foram adicionadas: `ssh-add -l`
        - O remoto (github.com) está acessível: `ssh -T git@github.com`
