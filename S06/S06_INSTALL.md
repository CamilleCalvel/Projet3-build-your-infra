# Nouvelles installations sprint 6

## Installation du Serveur Zabbix

Supervision de l'état du réseau, intégrité des machines et notifications email. *(Installation sur VM dédiée)*

---

## I. Installer l'environnement serveur de Zabbix

### 1. Installation du dépôt de Zabbix

```bash
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
dpkg -i zabbix-release_latest_7.2+debian12_all.deb
```

### 2. Mise à jour et installation des paquets nécessaires

```bash
apt update && apt upgrade -y
apt install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
```

---

## II. Configuration et installation des dépendances

### 1. Installation du SGBD

```bash
apt install mariadb-server
```

### 2. Vérification du SGBD

```bash
systemctl status mysql
```

### 3. Configuration de la base de données

```sql
mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;
```

> ⚠️ Lors de la connexion au serveur MySQL, n'importe quel mot de passe fonctionne car l'accès est ouvert avec notre login Unix en root.

### 4. Importation du schéma et des données

```bash
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

> `zcat` permet de décompresser et d'afficher le contenu d'un fichier `.gz` sans le décompresser sur disque.

#### Vérification de l'importation

```sql
mysql -u <utilisateur> -p <nomDeLaDB>
SHOW TABLES;
```

Si l'importation a réussi, vous verrez une liste de tables associées à Zabbix.

### 5. Désactivation de la modification des configurations par des acteurs malveillants

```sql
mysql -uroot -p
password
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
```

### 6. Configuration du fichier `zabbix_server.conf`

> 📌 **En production, il est déconseillé de stocker un mot de passe en clair. Optez pour des solutions de chiffrement.**

```ini
DBPassword=a                # Mot de passe de l'utilisateur zabbix
DBHost=localhost            # Nom de l'hôte ou IP du serveur MySQL
DBName=zabbix               # Nom de la base de données Zabbix
DBUser=zabbix               # Utilisateur pour se connecter à la base de données
```

### 7. Configuration de PHP pour le frontend

```nginx
listen 8080;
server_name 172.16.0.3;
```

### 8. Démarrage des services

```bash
systemctl restart zabbix-server zabbix-agent nginx php8.2-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.2-fpm
```

---

## III. Configuration de Zabbix depuis la WUI

Depuis un client, accédez à l'interface web en tapant l'adresse du serveur dans un navigateur :

```
http://172.24.0.7:8080
```

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_urlConnexion.png" alt="Pictures" width="600" >
</p>


À partir des boutons **Next step**, configurez votre serveur Zabbix :
- Le mot de passe de la base de données
- Le nom du serveur Zabbix
- Le fuseau horaire du serveur


<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_configServeur.png" alt="Pictures" width="600" >
</p>

---

## IV. Installation et configuration de l'Agent Zabbix

1. **Télécharger l'agent** depuis : [https://www.zabbix.com/download_agents](https://www.zabbix.com/download_agents)
2. **Lancer l'installation** de l'agent sur votre client Windows 10
3. **Préciser l'adresse IP du serveur Zabbix** dans le champ :
   - **Zabbix server IP/DNS**

> ⚠️ Pour installer l'agent, il faut les autorisations de l'administrateur de l'Active Directory.

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_autorisationAdmin.png" alt="Pictures" width="400" >
</p>

---

## V. Ajout d'un hôte et création d'un groupe

### 1. Connexion à l'interface Web

Utiliser les identifiants par défaut :
- **Utilisateur** : `Admin`
- **Mot de passe** : `zabbix`

### 2. Création de groupes d'hôtes

📌 **Dans le menu :** `Data collection > Host groups`
- Cliquez sur **Create host group**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_createhostGroup.png" alt="Pictures" width="800" >
</p>

- Ajoutez les groupes souhaités
> Dans notre cas, nous souhaitons faire la distinction entre clients Windows et serveurs Windows, ces groupes existant déjà pour Linux

### 3. Ajout des hôtes

📌 **Dans le menu :** `Data collection > Hosts`
- Cliquez sur **Create host**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_CreateHosts.png" alt="Pictures" width="800" >
</p>


- Ajoutez l'étiquette du groupe souhaité pour que l'hôte soit assigné à ce groupe

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_HostCreation2.png" alt="Pictures" width="800" >
</p>

> Exemple : ajout de la machine `CLIWIN-02-ADM` au groupe `Windows hosts`
- Ajoutez l'interface Agent
- Renseignez l'adresse IP de votre client

---

## VI. Configuration des alertes et des notifications

### Application du template pour la supervision des hôtes Windows

📌 **Dans le menu :** `Data collection > Hosts`

1. Sélectionnez l'hote créé
2. Dans le champ **Templates**, cliquez sur **Select**


3. Dans le champ **Template group**, cliquez sur **Select**
4. Choisissez **Template**
5. **Cochez** `Windows by Zabbix agent`

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_AlerteNot_Template.png" alt="Pictures" width="400" >
</p>

6. Cliquez sur **Select**, puis **Update**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_AlerteNot_update.png" alt="Pictures" width="700" >
</p>

### Configurer la notification avec une adresse mail

🔗 [Vidéo explicative sur YouTube](https://www.youtube.com/watch?v=9DT7kR8fa0o)

---

#### 1. Générer un mot de passe d'application

1. **Activer IMAP dans Gmail**  
   - Allez dans les paramètres de votre compte Gmail.  
   - Rendez-vous dans l'onglet **Transfert et POP/IMAP**, puis cochez la case **Activer IMAP**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/72915fd3-b649-47b1-9f78-81587b9dc962" alt="Paramètres Gmail" width="500">
   </p>

2. **Accéder à la gestion du compte Google**  
   - Cliquez sur votre photo de profil.  
   - Sélectionnez **Gérer votre compte Google**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/20562fb7-d871-4c3b-9607-b2cd5e30a280" alt="Gestion du compte Google" width="300">
   </p>

3. **Activer la validation en deux étapes**  
   - Rendez-vous dans l'onglet **Sécurité**.  
   - Cliquez sur **Validation en 2 étapes**, puis suivez les instructions pour l'activer.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/79bf5ed5-5544-426c-9174-70ba0165c57a" alt="Validation en 2 étapes" width="700">
   </p>

4. **Générer un mot de passe d'application**  
   - Dans la barre de recherche, saisissez **Mots de passe des applications**.  
   - Donnez un nom à l'application (par exemple : **Zabbix-Email**) et générez le mot de passe.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/f215a01f-662b-48cd-8544-2aa82e609d72" alt="Génération de mot de passe d'application" width="500">
   </p>

   :warning: **Notez bien le mot de passe généré**, il sera nécessaire pour les étapes suivantes.


#### 2. Créer un nouveau Media Type dans Zabbix

1. **Accéder aux Media Types**  
   - Dans le menu de Zabbix, naviguez vers : **Alerts > Media Types**.  
   - Cliquez sur **Email** dans la liste.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/427d9c82-913c-4949-ab79-2c40e8c8a7f6" alt="Menu Media Types" width="800">
   </p>

2. **Configurer les paramètres du Media Type**  
   Remplissez les champs comme suit :  
   - **Name** : Zabbix_Email  
   - **Type** : Email  
   - **Email Provider** : Generic SMTP  
   - **SMTP server** : smtp.gmail.com  
   - **SMTP server port** : 465  
   - **Email** : ekoloclast@gmail.com  
   - **SMTP helo** : gmail.com  
   - **Connection security** : SSL/TLS  
   - **Authentication** : Username and password  
     - **Username** : ekoloclast@gmail.com  
     - **Password** : Mot de passe généré précédemment  
   - **Message format** : HTML  
   - **Description** : Zabbix_Email  

   <p align="center">
     <img src="https://github.com/user-attachments/assets/4201fcce-d798-40ef-88c9-be42ad963bc3" alt="Configuration partie 1" width="600">
   </p>
   <p align="center">
     <img src="https://github.com/user-attachments/assets/40c875c3-7402-440f-bdbf-136ffe3f0329" alt="Configuration partie 2" width="600">
   </p>

3. **Sauvegarder**  
   - Cliquez sur **Update** pour enregistrer les modifications.
     

#### 3. Tester l'envoi de notifications

1. **Tester le Media Type**  
   - Sur la page du Media Type **Zabbix_Email**, cliquez sur le bouton **Test**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/4c9e5c89-38ff-4b20-87bf-62ec0fab4594" alt="Test du Media Type" width="900">
   </p>

2. **Renseigner l'adresse email**  
   - Entrez l'adresse email : **ekoloclast@gmail.com** et cliquez sur **Test**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/eac6d1d6-7dc4-46b4-b68d-5168dede995b" alt="Test d'envoi d'email" width="600">
   </p>

3. **Vérifier l'email**  
   - Confirmez que le message de test est bien reçu dans la boîte mail **ekoloclast@gmail.com**.


### Création d'une alerte spécifique liée à l'utilisation de notre RAM :

Dans le menu **"Data collection"** > **"Hosts"** :

- Clique sur **Items** qui se trouve sur la ligne de ton client.
- Dans le champ **Name** écris "memory utilization" puis tape entrée.
- Clique sur **Memory utilization** puis sur le bouton **Clone**.
- Donne un nom et une **key** à ton item pour le test (ex : **Alerte RAM** et **AlerteRAM**).
- Clique sur **Add**.

### Configuration du déclencheur de l'alerte précédemment créée.

Dans le menu **"Data collection"** > **"Hosts"** :

- Clique sur **Triggers** qui se trouve sur la ligne de ton client.
- Clique sur le bouton **Create trigger** et donne-lui un nom (ex : **WindowsAlerteRam**).
- Clique sur **Disaster** et sur **Add** du champ **Expression**.
- Sélectionne dans la liste ton item **Alerte RAM**.
- Dans **Result** sélectionne **>=** puis la valeur qui va te permettre de déclencher l'alerte.
- Clique sur **Insert** puis **Add** en bas de la fenêtre.

### Paramétrage supplémentaire pour la réception d'alerte.

- Zou dans **"Users"** > **"Users"**
- Cliquer sur **"Admin"** et choisir l'onglet **"Media"** à droite de **"User"**
- Dans l'encart **media**, cliquer sur **"Add"**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_Users_Users.png" alt="Pictures" width="700" >
</p>

- Définir **type** = **"Zabbix_Email"**
- Dans le champ **"send to"** choisir l'adresse email précédemment rentrée dans le **media type** en étape 2.
- Cocher le niveau de **sévérité** de votre choix. Vérifier si c'est bien **"Enabled"**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_levelseverite.png" alt="Pictures" width="700" >
</p>

- Cliquer sur **"Add"** et, de même, ne pas oublier de **"Update"**.

Pour tester, déclencher l'alerte. Pour vérifier qu'elle a été déclenchée, se rendre dans **"Monitoring"** > **"Problems"** où devraient s'afficher les alertes déclenchées.
Enfin, se rendre dans la **boîte mail concernée** et vérifier que le mail d'alerte a bien été reçu, puis après un retour à la normale, vérifier également la réception d'un mail indiquant la **résolution de problème**.


   


