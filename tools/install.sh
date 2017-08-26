#!/bin/bash
echo -n "Entrer le nom de votre utilisateur et appuyer sur [ENTER]: "
read user
#mise à jour des dépots et installation des executables necessaire
apt-get update && apt-get install -y python-setproctitle python-pynzb wget cfv nodejs node-gyp node-async git npm p7zip-full bc openssl

#instalation de nyuu
npm install -g nyuu

#instalation de parpar
cd /tmp && git clone https://github.com/animetosho/ParPar
cd ParPar && npm install -g

#installation de rar
cd /tmp
wget "http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz"
tar xzvf rarlinux-x64-5.5.0.tar.gz
cd rar && make && make install
#Finalisation de l'installation
chmod 755 /home/"${user}"/bin/usenet
chown ${user}:${user} /home/"${user}"/bin/usenet


