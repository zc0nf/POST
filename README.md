# README USENET

## Ce que va faire ce script
* Ce script va vous permettre à partir d'un fichier ou d'un dossier de poster celui ci sur usenet 
* Il va créer les archives en ayant le choix entre rar et 7z
* il va créer les par2 en utilisant [ParPar](https://github.com/animetosho/ParPar "ParPar")
* Il va poster sur usenet en utilisant [Nyuu](https://github.com/animetosho/Nyuu "Nyuu")
* il va vous permettre de choisir si vous souhaitez utiliser un password ou non sur vos archives
* Il va vous permettre de choisir si vous souhaitez masque le nom ce que vous postez
* Il va vous permettre de mettre un nom de posteur aléatoire
* Il va vous permettre de compresser le nzb
* Ajout des infos dans un fichier log


----------


### De quoi avez vous besoin 

#### Méthode automatique

    wget https://raw.githubusercontent.com/Diabolino/POST/master/tools/install.sh
    chmod 755 install.sh
    ./install.sh

#### Méthode manuel

* `sudo apt-get install cfv nodejs node-gyp node-async git bc openssl pwgen`

##### Si vous souahitez utiliser 7zip 

* `sudo apt-get p7zip-full`

##### Si vous préférez utiliser rar

* `wget http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz`
* `tar xzvf rarlinux-x64-5.5.0.tar.gz`
* `cd rarlinux-x64-5.5.0`
* `sudo make`
* `sudo make install`

* `sudo npm install -g nyuu`
* `sudo git clone https://github.com/animetosho/ParPar`
* `cd ParPar`
* `sudo npm install -g`

##### A La Racine de votre user (/home/user/)
* `git clone https://github.com/Diabolino/POST`
* `cp -vaR POST/. . && rmdir POST/`


----------


### Utilisation
	

> * -s	Chosir le fichier|dossier source (obligatoire)
> * -p	si vous désirer protéger vos archive avec un password aléatoire
> * -n	Si vous désirez utiliser un nom aléatoire pour vos archive
> * -f	Si vous désirez utiliser un nom de posteur aléatoire
> * -z	Si vous préférez utiliser 7Z plutot que rar (7z étant bien plus performant)
> * -c	A utiliser si vous souhaiter compresser le NZB obtenu
> * -F	Upload full random
> * -v	Pour activer le mode DEBUG


----------


#### Exemple

* `usenet -p -n -z -f -s debian-9.1.0-amd64-netinst.iso`
* `usenet -s debian-9.1.0-amd64-netinst.iso -f`

[![asciicast](https://asciinema.org/a/HCihE7t77QTJOorNzDXLOXpQA.png)](https://asciinema.org/a/HCihE7t77QTJOorNzDXLOXpQA)


----------


----------


# README NZBVERIF#

## Ce que va faire ce script
* Ce script vous permet de vérifier la complétude d'un fichier NZB

## De quoi avez vous besoin ###

* `sudo apt-get install python-setproctitle python-pynzb`

## Utilisation

> -f	Chosir le fichier nzb à vérifier (obligatoire)

#### Exemple

* `nzbverif -f nzb/debian-9.1.0-amd64-netinst.nzb`

[![asciicast](https://asciinema.org/a/sR8lym4mmITzlosatkztPtUZG.png)](https://asciinema.org/a/sR8lym4mmITzlosatkztPtUZG)



