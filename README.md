# README #

### Ce que va faire ce script
* Ce script va vous permettre à partir d'un fichier ou d'un dossier de poster celui ci sur usenet 
* Il va créer les archives en ayant le choix entre rar et 7z
* il va créer les par2 en utilisant [ParPar](https://github.com/animetosho/ParPar "ParPar")
* Il va poster sur usenet en utilisant [Nyuu](https://github.com/animetosho/Nyuu "Nyuu")
* il va vous permettre de choisir si vous souhaitez utiliser un password ou non sur vos archives
* Il va vous permettre de choisir si vous souhaitez masque le nom ce que vous postez
* Il va vous permettre de mettre un non de posteur aléatoire

### De quoi avez vous besoin ###

* sudo apt-get install cfv mysql nodejs node-gyp node-async git

> Si vous souahitez utiliser 7zip 

* sudo apt-get p7zip-full

> Si vous préférez utiliser rar

* wget http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz
* tar xzvf rarlinux-x64-5.5.0.tar.gz
* cd rarlinux-x64-5.5.0
* make
* make install

* sudo npm install -g nyuu
* sudo git clone https://github.com/animetosho/ParPar
* cd ParPar
* sudo npm install -g

### Utilisation
>
* -s  Chosir le fichier|dossier source (obligatoire)
* -p  si vous désirer protéger vos archive avec un password aléatoire
* -n  Si vous désirez utiliser un nom aléatoire pour vos archive
* -f  Si vous désirez utiliser un nom de posteur aléatoire
* -z	Si vous préférez utiliser 7Z plutot que rar (7z étant bien plus performant)
* -v  Pour activer le mode DEBUG

#### Exemple

* usenet -p -n -z -f -s debian-9.1.0-amd64-netinst.iso
