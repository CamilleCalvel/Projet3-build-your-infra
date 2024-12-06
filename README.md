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
| **Semaine 3** | Technicien       | Product Owner     | Scrum Master   | Technicien      | Technicienne   |
| **Semaine 4** |      |      |    |     |    |

[Planification globale sur les différents sprints](https://miro.com/app/board/uXjVLDxuzTU=/)

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
