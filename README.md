# Documentation générale

## 1. 🌍 Introduction : mise en contexte

**Ekoloclast** est une start-up innovante fondée il y a moins de deux ans, située à Paris (8ᵉ arrondissement). Elle vise à révolutionner l'approche de l'écologie en introduisant des pratiques, produits et services écologiques novateurs bénéficiant à la fois à l'environnement et aux individus.

Ekoloclast s'adresse aux marchés professionnels (B2B) et consommateurs (B2C). Récemment, une levée de fonds significative a permis à l'entreprise de préparer une expansion prometteuse. La société compte actuellement 183 employés répartis dans 10 services (« départements »), en collaboration ponctuelle ou régulière avec des personnels extérieurs.

Nous faisons partie de la société Ekoloclast, et notre formateur joue le rôle du DSI de cette entreprise.

---

## 2. 📚 Présentation du projet, objectifs finaux

Notre objectif final est de mettre en place une nouvelle infrastructure réseau.

---

## 3. 👥 Présentation de l'équipe

| Semaine       | Igor             | Souhail         | Adeline          | François        | Camille        |
|---------------|------------------|-----------------|------------------|-----------------|----------------|
| **Semaine 1** | Product Owner    | Scrum Master    | Technicienne     | Technicien      | Technicienne   |
| **Semaine 2** | Technicien       | Technicien      | Technicienne     | Scrum Master    | Product Owner  |
| **Semaine 3** | Technicien       | Product Owner   | Scrum Master     | Technicien      | Technicienne   |
| **Semaine 4** | Technicien       | Technicien      | Technicienne     | Product Owner   | Scrum Master   |  
| **Semaine 5** | Scrum Master     | Technicien      | Product Owner    | Technicien      | Technicienne   |  
| **Semaine 6** | Technicien       | Product Owner   | Technicienne     | Scrum Master    | Technicienne   |  
| **Semaine 7** | Product Owner    | Technicien      | Technicienne     | Technicien      | Scrum Master   |  
| **Semaine 8** | Technicien       | Scrum Master    | Technicien       | Product owner   | Technicien     |
| **Semaine 9** | Technicien       | Technicien      | Scrum Master     | Technicien      | Product owner  |

[Planification globale sur les différents sprints](https://miro.com/app/board/uXjVLDxuzTU=/)

---

## Plan du réseau au 30.01

![chrome_IB72rBAHyb](https://github.com/user-attachments/assets/a7a9ecb5-04bf-4d70-a023-82beb3302e7e)

## ⚙️ Objectifs par sprint

### **🔁 Objectifs Sprint 9**
#### **🔑Objectifs primaires :** <br>
  - Mise en place d’un serveur de téléphonie sur IP avec FreePBX

#### **🔒Objectifs secondaires :** <br>
  - Mettre en place un serveur web et hébergement de site

#### **♻️Partenariat avec PharmGreen :** <br>
  - Mise en place d’un serveur RDP

#### **🔵Objectifs optionnels :** <br>
  - Configuration de l’authentification LDAP/AD sur le serveur FreePBX<br>
  - Rendre le site web accessible pour tout le monde depuis l'extérieur qui liste les étapes réalisées pour l’installation de Postfix<br>

---

### **🔁 Objectifs Sprint 8**
#### **🔑 Objectifs primaires :**
  - Sécurité : Mise en place d’un serveur de gestion des mises à jour WSUS
  - Partenariat avec Pharmgreen : Mise en place sur Pfsense d’un VPN site à site
#### **🔒 Objectifs secondaires :**
  - Rôles FSMO : Mise en place d’un 3 ème DC et Répartitions des rôles FSMO entre les DC 
  - Partenariat avec Pharmagreen : 
  - Retard sur sprints passés : mise en place de partage de fichiers individuels  

---

### **🔄 Objectifs Sprint 7**

#### **📧 Objectifs primaires :**
- **_MESSAGERIE :_** Mettre en place un serveur de messagerie :
  - [Postfix](https://www.postfix.org/) associé à [Dovecot](https://www.dovecot.org/).
  - Installation sur VM/CT dédié.
  - Communication interne (au sein de l'entreprise).
- **_SÉCURITÉ :_** Mettre en place un serveur de gestion de mot de passe :
  - [Bitwarden](https://bitwarden.com/fr-fr/download/).

#### **🔒 Objectifs secondaires :**
- **_MESSAGERIE :_**
  - Connexion cliente via client de messagerie local (au choix du groupe).
  - Accès aux mails via webmail.
- **_SÉCURITÉ :_**
  - Installation sur VM existante ou CT dédié.
  - Connexion web pour administration et utilisation.

#### **🔵 Objectifs optionnels :**
- **_MESSAGERIE :_**
  - Communication externe à l'entreprise.
  - Boîtes mails liées aux comptes utilisateurs AD.
- **_GESTION DE PROJET :_**
  - Installation de [RedMine](https://www.redmine.org/) sur serveur local.

---

### **🔄 Objectifs Sprint 6**

#### **🔑 Objectifs primaires :**
- **Active Directory :**
  - Intégration des nouveaux utilisateurs selon un nouveau fichier RH.
- **Journalisation :**
  - Mise en place d'une gestion des logs centralisée avec [Graylog](https://github.com/Graylog2/graylog2-server).
- **Supervision :**
  - Mise en place d'une supervision réseau via [Zabbix](https://www.zabbix.com/).

#### **🔒 Objectifs secondaires :**
- Supervision du pare-feu pfsense et création de dashboards.

#### **🔵 Objectifs optionnels :**
- Journalisation des scripts PowerShell avec gestion centralisée des logs.

---

### **🔄 Objectifs Sprint 5**

#### **🔑 Objectifs primaires :**
- Mise en place des dossiers partagés (sécurité par groupes AD).
- Planification des sauvegardes Windows Backup et Linux Backup.
- Mise en place de LVM sur serveur Debian.

#### **🔒 Objectifs secondaires :**
- Mise en place de LAPS pour la gestion des mots de passe admin locaux.
- Gestion automatisée des objets AD.
- Sécurité d'accès : restrictions utilisateurs et gestion d'exceptions.

---

### **🔄 Objectifs Sprint 4**

#### **🔑 Objectifs primaires :**
- Gestion du serveur GLPI :
  - Synchronisation avec l'AD.
  - Mise en place du système de ticketing.
- Gestion des sauvegardes Windows Backup.

#### **🔒 Objectifs secondaires :**
- Mise en place de 5 règles GPO standard.

---

### **🔄 Objectifs Sprint 3**

#### **🔑 Objectifs primaires :**
- Mise en place de 5 règles de sécurité GPO.
- Installation de GLPI sur serveur Debian avec synchronisation AD.

#### **🔒 Objectifs secondaires :**
- Mise en place de scripts pour automatiser certaines installations (GLPI, AD-DS).

---

### **🔄 Objectifs Sprint 2**

#### **🔑 Objectifs primaires :**
- Création des serveurs AD, DHCP, DNS.
- Gestion des backups.
- Mise en place de l'arborescence AD (OU, groupes, utilisateurs).

#### **🔒 Documentations :**
- **Install.md :** installation des serveurs.
- **User_Guide.md :** gestion de l'AD et configuration IP.

---

### **🔄 Objectifs Sprint 1**

#### **🔑 Objectifs primaires :**
1. Proposition d'objectifs par sprint pour toute la formation.
2. Schéma de l'infrastructure actuelle et future (matériel réseau, serveurs, adresses).

#### **🔒 Objectifs secondaires :**
- Convention de nommage.
- Table de routage.

