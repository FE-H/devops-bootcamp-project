#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
echo curl https://google.com
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y python3-pip python3-venv
#systemctl enable --now snapd
#snap install amazon-ssm-agent --clasic
#systemctl enable snap.amazon-ssm-agent.daemon.service
#systemctl start snap.amazon-ssm-agent.daemon.service
mkdir -p /opt/ansible-venv
ANSIBLE_VENV="/opt/ansible-venv"
python3 -m venv $ANSIBLE_VIEW
$ANSIBLE_VENV/bin/pip install --no-cache-dir --upgrade pip
$ANSIBLE_VENV/bin/pip install --no-cache-dir ansible
ln -s $ANSIBLE_VENV/bin/ansible /usr/local/bin/ansible
ln -s $ANSIBLE_VENV/bin/ansible-playbook /usr/local/bin/ansible-playbook