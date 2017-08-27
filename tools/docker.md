A l'intérieur du répertoire créer 4 répertoires : 

* conf (qui stockera le fichier de configuration pour se connecter sur le serveur de NNTP)
* nzb (les fichiers NZB de vos upload se trouveront dedans)
* image (il y aura à l'intérieur le fichier qui permettra de créer le container)
* data (facultatif - c'est le répertoire dans lequel vous allez mettre le fichier ou répertoire à uploader) 
  * En alternative vous pouvez utiliser un repertoire de votre poste de travail
  * Ex :  ./data:tmp/data =\> C:/Users/SomeOne/Data:/tmp/data

Créer un fichier docker-compose.yml (il faudra le personnaliser avec certains infos au niveau des partages)
    
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

Dans le répertoire conf, vous créerez un fichier ng.server.sh avec les infos de votre serveur NNTP
    
    #!/bin/bash
    
    NGHOST="post.usenet.nl"
    NGUSER="username"
    NGPASS="password"
    NGGROUP="alt.binaries.gougouland"
    NGNBRCONNECT="10"
    NGFROM="votre@email.com"
    PARPERCENT="20"
    NZBOUTPUT="/tmp/nzb"

Dans le répertoire image, créer un fichier DockerFile (il y aura à l'interieur toute les informations pour générer le container)
    
    FROM ubuntu:latest
    
    # install packages
    RUN apt-get update && apt-get install -y \
      python-setproctitle \
      python-pynzb \
      wget \
      cfv \
      nodejs \
      node-gyp \
      node-async \
      git \
      npm \
      p7zip-full \
      bc \
      perl \
      pwgen
    
    # Nettoyage de l'image
    RUN \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
    WORKDIR /tmp
    
    # Install Nyuu
    RUN npm install -g nyuu
    
    # Install perl module
    RUN Term::ANSIColor
    RUN cpan Term::ReadKey;
    
    # Install ParPar
    RUN cd /tmp && git clone https://github.com/animetosho/ParPar
    RUN cd /tmp/ParPar && npm install -g
    
    # Install RAR
    Run wget "http://www.rarlab.com/rar/rarlinux-x64-5.5.0.tar.gz"
    Run tar xzvf rarlinux-x64-5.5.0.tar.gz
    Run cd rar && make && make install
    
    RUN cd /tmp && git clone https://github.com/Diabolino/POST.git
    
    RUN ln -s /usr/bin/nodejs /usr/bin/node
    
    RUN chmod 755 /tmp/POST/bin/usenet
    
    ENTRYPOINT ["/tmp/POST/bin/usenet"]
    CMD ["-h"]
    
    # Define mountable directories.
    VOLUME ["/tmp/EXTRA"]

Pour créer le container, depuis votre console tapez : 
    
    docker-compose up 

Vous allez voir le processus de création du container

Pour tester un upload : 
    
    docker-compose run --rm -w"/tmp/data/" ngpost -s test.zip -p -n -f -z

Dans cette exemple : test.zip est le fichier à uploader, et il se trouve à la racine de data.

Il suffit de le remplacer par le nom du fichier à uploader (ou du répertoire) ex:  -s monrepertoire/monsecondrepertoire -p -n -f -z
    
    