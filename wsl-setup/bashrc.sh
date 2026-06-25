
# Start ssh-agent and load ssh keys
eval $(ssh-agent -s) >/dev/null
ssh-add /mnt/c/Users/mnn/.ssh/github 2>/dev/null
ssh-add /mnt/c/Users/mnn/.ssh/bitbucket 2>/dev/null

# Define environment variable with the IP for Windows network interface
export THCC_HOST=$(ip route | grep default | awk '{print $3}')