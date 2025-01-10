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



