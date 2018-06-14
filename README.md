# README USENET

## Ce que va faire ce script
* Ce script va vous permettre à partir d'un fichier ou d'un dossier de poster celui ci sur usenet 
* Il va créer les archives en ayant le choix entre rar et 7z
* il va créer les par2 en utilisant [ParPar](https://github.com/animetosho/ParPar "ParPar") ou au choix [par2cmldine](https://github.com/Parchive/par2cmdline "par2cmdline")
* Il va poster sur usenet en utilisant [Nyuu](https://github.com/animetosho/Nyuu "Nyuu")
* il va vous permettre de choisir si vous souhaitez utiliser un password ou non sur vos archives
* Il va vous permettre de choisir si vous souhaitez masque le nom ce que vous postez
* Il va vous permettre de mettre un nom de posteur aléatoire
* Il va vous permettre de poster un group aléatoire parmi une liste prédéfinis (la liste des groupes ou choisir doit être configurer dans le fichier de conf)
* Il va vous permettre de compresser le nzb
* Ajout des infos dans un fichier log


----------


### De quoi avez vous besoin     

#### Installation

* `sudo apt-get update`
* `sudo apt-get upgrade`
* `sudo apt-get install cfv git bc openssl pwgen perl curl build-essential`
* `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash`
* `nvm install 8.11.2`
* `npm config set user 0`
* `npm config set unsafe-perm true`
* `npm install -g nyuu`
* `npm install -g @animetosho/parpar`

##### Si vous souahitez utiliser 7zip 

* `sudo apt-get p7zip-full`

##### Si vous préférez utiliser rar

* `wget http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz`
* `tar xzvf rarlinux-x64-5.5.0.tar.gz`
* `cd rarlinux-x64-5.5.0`
* `sudo make`
* `sudo make install`

##### Si vous choisisez d'utiliser par2cmline

* `git clone https://github.com/Parchive/par2cmdline`
* `cd par2cmdline`
* `./automake.sh`
* `./configure`
* `make`
* `make check`
* `make install`

##### A La Racine de votre user (/home/user/)
* `git clone https://github.com/Diabolino/POST`
* `cp -vaR POST/. . && rmdir POST/`

##### Pour nzbverify
* `sudo apt-get install python2.7`

----------


### Utilisation 
	

> * -s	Chosir le fichier|dossier source (obligatoire)
> * -p	si vous désirer protéger vos archive avec un password aléatoire
> * -n	Si vous désirez utiliser un nom aléatoire pour vos archive
> * -f	Si vous désirez utiliser un nom de posteur aléatoire
> * -z	Si vous préférez utiliser 7Z plutot que rar (7z étant bien plus performant)
> * -c	A utiliser si vous souhaiter compresser le NZB obtenu
> * -v	Pour activer le mode DEBUG

#### Pour nzbverify
> * Modifier le fichier .nzbverify

----------


#### Exemple

* `usenet -p -n -z -f -s debian-9.1.0-amd64-netinst.iso`
* `usenet -s debian-9.1.0-amd64-netinst.iso -f`

[![asciicast](https://asciinema.org/a/HCihE7t77QTJOorNzDXLOXpQA.png)](https://asciinema.org/a/HCihE7t77QTJOorNzDXLOXpQA)

* `nzbverif -n10 debian-9.1.0-amd64-netinst.nzb (-n etant égale au nombre de connection à utiliser)`

[![asciicast](https://asciinema.org/a/GAlKEtq2uGn3hP7i2szJ7nP2k.png)](https://asciinema.org/a/GAlKEtq2uGn3hP7i2szJ7nP2k)



----------





