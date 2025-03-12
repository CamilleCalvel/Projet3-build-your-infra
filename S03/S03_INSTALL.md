# Configuration d'une VM Debian

## Configuration réseau
```bash
nano /etc/network/interfaces
```
- IP dynamique:
   - allow-hotplug nomdeinterface
   - iface nomdeinterface inet dhcp
     
- IP static:
   - allow-hotplug nomdeinterface
   - iface nomdeinterface inet static
   - address x.x.x.x/x
   - gateway x.x.x.x
- Exemple:
<img src="https://github.com/user-attachments/assets/616af6b3-e61d-4317-9722-0f28590ec592" alt="Pictures" width="800" >

## Configuration DNS
```bash
nano /etc/resolv.conf
```
- Renseigner l'adresse IP de votre serveur DNS
- Exemple:  
<img src="https://github.com/user-attachments/assets/123dd48d-3b9e-4545-a081-27f09311758f" alt="Pictures" width="800" >

## Configuration nom d'hôte
```bash
nano /etc/hostname
```
- Exemple:
<img src="https://github.com/user-attachments/assets/5e70a0c1-27d3-481f-9ef2-2e9c8bce2adc" alt="Pictures" width="800" >  

## Ajout à l'Active Directory

- Joindre la machine Debian au domaine Active Directory (AD).  
```bash
apt install packagekit samba-common-bin sssd-tools sssd libnss-sss libpam-sss policykit-1 sssd ntpdate ntp realmd` 
```
- Modifier le fichier `resolv.conf` avec `nameserver Adresse IP du server DNS`, `nameserver 1.1.1.1 (opt)` et `search Nomdedomaine`
Exemple:
<img src="https://github.com/user-attachments/assets/05a59ebe-68e4-4c91-925b-8857765ef12d" alt="Pictures" width="800" >  

- Se connecter au domaine avec la commande:
```bash
realm join --user=administrator/eur Nomdedomaine
```
- Renseigner le mot de passe de l'Administrateur du serveur AD
- Afficher le résumé avec la commande
```bash
realm list
```
<img src="https://github.com/user-attachments/assets/7201c038-fac5-4614-8adf-43a25b6e183c" alt="Pictures" width="800" > 

---

# 👉 Installation server GLPI

## Installation des prérequis

### Mise à jour des paquets

Commencez par mettre à jour le système :

```bash
apt update && apt upgrade -y
```

### Installation d'Apache

1. Installez le serveur web Apache :

   ```bash
   apt install apache2 -y
   ```

2. Activez Apache pour qu'il démarre automatiquement avec la machine :

   ```bash
   systemctl enable apache2
   ```

### Installation de MariaDB

1. Installez la base de données **MariaDB** :

   ```bash
   apt install mariadb-server -y
   ```

### Installation des modules PHP

1. Installez PHP et son module Apache :

   ```bash
   apt install php libapache2-mod-php -y
   ```

2. Installez les extensions PHP nécessaires :

   ```bash
   apt install php-{ldap,imap,apcu,xmlrpc,curl,common,gd,json,mbstring,mysql,xml,intl,zip,bz2}
   ```

## Configuration de MariaDB

Suivez les étapes suivantes pour configurer MariaDB afin de préparer l'environnement pour votre application (détails à ajouter selon la configuration précise à effectuer).

# 👉 Configuration de la base de données et installation de GLPI

## Configuration de MariaDB

1. Lancez le processus d'initialisation de la base de données avec la commande suivante :

   ```bash
   mysql_secure_installation
   ```

   Répondez `Y` à toutes les questions posées.  

   > **Attention** : Lors de la question `Change the root password?`, saisissez un mot de passe pour le compte **root** de MariaDB.  
   **Gardez bien ce mot de passe** car il sera nécessaire plus tard dans l'installation.

2. Connectez-vous à la base de données MariaDB :

   ```bash
   mysql -u root -p
   ```

3. Configurez la base de données et les utilisateurs :

   ```sql
   CREATE DATABASE ekoglpidb CHARACTER SET utf8 COLLATE utf8_bin;
   GRANT ALL PRIVILEGES ON ekoglpidb.* TO ekoadmin@localhost IDENTIFIED BY 'motDePasse';
   FLUSH PRIVILEGES;
   QUIT;
   ```

   - **Nom de la base de données** : `ekoglpidb`  
   - **Utilisateur** : `ekoadmin`  
   - **Mot de passe** : `MotDePasse` (à remplacer par votre propre mot de passe sécurisé)

---

## Récupération des sources GLPI

1. Téléchargez les sources de GLPI :

   ```bash
   wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.10.tgz
   ```

2. Créez un répertoire pour héberger GLPI :

   Si vous souhaitez lier le serveur GLPI à un nom de domaine :  

   ```bash
   sudo mkdir /var/www/glpi.monNomDeDomaine
   ```

3. Extrayez et déplacez les fichiers téléchargés :

   ```bash
   sudo tar -xzvf glpi-10.0.10.tgz
   sudo cp -R glpi/* /var/www/glpi.monNomDeDomaine/
   ```

4. Modifiez les droits d'accès pour les fichiers de GLPI :

   ```bash
   sudo chown -R www-data:www-data /var/www/glpi.monNomDeDomaine/
   sudo chmod -R 775 /var/www/glpi.monNomDeDomaine/
   ```

---

## Configuration Apache pour GLPI

### Étape 1 : Modifier le fichier de configuration
1. Ouvrez le fichier **000-default.conf** :
   ```bash
   sudo nano /etc/apache2/sites-available/000-default.conf
   ```

2. Ajoutez la configuration suivante **avant** la ligne `</VirtualHost>` :
   ```apache
   
   DocumentRoot /var/www/glpi.monNomDeDomaine

   ```

### Étape 2 : Redémarrer Apache
Appliquez les modifications en redémarrant le service Apache :
```bash
sudo systemctl restart apache2
```
---

## Configuration de PHP

1. Éditez le fichier `php.ini` pour Apache :  

   ```bash
   sudo nano /etc/php/8.1/apache2/php.ini
   ```

2. Modifiez ou ajoutez les paramètres suivants :  

   ```ini
   memory_limit = 64M
   file_uploads = On
   max_execution_time = 600
   session.auto_start = 0
   session.use_trans_sid = 0
   ```

3. Enregistrez et fermez le fichier.

---

GLPI est maintenant configuré pour être installé sur votre serveur. Passez à l'étape suivante pour compléter l'installation via l'interface web.

# 👉 Installation de GLPI

L'installation de GLPI se fait via un navigateur web à partir d'une autre machine sur le même réseau que votre serveur GLPI.

---

## Configuration réseau de la VM Ubuntu

### Étapes de configuration :
1. **Allumer une VM Ubuntu**  
2. Configurer son réseau interne sur `172.24.0.4/24` pour qu'elle puisse se connecter avec le serveur GLPI

### Vérification de la connectivité :

1. Testez la connexion avec une commande **ping** vers la VM Debian Server :

   ```bash
   ping 172.24.0.3
   ```

   Si le ping fonctionne, la configuration réseau est correcte.

---

## Accès au serveur GLPI via un navigateur

1. Ouvrez un navigateur web sur la VM client.
2. Saisissez l’adresse suivante dans la barre d’adresse :

   ```
   http://[adresse IP du serveur GLPI]/glpi
   ```

---

## Configuration de GLPI via l’interface graphique

### Étapes d’installation :

1. **Choisissez la langue** : Sélectionnez `Français`.
2. **Acceptez la licence GPL** :  
   - Cochez la case `J'ai lu et accepté...`.  
   - Cliquez sur `Installer`.
3. **Vérifiez les prérequis** : Si tout est correct, cliquez sur `Continuer`.

---

## Configuration de la base de données MariaDB

1. Renseignez les informations suivantes dans le formulaire :
   - **Serveur SQL** : `127.0.0.1`
   - **Utilisateur** : `ekoadmin`
   - **Mot de passe** : `se référer à la convention de nommage de mots de passe`.

2. Cliquez sur `Continuer` pour finaliser la configuration.

GLPI est maintenant prêt à être utilisé. Accédez à l'interface utilisateur et connectez-vous avec les identifiants par défaut.

---
---
---
---
---
---
---
---
---
---

# 👉 Vérifications si problème d'installation.

Votre plan d'installation et de configuration de GLPI semble complet et fonctionnel. Voici un récapitulatif des points clés à vérifier pour garantir que tout fonctionne comme prévu :

---

### **Vérification préalable**

1. **ISO Debian Server** : Assurez-vous d'utiliser une version compatible avec les prérequis de GLPI.
2. **Réseau** :
   - Mode **bridge** pour télécharger les mises à jour et les fichiers nécessaires.
   - Puis mode **réseau interne** pour accéder depuis une machine client.

---

### **Étapes critiques à valider**

1. **Installation et configuration d'Apache** :
   - Vérifiez que le service Apache est actif après l'installation :
     ```bash
     sudo systemctl status apache2
     ```
   - Testez l'accès au serveur local en entrant `http://127.0.0.1` dans un navigateur sur la VM.

2. **Configuration de MariaDB** :
   - Pendant l'exécution de `sudo mysql_secure_installation`, notez bien le mot de passe **root**.
   - Après avoir créé la base de données `glpidb` et l'utilisateur `glpi`, vérifiez que les privilèges sont correctement assignés :
     ```sql
     SHOW GRANTS FOR 'glpi'@'localhost';
     ```

3. **PHP et extensions** :
   - Assurez-vous que les extensions PHP installées correspondent aux besoins de GLPI :
     ```bash
     php -m | grep -E "ldap|imap|apcu|xmlrpc|curl|gd|json|mbstring|mysql|intl|zip|bz2"
     ```
   - Testez la configuration PHP avec un fichier `phpinfo()`.

4. **Téléchargement et configuration de GLPI** :
   - Validez que les fichiers GLPI sont bien extraits dans `/var/www/glpi.monNomDeDomaine/` et accessibles.
   - Assurez-vous que les permissions sur ce dossier permettent l'écriture par Apache :
     ```bash
     ls -l /var/www/glpi.monNomDeDomaine/
     ```

5. **Configuration de PHP (`php.ini`)** :
   - Vérifiez que les changements ont été appliqués en redémarrant Apache :
     ```bash
     sudo systemctl restart apache2
     ```

---

###  **Vérification réseau**

1. **Adresse IP fixe** :
   - Validez la configuration avec la commande :
     ```bash
     ip a
     ```
   - Testez la connectivité entre les deux VMs avec `ping`.

2. **Accès depuis une autre machine** :
   - Ouvrez un navigateur sur une machine du même réseau et accédez à :
     ```
     http://[IP de votre serveur]/glpi
     ```
   - Si cela échoue, vérifiez les règles de pare-feu sur la VM :
     ```bash
     sudo ufw allow in "Apache Full"
     sudo ufw enable
     ```

---

### **Installation via l'interface GLPI**

1. **Langue et licence** :
   - Assurez-vous que les prérequis système sont validés par GLPI avant de continuer.

2. **Base de données MariaDB** :
   - Testez la connexion à la base depuis PHP en créant un script temporaire :
     ```php
     <?php
     $link = mysqli_connect("127.0.0.1", "glpi", "votreMotDePasse", "glpidb");
     if (!$link) {
         die('Erreur de connexion : ' . mysqli_error($link));
     }
     echo 'Connexion réussie à MariaDB';
     ?>
     ```

---

### **Validation finale**

1. Accédez à l'interface de connexion GLPI après l'installation.
2. Connectez-vous avec les identifiants par défaut :
   - **Admin** : `glpi`
   - **Mot de passe** : `glpi`

---
 😊
