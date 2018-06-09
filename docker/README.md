##### A l'intérieur du répertoire créer 4 répertoires :		
		
 * conf (qui stockera le fichier de configuration pour se connecter sur le serveur de NNTP)		
 * nzb (les fichiers NZB de vos upload se trouveront dedans)		
 * image (il y aura à l'intérieur le fichier qui permettra de créer le container)		
 * data (facultatif - c'est le répertoire dans lequel vous allez mettre le fichier ou répertoire à uploader)		
 * En alternative vous pouvez utiliser un repertoire de votre poste de travail		
 * Ex :  ./data:tmp/data =\> C:/Users/SomeOne/Data:/tmp/data
 
##### Créer un fichier docker-compose.yml (il faudra le personnaliser avec certains infos au niveau des partages)		
 		
     version: '2.0'		
     services:		
       ngpost:		
         container_name: ngpost		
         build:		
          context: ./image		
         volumes:		
          - ./conf/ng.server.sh:/tmp/POST/conf/conf.sh		
          - ./nzb:/tmp/nzb		
          - ./data:/tmp/data
          
##### Dans le répertoire conf, vous créerez un fichier ng.server.sh avec les infos de votre serveur NNTP
```bash
#!/bin/bash

NGHOST="reader.com"
NGUSER="USERNAME"
NGPASS="PASSWORD"
NGGROUP="alt.binaries.******"
NGNBRCONNECT="10"
NGFROM="test@test.com" #laisser vide entrainera le random de celui-ci
PARPERCENT="20" #Ne pas mettre le %
NZBOUTPUT="/home/***/****"
NZBTEMP="/nzbtemp/"
PAR2BIN="parpar" #parpar ou bien par2
PAR2MEMORY="16000" #valuer en MB
RANDOMGROUP=("alt.binaries.gougouland" "alt.binaries.usenet2day" "alt.binaries.usc" "alt.binaries.amazing" "alt.binaries.welovelori" "alt.binaries.insiderz" "alt.binaries.xylo" "alt.binaries.paxer" "alt.binaries.kleverig" "alt.binaries.ijsklontje") #a ne remplir que si vous utilisez la fonction fullrandom
PARPERCENT="10"
MAXSEGNBR="8192" # Nombre de segments, maxi 32768
MAXRARNUMBER="99" # Nombre de rar maxi 10, 50, 99 selon les preferences
NYUUUSER="user"
```

##### Dans le répertoire image, mettre le fichier DockerFile (il y aura à l'interieur toute les informations pour générer le container)

##### Pour créer le container, depuis votre console tapez :

    * docker-compose up

Vous allez voir le processus de création du container

##### Pour tester un upload :

    * docker-compose run --rm -w"/tmp/data/" ngpost -s test.zip -p -n -f -z

Dans cette exemple : test.zip est le fichier à uploader, et il se trouve à la racine de data.

Il suffit de le remplacer par le nom du fichier à uploader (ou du répertoire) ex:  -s monrepertoire/monsecondrepertoire -p -n -f -z