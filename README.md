# Documentation générale

## 1. Introduction : mise en contexte

**Ekoloclast** est une start-up innovante fondée il y a moins de deux ans, dont les locaux sont à Paris (dans le 8 ème arrondissement). Elle a pour ambition de révolutionner l'approche de l'écologie. Son fondateur aspire à introduire des pratiques, produits et services écologiques novateurs qui bénéficient à la fois à l'environnement et aux individus. Elle est orientée vers les marchés professionnels (B2B) et consommateurs (B2C). Recemment, l'entreprise a réussi une levée de fonds significative, positionnant Ekoloclast pour une expansion prometteuse.
La société comprend actuellement 183 personnes réparties dans 10 services (appelés "départements").
Des personnels extérieurs travaillent ponctuellement ou à temps plein avec certains services.

Nous faisons parti de la société Ekoloclast et notre formateur joue le rôle du DSI de cette société.

---

## 2. Présentation du projet, objectifs finaux

Notre objectif final de fin de projet est de mettre en place une nouvelle infrastructure réseau.
  
---
 
## 3. Présentation de l'équipe

| Semaine       | Igor             | Souhail         | Adeline          | François        | Camille        |
|---------------|------------------|-----------------|------------------|-----------------|----------------|
| **Semaine 1** | Product Owner    | Scrum Master    | Technicienne     | Technicien      | Technicienne   |
| **Semaine 2** | Technicien       | Technicien      | Technicienne     | Scrum Master    | Product Owner  |
| **Semaine 3** | Technicien       | Product Owner   | Scrum Master     | Technicien      | Technicienne   |
| **Semaine 4** | Technicien       | Technicien      | Technicienne     | Product Owner   | Scrum Master   |  
| **Semaine 5** | Scrum Master     | Technicien      | Product Owner    | Technicien      | Technicienne   |  
| **Semaine 6** | Technicien       | Product Owner   | Technicienne     | Scrum Master    | Technicienne   |  
| **Semaine 7** | Product Owner    | Technicien      | Technicienne     | Technicien      | Scrum Master   |  
| **Semaine 8** | **************   | *************** | ***************  | *************** |*************** |  

[Planification globale sur les différents sprints](https://miro.com/app/board/uXjVLDxuzTU=/)
---
²**Objectifs Sprint 8**
- Objectifs primaires :
- Objectifs secondaires : 
- Objectifs optionnels :
---
**Objectifs Sprint 7**
- Objectifs primaires :
- Objectifs secondaires : 
- Objectifs optionnels :
---
**Objectifs Sprint 6**
- Objectifs primaires :
  - JOURNALISATION - Mise en place d'une gestion des logs centralisée
    - Utilisation de [Graylog](https://github.com/Graylog2/graylog2-server)
    - Mise en production :
      1. Installation sur VM (non-dédié) ou CT
      2. Gestion des logs des serveurs
  - SUPERVISION - Mise en place d'une supervision de l'infrastructure réseau
    - Utilisation de [ZABBIX](https://www.zabbix.com/)
      - Mise en production :
          1. Installation sur VM/CT dédié
          2. Supervision des éléments de l'infrastructure (actuels et à venir)
          3. Mise en place de dashboard
- Objectifs secondaires :
  - JOURNALISATION - Mise en place d'une journalisation des scripts PowerShell
    1. Les logs seront construit pour pouvoir être lu par l'un des systèmes
    suivants :
        - Observateur d’événements Windows
        - Logiciel [CMTRACE](https://www.tech2tech.fr/cmtrace-lire-vos-fichiers-logs-facilement/)

    2. Modifier ou ajouter cette gestion de logs dans les scripts PowerShell
    utilisés (actuels et à venir)
    3. Utiliser un répertoire spécifique pour les logs (à définir)
    4. Un seul log par script
  - SUPERVISION      
- Objectifs optionnels :
---
**Objectifs Sprint 5**
- Objectifs primaires :
  - Dossiers Partagés *(en cours sp 5)*
    - Stockage des données sur un volume spécifique
    - Sécurité de partage dossiers par groupe AD
    - Mappage des lecteurs sur les clients, choisir entre 3 options
    - Accès utilisateurs à dossiers individuels + dossier de service
  - Sauvegarde *(en cours sp 5)*
    -   Linux backup? (pour la db MariaDB?) - planifier les sauvegardes du Windows Backup
  - Stockage avancé *(en cours sp 5)*
    - Mise en place de LVM sur serveur Debian
- Objectifs secondaires : 
  - Mot de passe admin local - mise en place de LAPS
    - Console de gestion sur un AD (GUI)
    - Installation sur au moins 1 client (GPO ou script)
  - Gestion des objets AD
    - Déplacement automatique des ordinateurs dans bonnes OU via nom d'une machien et/ou valeur attribut AD
    - Automatisation par scriptPS exécuté par tâche AT
  - Sécurité d'accès - Restrictions d'utilisation
    - Restrictions pour les utilisateurs standards, les admins + gestion d'exceptions
- Objectifs optionnels :
  - SSH Linux
  - GPO (date d'ancien sprint )
  - Télémétrie
---
**Objectifs Sprint 4**

- Objectifs primaires :
  - Gestion du serveur GLPI :
    - Syncronisation avec l'AD et inclusion des objets AD
    - Mise en place du système de ticketing
     - Accès et gestion à partir du client
  - Gérer le windows backup des deux serveurs
  - Ajouter les données utilisateurs sur l'AD
- Objectifs secondaires :
  - GPO : 5 règles GPO standard
--- 
**Objectifs Sprint 3**

- Objectifs primaires :
  - GPO : 5 règles de sécurité
  - Installation de Glpi sur serveur debian:
      - Syncronisation avec l'AD et inclusion des objets AD
      - Mise en place du système de ticketing
      - Accès et gestion à partir du client
  - Finaliser les objetctifs des semaines précédentes:
      - Ajouter le DC au Windows Core
      - Gérer le windows backup des deux serveurs
      - Ajouter les données utilisateurs sur l'AD

- Objectifs secondaires :
  - GPO : 5 règles GPO standard

- Objectifs optionnels :
    - Automatiser Installation Glpi (script shell)
    - Automatiser Installation AD-DS (script powershell)
    - Assurer le connexion (SSh) entre les serveurs Windows et Debian
---
**Objectifs Sprint 2**   

- Objectifs primaires : 
  - Création et mise en route serveurs AD, DHCP, DNS, WinCoreDC
  - Gérer les backup des 2 serveurs
  - Créer l’arborescence de l’AD
      - Mise en place des OU, groupes et utilisateurs

- Documentations
  - Install.md → installation des serveurs
  - User_Guide.md → gestion de l’AD, configuration IP

- Objectifs secondaires : 
  - Créer une VM serveur Linux Debian
  - Ajouter le serveur au Domain AD
  - Assurer la connexion (SSH) entre les serveurs Windows et le serveur Debian
---
**Objectifs Sprint 1**   

Objectifs principales:  
1 . Faire une proposition d'objectif par sprint pour l'ensemble de la formation (Détails de chaque semaine et de chaque objectifs)   
2. Réaliser un schéma de cette infrastructure en l’état et de sa potentielle évolution:
- Matériel réseau
- Serveur
- Adresse de réseau

Objectifs secondaires:  
3. Établir une convention de nommage    
4. Faire une table de routage  

---
