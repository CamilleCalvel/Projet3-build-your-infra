
# Zabbix (brouillon , à remettre en forme

Installation du dépôt de Zabbix dans le système :
```
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
dpkg -i zabbix-release_latest_7.2+debian12_all.deb

```
Mise à jour de la liste des paquets et upgrade éventuel :
```
apt update && apt upgrade -y
```
Installation de Zabbix server, du frontend, et de l'agent :
```
apt install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
```

capture écran pour dire okay on a le serveur mariaDB installé

```
mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;
```

Lors de la connexion au serveur msql on constate que n'importe quel mdp fonctionne. L'accès au serveur est ouvert avec notre login unix en root


Importation du schéma et des données :



```
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

zcat est une commande qui permet de décompresser et d'afficher le contenu d'un fichier .gz sans le décompresser sur disque.
Elle décompresse le fichier server.sql.gz contenant les instructions SQL pour configurer Zabbix.
Elle envoie ces instructions directement vers la base de données MySQL/MariaDB zabbix en utilisant l'utilisateur zabbix.
Elle assure que la connexion utilise le jeu de caractères utf8mb4 pour une meilleure compatibilité avec les caractères Unicode.

Pour vérifier le succès de cette commande 

````
mysql -u ekoadmin -p zabbix
SHOW TABLES;
````
Si l'importation a réussi, vous verrez une liste de tables associées à Zabbix

Désactivation de la possibilité de modifier la configuration de la BD par des acteurs malveillants :

````
mysql -uroot -p
password
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
````

Edition du fichier de configuration de la BD du serveur Zabbix dans /etc/zabbix/zabbix_server.conf :
(Attention en situation de production, mauvaise pratique de laisser un mdp de base de données en clair, plutôt opter pour des solutions de chiffrement(installation supplémentaire))

````
DBPassword=a                # Mot de passe de l'utilisateur zabbix
DBHost=localhost            # Nom de l'hôte ou IP du serveur MySQL
DBName=zabbix               # Nom de la base de données Zabbix
DBUser=zabbix             # Utilisateur pour se connecter à la base de données
````

Configuration de PHP pour accéder au frontend dans /etc/zabbix/nginx.conf :
````
listen 8080;
server_name 172.16.0.3;
````

Démarrage du server et des processus de l'agent :

````
systemctl restart zabbix-server zabbix-agent nginx php8.2-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.2-fpm
````

Étape 3 - Configuration de Zabbix depuis la WUI

Depuis un client tape l'adresse de ton serveur dans un navigateur en ajoutant le port d'écoute : donc dans notre cas 172.24.0.7:8080


<p align="center">
<img src="" alt="Pictures" width="800" >
</p>

  A partir des boutons Next step, à toi de configurer ton serveur. Quelques indications... Tu devras renseigner entre autres :

  Le mdp de ta base de donnée
  Le nom de ton serveur Zabbix
  le fuseau horaire du serveur (UTC+1 si t'es à Paris et UTC+3 si t'es en Arménie au hasard hein)

<p align="center">
<img src="" alt="Pictures" width="800" >
</p>

## Installation et configuration de l'Agent Zabbix

Télécharger l'agent depuis https://www.zabbix.com/download_agents
Lancer l'installation de l'agent sur ton client Windows 10.
préciser l'adresse IP du serveur Zabbix dans le champ **Zabbix server IP/DNS:**

Pour installer l'agent, il faut les autorisations de l'administrateur de l'AD pour notre client.

<p align="center">
<img src="" alt="Pictures" width="800" >
</p>

## Ajout d'un hôte et création d'un groupe

Pour ta 1ère connexion sur la WUI tu utiliseras les identifiants par défaut :

Utilisateur : Admin
Mot de passe : zabbix


Création de groupes d'hôtes :

Dans le menu Data collection/Host groups :
Crée un groupe d'hôtes sous Windows en cliquant sur le bouton Create host group.
On ajoute les hotes windows et les linux servers en tant que groupes

dans notre cas, on ajoute notre machine nommée CLIWIN-02-ADM (hostname) , on lui accorde le "windows hosts" en host groups.
Rentrer l'adresse de l'agent.


Application du template pour la supervision des hôtes Windows :

Dans le menu Data collection/Hosts :
Clique sur le client.
Dans le champ Templates, clique sur le bouton Select.
Dans le champ Template group, clique sur le bouton Select.
Choisis Template.
Coche dans la liste le modèle Windows by Zabbix agent puis clique sur Select.
Clique sur le bouton Update.


