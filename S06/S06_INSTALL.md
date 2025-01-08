
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

Lors de la connexion au serveur msql, qui avait déjà été créé, on constate que n'importe quel mdp fonctionne. L'accès au serveur est ouvert avec notre login unix en root

donner les privilèges à ekoadmin@localhost plutôt que de créer un nouvel utilisateur de la db


Importation du schéma et des données :



```
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uekoadmin -p zabbix
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
DBPassword=a                # Mot de passe de l'utilisateur ekoadmin
DBHost=localhost            # Nom de l'hôte ou IP du serveur MySQL
DBName=zabbix               # Nom de la base de données Zabbix
DBUser=ekoadmin             # Utilisateur pour se connecter à la base de données
````

Configuration de PHP pour accéder au frontend dans /etc/zabbix/nginx.conf : (ET NON CAR IL NOUS FAUT UN DOSSIER CONF APACHE 
````
listen 8080;
server_name 172.16.0.3;
````

Démarrage du server et des processus de l'agent :

````
systemctl restart zabbix-server zabbix-agent nginx php8.2-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.2-fpm
````

ET LA ! PATATRAS !
On a pas installé nginx ! Mais heureusement peut être que les manip ne sont pas très différentes. 

````
(sudo apt remove zabbix-nginx-conf)
apt install zabbix-apache-conf
````



