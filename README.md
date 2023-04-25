# Procédure déploiement via pipeline AzureDevops

## 1 - Fonctionnement général Pipeline prévu

![](https://i.imgur.com/aa3JgJM.png)


## 2 - Listing actions pipeline AzureDevops

Failed :

La pipeline s'arrête après check de la réussite ou de l'echec des jobs précédent le release. Voir logs dans chaque job pour plus de détails.
Dans le cas suivant, le job "build and push" s'exécutait trop tard dans le pipeline.

![](https://i.imgur.com/44bDLcp.png)

Après correction,

Succeeded :

![](https://i.imgur.com/UNGmU3V.png)

Les jobs se déroulent dans un ordre établi jusqu'au déploiement en production.


## 3 - Finalisation

La partie test n'est pas encore prise en compte dans le pipeline,
Pour le moment seule la modification du code source de l'application permet le déclenchement.

A faire : test de montée en charge et déclenchement manuel de la Canary Release si test réussi.


az aks create -n akslain -g brief8lain --network-plugin azure --node-count 2 -a ingress-appgw --appgw-name appGWlain --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys