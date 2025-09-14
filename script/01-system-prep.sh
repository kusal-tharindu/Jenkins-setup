#! /bin/bash

# Goal: make the EC2/on-prem Linux host safe, consistent, and ready to run our Jenkins stack.

#-----------------------------------------------

### 2.1 System prep (packages, timezone, time sync)
# Update & essential tooling
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl jq git unzip tzdata

# Set timezone (matches your plan)
sudo timedatectl set-timezone Asia/Colombo
timedatectl

# Ensure time sync is on (important for TLS/webhooks)
timedatectl show | grep NTPSynchronized
sudo systemctl enable --now systemd-timesyncd

#-----------------------------------------------
### 2.2 Minimal firewall (safe defaults)

sudo apt-get install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status verbose

