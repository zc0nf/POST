#!/bin/bash
#mise à jour des dépots et installation des executables necessaire
sudo apt-get update && apt-get install -y python-setproctitle python-pynzb wget cfv nodejs node-gyp node-async git npm p7zip-full bc openssl pwgen

#instalation de nyuu
sudo npm install -g nyuu

#instalation de parpar
sudo cd /tmp && git clone https://github.com/animetosho/ParPar
sudo cd ParPar && npm install -g

#installation de rar
sudo cd /tmp
sudo wget "http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz"
sudo tar xzvf rarlinux-x64-5.5.0.tar.gz
sudo cd rar && make && make install

#instalation de POST
cd "${HOME}"
git clone https://github.com/Diabolino/POST
cp -vaR POST/. . && rmdir POST/

#Finalisation de l'installation
chmod 755 /home/"${user}"/bin/usenet
chown ${user}:${user} /home/"${user}"/bin/usenet


