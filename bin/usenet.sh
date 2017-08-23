#!/bin/bash
#############################################################################################
#		
# Version Du Script : v1.0
# Nom du Script : usenet.sh								
# Dernière Modification le 23 Aout 2017
#
#					
# -------------------------------------- HISTORIQUE ---------------------------------------

# 23/08/17 (1.0) : Écriture du script
#
#
#-------------------------------------- INSTRUCTIONS --------------------------------------
#
# sudo apt-get install p7zip-full cfv mysql nodejs node-gyp node-async git
# sudo npm install -g nyuu
# sudo git clone https://github.com/animetosho/ParPar
# sudo npm install -g
#
##############################################################################################

source common.sh
source conf.sh
BASEPATH=$(pwd)

usage()
{

cat << EOF
usage: $0 options/

OPTIONS:
-h  Voir ce message d\'aide
-s  Chosir le fichier|dossier source (obligatoire)
-p  si vous désirer protéger vos archive avec un password aléatoire
-n  Si vous désirez utiliser un nom aléatoire pour vos archive
-f  Si vous désirez utiliser un sender aléatoire
-z	Si vous préferez utiliser 7Z plutot que rar (bien plus performant)
-v  Pour activer le mode DEBUG

EOF
}

while getopts "vpnfzs:" opt
do
	case $opt in
	"h")
		usage
		exit 1
	;;

	"s")
		SOURCE="$OPTARG"	
	;;
	
	"p")
		RANDOMPASS="YES"	
	;;
	
	"n")
		RANDOMNAME="YES"	
	;;
	
	"f")
		RANDOMFROM="YES"	
	;;
	
	"z")
		SEVENZ="YES"	
	;;
	
	"v")
         set -x
    ;;
    
	"?")
		echo "Invalid option: -$OPTARG"
		usage
		exit 1
	;;
esac
done

shift $(($OPTIND-1))

#-------------- Tests des dépendances ------------------ 
LISTE_APPLIS="nyuu parpar cfv 7z rar" 
sortie="notok" 
	for i in $LISTE_APPLIS; do 
	which $i > /dev/null 2>&1 
		if [ "$?" = "1" ]; 
		then [ "$sortie" = "notok" ] && echo -e "${NORMAL}""Programme(s) manquant(s) : " 
		echo -e "${VERTB} ${i}${NORMAL}" 
		sortie="ok" 
		fi; 
	done 
	if [ "$sortie" = "ok" ]; 
	then 
	echo -e "${VERTB}""Dependances ok""${NORMAL}" 
	exit -1 
	fi 
#-------------- fin Tests des dépendances ------------------  

if [ -z ${SOURCE} ] ; then
	echo -e "$BLEUB"
    usage
	echo -e "$NORMAL"
    exit 0
fi

#Création d'un repertoire temporaire et du répertoire ou seront stocker les nzb
if [ ! -d temp ]; then mkdir temp; fi
if [ ! -d nzb ]; then mkdir nzb; fi

#Génération du nom aléatoire
function randname() {
CODE=$(echo ${DOSSIER} | sha256sum | base64 | tail -c 17 | head -c 15)
CODE2=$(date +%s | sha256sum | base64 | head -c 15)
CODE3=$(echo ${CODE}${CODE2})
echo ${CODE3^^}
}

#Génération d'un password pour les rar
function randpass() {
FIRST=$(echo ${DOSSIER} | base64 | sha256sum | tr -cd [:digit:] | head -c 12)
pass=$(echo Z$FIRST)
echo "$pass"
}

#Génération d'un user aléatoire pour l'upload
function randsend() {
part1=$(openssl rand -base64 32	| tr -cd [:alpha:] | head -c 8 | tr [:upper:] [:lower:])
part2=$(openssl rand -base64 32	| tr -cd [:alpha:] | head -c 8 | tr [:upper:] [:lower:])
sender=$(echo ${part1}@${part2}.com) 
#echo "${sender}"	
}

#Verification si la source est un fichier ou un répertoire
function verifrep() {	
RELEASE=$(basename ${SOURCE})
if [ -d "${RELEASE}" ]; then
    DOSSIER="${RELEASE}"
else
	DOSSIER="${RELEASE%.*}"
	mkdir ${DOSSIER} 
	mv ${RELEASE} ${DOSSIER}
fi
echo -e "$VERT""CREATION DES RÉPERTOIRES""$NORMAL"

if [[ ${RANDOMNAME} = "YES" ]]; then
	RANDNAME=$(randname)
	mkdir temp/${RANDNAME}
	NZBNAME=${RANDNAME}
else
	mkdir temp/${DOSSIER}
	NZBNAME=${DOSSIER}
fi
}

