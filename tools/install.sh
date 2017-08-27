#!/bin/bash
#mise à jour des dépots et installation des executables necessaire
su apt-get update && apt-get install -y python-setproctitle python-pynzb wget cfv nodejs node-gyp node-async git npm p7zip-full bc openssl pwgen

#instalation de nyuu
su npm install -g nyuu

#instalation de parpar
su cd /tmp && git clone https://github.com/animetosho/ParPar
su cd ParPar && npm install -g

#installation de rar
su cd /tmp
su wget "http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz"
su tar xzvf rarlinux-x64-5.5.0.tar.gz
su cd rar && make && make install

#instalation de POST
cd "${HOME}"
git clone https://github.com/Diabolino/POST
cp -vaR POST/. . && rmdir POST/

#Finalisation de l'installation
chmod 755 /home/"${user}"/bin/usenet
chown ${user}:${user} /home/"${user}"/bin/usenet


