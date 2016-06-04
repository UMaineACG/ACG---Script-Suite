#!/bin/bash

#Make sure we're running as root.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root!"
    exit 1
fi

echo "Updating software sources..."
apt-get -qq update > /dev/null & # -qq silences all messages except for errors. Pretty cool.
wait
echo "Software sources updated!"

echo "Installing base dependencies..."
apt-get -qq install -y python3 python3-pip npm nodejs-legacy openssl > /dev/null &
wait
echo "Base dependencies installed!"

echo "Installing node dependencies..."
npm --silent install -g configurable-http-proxy > /dev/null &
wait
echo "Node dependencies installed!"

echo "Installing JupyterHub and JupyterHub Notebook..."
pip3 -q install jupyterhub > /dev/null &
wait
pip3 -q install --upgrade notebook > /dev/null &
wait
echo "JupyterHub and JupyterHub Notebook installed!"
printf "\n\n\n"
echo "Configuring JupyterHub..."
jupyterhub --generate-config
mkdir -p /var/jupyterhub-data && cd /var/jupyterhub-data

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout server.key -out server.crt
echo "To start the JupiyterHub server, run 'jupyterhub --ip 0.0.0.0 --port 443 --ssl-key /var/jupyterhub-data/server.key --ssl-cert /var/jupyterhub-data/server.crt' as root."
