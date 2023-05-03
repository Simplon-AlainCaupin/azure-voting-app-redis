# # Procédure déploiement via pipeline AzureDevops

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


## 3 - Brief 9 - Rendu

Mise en place d'outillage devSecOps :

### **OWASP Dependency-Check**  


OWASP Dependency Check est un outil de SCA (Software Composition Analysis) permettant de détecter des vulnérabilités connues dans les dépendances d'un projet.  
Dans le cas de ce brief, le scan se fait sur le repository gitHub. 
Si des problèmes de dépendances sont trouvés, un rapport est généré avec la liste des vulnérabilités identifiées. Il faut alors les analyser et éventuellement mettre à jour les éléments potentiellement obsolètes ou représentant un risque de sécurité.  
Dans le pipeline Azure, le dependency check est implémenté sous forme de "stage".
 
```
- stage: dependency_check
  displayName: Run dependency check
  jobs:
  ```

  Un add-on a été installé au préalable afin de faire appel à OWASP Depencendy Check, le rapport est généré directement après exécution du pipeline, dans la catégorie "tests". Le scan est fait à la racine du repository GitHub associé au pipeline, et le rapport est généré et téléchargeable une fois l'éxécution terminée, au format défini dans le code du pipeline (dans mon cas : JUnit)

  ### **OWASP Zap**

  OWASP ZAP (Zed Attack Proxy) est un outil de test d'application open source simulant une / des attaques de type "man in the middle proxy" sur une application donnée.  
  La version utilisée dans le pipeline du Brief9 est une version containerisée, appelée dans une "task"  
  ```
        - task: CmdLine@2
        inputs:
          script: |
            chmod -R 777 ./
            docker run --rm -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-baseline.py -t http://lain-brief8.westeurope.cloudapp.azure.com/:80 -x report.xml
            true
        displayName: "Owasp Container Scan"
```
Le type de test est défini dans le "docker run", (script python zap-baseline.py pour exemple)  
L'application cible est définie par son URL,  
un rapport est par la suite généré via le pipeline et accessible dans l'onglet "tests" de Azure DevOps suite à l'exécution du pipeline.  
