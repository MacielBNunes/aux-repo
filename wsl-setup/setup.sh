#!/usr/bin/env bash
set -e

##!!! Run `sudo cp wsl.conf /etc/` and reboot WSL before running this.

# === Simulate an active user section
export XDG_RUNTIME_DIR=/run/user/$(id -u)
sudo loginctl enable-linger $USER

# === Install ssh-agent (provided by openssh-client)
# Install
command -v ssh-agent >/dev/null || (sudo apt update && sudo apt install -y openssh-client)
# Configure startup on boot
install -Dm755 ssh-agent.socket ~/.config/systemd/user/ssh-agent.socket && \
install -Dm755 ssh-agent.service ~/.config/systemd/user/ssh-agent.service && \
systemctl --user daemon-reload
systemctl --user enable ssh-agent.socket
systemctl --user start ssh-agent.socket

# === Add all ssh keys on startup
install -Dm755 ssh-add-all.sh ~/.local/bin/ssh-add-all.sh
install -Dm644 ssh-add-all.service ~/.config/systemd/user/ssh-add-all.service
systemctl --user daemon-reexec
systemctl --user enable ssh-add-all.service
systemctl --user start ssh-add-all.service

echo ">>> Reboot WSL (wsl --shutdown) to make the changes take effect."
