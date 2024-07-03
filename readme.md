# How to get started
On the server execute these commands

```bash
# Create ssh key (The script will be executed as root )
sudo ssh-keygen
sudo cat root/.ssh/xxx.pub

# Copy paste public sshkey into github account. Login and go to:  Profile / Settings / SSH & GPG keys / New SSH key

# Get the home-server code
sudo git clone git@github.com:philter87/home-server.git

# Execute task every minute
sudo crontab -e
# Add the follwing line: 
# * * * * * /home/philter87/home-server/deploy.sh

# OR to include some logs
# * * * * * /home/philter87/home-server/deploy.sh > /var/log/home-server.log 2>&1

# Check logs in 
sudo tail /var/log/syslog
sudo tail /var/log/home-server.log

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

