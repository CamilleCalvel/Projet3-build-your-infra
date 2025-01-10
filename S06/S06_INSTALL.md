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
## 🛠️ Installation pas à pas de Graylog

Commençons par une mise à jour du cache des paquets et l'installation d'outils nécessaires pour la suite des événements :

```bash
sudo apt-get update
sudo apt-get install curl lsb-release ca-certificates gnupg2 pwgen
```

### 🗂️ A. Installation de MongoDB

#### 📥 Téléchargez la clé GPG :
```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
```

#### ➕ Ajoutez le dépôt MongoDB 6 :
```bash
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
```

#### 🔄 Mettez à jour le cache et installez MongoDB :

⚠️ **Dépendance manquante `libssl1.1`**

Installez `libssl1.1` manuellement :
```bash
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
```
Et une fois la dépendance manquante installée poursuivre avec :
```bash
sudo apt-get update
sudo apt-get install -y mongodb-org
```

Relancez l'installation de MongoDB :
```bash
sudo apt-get install -y mongodb-org
```

#### 🔧 Configurez et démarrez MongoDB :
```bash
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service
sudo systemctl --type=service --state=active | grep mongod
```

### 🗂️ B. Installation d'OpenSearch

#### 📥 Ajoutez la clé GPG :
```bash
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
```

#### ➕ Ajoutez le dépôt OpenSearch :
```bash
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
```

#### 🔄 Mettez à jour et installez OpenSearch :
```bash
sudo apt-get update
sudo env OPENSEARCH_INITIAL_ADMIN_PASSWORD=Azertygraylog1 apt-get install opensearch
```

#### ⚙️ Configurez OpenSearch :
Modifiez le fichier de configuration :
```bash
sudo nano /etc/opensearch/opensearch.yml
```

Ajoutez ou modifiez les paramètres suivants :
```yaml
cluster.name: graylog
node.name: ${HOSTNAME}
path.data: /var/lib/opensearch
path.logs: /var/log/opensearch
discovery.type: single-node
network.host: 127.0.0.1
action.auto_create_index: false
plugins.security.disabled: true
```

#### ⚙️ Configurez la JVM :
Modifiez la mémoire allouée :
```bash
sudo nano /etc/opensearch/jvm.options
```

Remplacez :
```text
-Xms1g
-Xmx1g
```
par :
```text
-Xms4g
-Xmx4g
```

Vérifiez ou configurez `max_map_count` :
```bash
cat /proc/sys/vm/max_map_count
sudo sysctl -w vm.max_map_count=262144
```

Activez et démarrez OpenSearch :
```bash
sudo systemctl daemon-reload
sudo systemctl enable opensearch
sudo systemctl restart opensearch
```

### 🗂️ C. Installation de Graylog

#### 📥 Téléchargez et installez Graylog :
```bash
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
sudo dpkg -i graylog-6.1-repository_latest.deb
sudo apt-get update
sudo apt-get install graylog-server
```

#### 🔧 Configurez Graylog :
Générez une clé `password_secret` :
```bash
pwgen -N 1 -s 96
```
Modifiez le fichier de configuration :
```bash
sudo nano /etc/graylog/server/server.conf
```

Ajoutez :
```text
password_secret=VOTRE_CLÉ_GÉNÉRÉE
root_password_sha2=HASH_DU_MOT_DE_PASSE
http_bind_address=0.0.0.0:9000
elasticsearch_hosts=http://127.0.0.1:9200
```

#### ⚙️ Démarrez Graylog :
```bash
sudo systemctl enable --now graylog-server
```

Accédez à l'interface web via :
```
http://<IP_DU_SERVEUR>:9000
```



