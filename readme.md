# How to get started
On the server execute these commands

```bash
# Create ssh key
ssh-keygen
cat ~/.ssh/xxx.pub

# Copy paste public sshkey into github account. Login and go to:  Profile / Settings / SSH & GPG keys / New SSH key

# Get the home-server code
git clone git@github.com:philter87/home-server.git

# Execute task every minute
sudo crontab -e
# Add the follwing line: * * * * * /home/philter87/home-server/deploy-branch.sh

# Check logs in 
tail /var/log/syslog

```

# Initialize server
My notes on running a server at home

```bash
# Install docker
sudo snap install docker

# Install snap to broadcast hostname on local network
sudo snap install avahi

# Upgrade dependencies and reboot
sudo apt-get update
sudo apt-get upgrade
sudo reboot
```
