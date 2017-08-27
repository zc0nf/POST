#!/bin/bash
#mise à jour des dépots et installation des executables necessaire
apt-get update && apt-get install -y python-setproctitle python3-pynzb wget cfv nodejs node-gyp node-async git p7zip-full bc openssl pwgen perl

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

#instalation de POST
cd "${HOME}"
git clone https://github.com/Diabolino/POST
cp -vaR POST/. . && rmdir POST/

#Finalisation de l'installation
cpan Term::ReadKey;
cpan Term::ANSIColor
read user
chmod 755 /home/"${user}"/bin/usenet
chown -R ${user}:${user} /home/"${user}"/bin/


