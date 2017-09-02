#!/bin/bash
#mise à jour des dépots et installation des executables necessaire
apt-get update && apt-get install -y python-setproctitle python3-pynzb wget cfv git p7zip-full bc openssl pwgen perl automake php-cli

curl -sL https://deb.nodesource.com/setup_6.x | -E bash -
apt-get install -y nodejs

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

#installation de par2cmdline
cd /tmp
git clone https://github.com/Parchive/par2cmdline
cd par2cmdline
./automake.sh
./configure
make
make check
make install

#instalation de POST
echo -e "Entrer le nom de l'user qui utilisera le script"
read user
cd /home/"${user}"
git clone https://github.com/Diabolino/POST
cp -vaR POST/. . && rmdir POST/

#Finalisation de l'installation
cpan Term::ReadKey;
cpan Term::ANSIColor
chmod 755 /home/"${user}"/bin/usenet
chown -R ${user}:${user} /home/"${user}"/bin/


