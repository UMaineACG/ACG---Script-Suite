#!/bin/bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
ansible-playbook playbooks/xrdp.yml --ask-sudo-pass