#Calcul de la taille des rar
function rarsize() {
	echo -e "$BLEUB""CALCUL DE LA TAILLE DES RAR""$NORMAL"
	SIZE=$(du -b ${DOSSIER} | awk '{ print $1 }')
	HUMANSIZE=$(du -h ${DOSSIER} | awk '{ print $1 }')
	if [[ $SIZE -lt 1157286400000 ]] && [[ $SIZE -gt 15728640000 ]]
	then 
		RARSIZE="-v1500000000b"
	elif [[ $SIZE -lt 15728640000 ]] && [[ $SIZE -gt 1572864000 ]]
	then 
		RARSIZE="-v150000000b"
	elif [[ $SIZE -lt 1572864000 ]]; 
	then 
		RARSIZE="-v15000000b"			
fi
	BLOCKSIZE=$(echo "scale=2; (($SIZE/1024)/1024)/100" | bc | awk '{printf("%d\n",$1 + 0.5)}')
}

#creation des archive et sfv
function raring() {
	echo -e "$JAUNE""CRÉATION DES ARCHIVE""$NORMAL" 	
	 
	if [[ ${SEVENZ} = "YES" ]]; then
		if [[ ${RANDOMPASS} == "YES" ]]; then
			RARPASS=$(randpass)
			7z a -t7z -m0=copy -ms=8m -mmt=8 -mx=1 -mhe=on ${RARSIZE} -p${RARPASS} -- temp/${NZBNAME}/${NZBNAME} ${DOSSIER}
		else
			7z a -t7z -m0=copy -ms=8m -mmt=8 -mx=1 -mhe=on ${RARSIZE} -- temp/${NZBNAME}/${NZBNAME} ${DOSSIER}
		fi
	else
		if [[ ${RANDOMPASS} = "YES" ]]; then
			RARPASS=$(randpass)
			rar a ${RARSIZE} -hp${RARPASS} -m0 -ma4 -vn temp/${NZBNAME}/${NZBNAME}.rar ${DOSSIER} 
		else
			rar a ${RARSIZE} -m0 -ma4 -vn temp/${NZBNAME}/${NZBNAME}.rar ${DOSSIER}
		fi
	fi
	
	cd temp/${NZBNAME}
	echo -e "$ROSE""CRÉATION DU SFV""$NORMAL"
	cfv -C -f ${NZBNAME}.sfv
	cd ${BASEPATH}/
}

#creation des PAR2
function createpar() { 
	echo -e "$VERTB""CRÉATION DES PAR2""$NORMAL"
	parpar -s ${BLOCKSIZE}M -r${PARPERCENT}% -d pow2 -m 16000M -o temp/${NZBNAME}/${NZBNAME}.par2 -R temp/${NZBNAME}/
}

#Upload sur les newsgroups
function uploadtong() {
	echo -e "$CYAN""UPLOAD SUR LES NEWSGROUPS""$NORMAL"
	if [[ ${RANDOMFROM} = YES ]]; then
	randsend
	NGFROM=${sender}
	fi
	nyuu -h ${NGHOST} -n ${NGNBRCONNECT} -u ${NGUSER} -p ${NGPASS} -f ${NGFROM} -g ${NGGROUP} -S -o nzb/${NZBNAME}.nzb -r include temp/${NZBNAME}/ 
	if [[ ${RANDOMPASS} == YES ]]; then
	sed -i "4i\<head><meta type=\"password\">${RARPASS}</meta></head>\n" nzb/${NZBNAME}.nzb
	fi
}

#nettoyage
function cleanup() {
	echo -e "$ROSEB""NETTOYAGE""$NORMAL"
	rm -rf temp/${NZBNAME}/
	cd ${BASEPATH}/
}

verifrep
rarsize
raring
createpar
uploadtong
cleanup


echo -e $ROUGE"VOTRE UPLOAD DE" $BLEU${SOURCE}$ROUGE" EST TERMINÉ"

if [[ ${RANDOMNAME} = "YES" ]]; then
	echo -e "IL A ÉTÉ UPLOADÉ SOUS LE NOM" $BLEU${RANDNAME}$ROUGE
fi

if [[ ${RANDOMPASS} = "YES" ]]; then
	echo -e "AVEC COMME PASSWORD" $BLEU${RARPASS}$NORMAL
fi
	


