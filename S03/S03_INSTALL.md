# Préparation et Installation Debian 12 Server pour GLPI

## 👉 Préparation de la VM

1. **Téléchargez l'image ISO Debian Server** :  
   - Vous pouvez télécharger une image ISO depuis [le site officiel Debian](https://www.debian.org/distrib/).

2. **Préparez une VM** avec un hyperviseur comme **Proxmox** selon les caractéristiques suivantes :  
   - **RAM** : Au minimum **2 Go**.  
   - **Disque dur** : Au minimum **20 Go**.  
   - **Réseau** : Configurez une carte réseau en mode **bridge** pour permettre à la VM <br>
 de communiquer avec votre réseau local et la box Internet.<br> Et configurer une autre carte réseau en **interne** : *`172.24.0.3/24`*. 
   - **Image ISO** : Insérez l'image ISO Debian 12 dans la VM.

---

## 👉 Installation Debian Server

- **Navigation dans les menus** :  
  Utilisez les **flèches du clavier** et la **tabulation** pour vous déplacer, et sélectionnez avec **Entrée** ou **Espace**.

### Étapes d'installation :

1. **Démarrez la VM** et sélectionnez l'option `Graphical install` dans le menu.
2. **Choisissez la langue** : `French`.
3. **Configuration clavier** : Sélectionnez `French` pour les deux options.
4. **Mise à jour du programme d'installation** : Choisissez `Continuer sans mettre à jour`.
5. **Donner un nom au serveur** : `SRVLIN-03`.
6. **Configurer le réseau local** : `laisser vide` ou sélectionnez `Entrée`.
7. **Choisissez un mot de passe Fort pour le root** : il aura tout les privilèges.
8. **Création le compte Utilisateur** :
    - **Nom complet** : Mettez un nom.  
    - **Nom d'utilisateur** : Mettez un Nom ou alias.  
    - **Mot de passe** : Saisissez un mot de passe (attention, le clavier est en **Azerty** si vous avez sélectionné `French` dans les étapes précédentes).  
    - Cliquez sur `Continuer`.
9. **Partionnez votre disque** : Choissisé un partionnement sinon pour plus de facilité choisissez `Assisté-utiliser un disque entier`.
10. **Sélectionnez le disque** : Il faut choisir sur quel disque vous voulez installer Debian puis `Continuer`.
11. **Choissisez le nombre de partion** : Choissisez `Tout dans une seule partion` Recommandé.
12. **Terminez le partionnement** : `Appliquer les changements`.
13. **Finissez par** : `Oui`et cliquez sur `Continuer` pour lancer l'installation. 
14. **Confirmation de l'action** : Selectionnez `Oui` puis choisissez `Continuer`.
15. **Outils de Gestion des Paquets** : Analyser d'autres supports cliquez `Non`.
16. **Choix du miroir** : Choissisez le plus proche de votre pays puis `Continuer`.
14. **D'après votre sélection du pays** : Pour nous `deb.debian.org`, cliquez sur `Continuer`.
15. **Paramètres du mandataire** : Laissez vide et appuyer sur `Continuer`
16. **Participé à l'étude** : Cliquez `Non`.
17. **Sélection des logiciels** : A votre bon vouloir puis `Continuer`
18. **Démarrage GRUB** : Cliquez `Oui`
19. **Choix Disque** : Choisissez Le disque partionné dans les étapes précédentes puis `Continuer`
20. **Terminer l'installation** : Appuyer sur `Continuer`.<br>
<p align="center">
<i>Le serveur va démarrer et votre installation est FINITO.</i>
</p>

---

### Post-installation :

1. Une fois l'installation terminée, choisissez `Redémarrer maintenant`.
2. Retirez l'ISO de la VM et appuyez sur `Entrée`.
3. Connectez-vous avec le compte **utilisateur** et le mot de passe défini (le clavier est maintenant en **AZERTY**).
4. Vérifiez la configuration réseau avec la commande suivante :

```
   ip a
```

5. Si la configuration est correcte, créez un **snapshot** de la VM à partir de l'hyperviseur.

--- 

# 👉 Configuration

## Installation des prérequis

### Mise à jour des paquets

Commencez par mettre à jour le système :

```bash
sudo apt-get update && sudo apt-get upgrade
```

### Installation d'Apache

1. Installez le serveur web Apache :

   ```bash
   sudo apt-get install apache2 -y
   ```

2. Activez Apache pour qu'il démarre automatiquement avec la machine :

   ```bash
   sudo systemctl enable apache2
   ```

### Installation de MariaDB

1. Installez la base de données **MariaDB** :

   ```bash
   sudo apt-get install mariadb-server -y
   ```

### Installation des modules PHP

1. Installez PHP et son module Apache :

   ```bash
   sudo apt-get install php libapache2-mod-php -y
   ```

2. Installez les extensions PHP nécessaires :

   ```bash
   sudo apt-get install php-{ldap,imap,apcu,xmlrpc,curl,common,gd,json,mbstring,mysql,xml,intl,zip,bz2}
   ```

## Configuration de MariaDB

Suivez les étapes suivantes pour configurer MariaDB afin de préparer l'environnement pour votre application (détails à ajouter selon la configuration précise à effectuer).

# 👉 Configuration de la base de données et installation de GLPI

## Configuration de MariaDB

1. Lancez le processus d'initialisation de la base de données avec la commande suivante :

   ```bash
   sudo mysql_secure_installation
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
# Configuration Apache pour GLPI

## 1. Ajouter une configuration spécifique pour GLPI

### Étape 1 : Modifier le fichier de configuration
1. Ouvrez le fichier **000-default.conf** :
   ```bash
   sudo nano /etc/apache2/sites-available/000-default.conf
   ```

2. Ajoutez la configuration suivante **avant** la ligne `</VirtualHost>` :
   ```apache

     Alias /glpi /var/www/glpi
   
   DocumentRoot /var/www/glpi.ekoloclast.local

 

   <Directory /var/www/glpi.ekoloclast.local>
       Options Indexes FollowSymLinks
       AllowOverride All
       Require all granted
   </Directory>
   ```

### Étape 2 : Redémarrer Apache
Appliquez les modifications en redémarrant le service Apache :
```bash
sudo systemctl restart apache2
```
---

## Récupération des sources GLPI

1. Téléchargez les sources de GLPI :

   ```bash
   wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.10.tgz
   ```

2. Créez un répertoire pour héberger GLPI :

   Si vous souhaitez lier le serveur GLPI à un nom de domaine :  

   ```bash
   sudo mkdir /var/www/glpi.ekoloclast.local
   ```

   Sinon, remplacez `glpi.NomDeDomaine` par un nom arbitraire.

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
