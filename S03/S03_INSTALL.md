Voici une version en **Markdown** prête pour GitHub : 

```markdown
# Préparation et Installation d'Ubuntu Server pour GLPI

## 👉 Préparation de la VM

1. **Téléchargez l'image ISO d'Ubuntu Server** :  
   - Vous pouvez télécharger une image ISO depuis [le site officiel d'Ubuntu](https://ubuntu.com/download/server).

2. **Préparez une VM** avec un hyperviseur comme **VirtualBox** selon les caractéristiques suivantes :  
   - **RAM** : Au minimum **2 Go**.  
   - **Disque dur** : Au minimum **20 Go**.  
   - **Réseau** : Configurez la carte réseau en mode **bridge** pour permettre à la VM <br>
 de communiquer avec votre réseau local et la box Internet.  
   - **Image ISO** : Insérez l'image ISO d'Ubuntu Server dans la VM.

---

## 👉 Installation d'Ubuntu Server

- **Navigation dans les menus** :  
  Utilisez les **flèches du clavier** et la **tabulation** pour vous déplacer, et sélectionnez avec **Entrée** ou **Espace**.

### Étapes d'installation :

1. **Démarrez la VM** et sélectionnez l'option `Try or Install` dans le menu GNU GRUB.
2. **Choisissez la langue** : `Français`.
3. **Mise à jour du programme d'installation** : Choisissez `Continuer sans mettre à jour`.
4. **Configuration clavier** : Sélectionnez `French` pour les deux options.
5. **Type d'installation** : Choisissez `Ubuntu Server` (et **pas minimized**).
6. **Connexion réseau** : Attendez que la configuration réseau automatique se fasse, puis cliquez sur `Terminer`.
7. **Configuration du proxy** : Ne rien mettre, cliquez sur `Terminer`.
8. **Miroir d'archives** : Laissez la valeur par défaut et cliquez sur `Terminer`.
9. **Configuration de stockage** :  
   - Choisissez `Utiliser un disque entier`.  
   - Cliquez deux fois sur `Terminé`.  
10. **Confirmation de l'action** : Choisissez `Continuer`.
11. **Configuration du profil** :  
    - **Nom complet** : Mettez un nom.  
    - **Nom de machine** : Mettez `glpi-server`.  
    - **Nom d'utilisateur** : Mettez `wilder`.  
    - **Mot de passe** : Saisissez un mot de passe (attention, le clavier est en **QWERTY**).  
    - Cliquez sur `Terminé`.

12. **Configuration SSH** : Ne cochez pas la case et cliquez sur `Terminé`.
13. **Options supplémentaires** : Ne rien cocher, cliquez sur `Terminé`.
14. **Installation** : Patientez quelques minutes pendant l'installation.

---

### Post-installation :

1. Une fois l'installation terminée, choisissez `Redémarrer maintenant`.
2. Retirez l'ISO de la VM et appuyez sur `Entrée`.
3. Connectez-vous avec le compte **wilder** et le mot de passe défini (le clavier est maintenant en **AZERTY**).
4. Vérifiez la configuration réseau avec la commande suivante :

   ```bash
   ip a
   ```

5. Si la configuration est correcte, créez un **snapshot** de la VM à partir de l'hyperviseur.

--- 
Voici une version en **Markdown** pour la section configuration à publier sur GitHub : 

```markdown
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
```
Voici une version en **Markdown** pour GitHub : 

```markdown
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

   > Si aucun mot de passe root n'est configuré (par défaut sur Ubuntu), appuyez simplement sur **Entrée**.

3. Configurez la base de données et les utilisateurs :

   ```sql
   CREATE DATABASE glpidb CHARACTER SET utf8 COLLATE utf8_bin;
   GRANT ALL PRIVILEGES ON glpidb.* TO glpi@localhost IDENTIFIED BY 'motDePasse';
   FLUSH PRIVILEGES;
   QUIT;
   ```

   - **Nom de la base de données** : `glpidb`  
   - **Utilisateur** : `glpi`  
   - **Mot de passe** : `motDePasse` (à remplacer par votre propre mot de passe sécurisé)

---

## Récupération des sources GLPI

1. Téléchargez les sources de GLPI :

   ```bash
   wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz
   ```

2. Créez un répertoire pour héberger GLPI :

   Si vous souhaitez lier le serveur GLPI à un nom de domaine :  

   ```bash
   sudo mkdir /var/www/glpi.monNomDeDomaine
   ```

   Sinon, remplacez `glpi.monNomDeDomaine` par un nom arbitraire.

3. Extrayez et déplacez les fichiers téléchargés :

   ```bash
   sudo tar -xzvf glpi-10.0.2.tgz
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
``` 
Voici une version en **Markdown** pour GitHub : 

```markdown
# 👉 Installation de GLPI

L'installation de GLPI se fait via un navigateur web à partir d'une autre machine sur le même réseau que votre serveur GLPI.

---

## Configuration réseau de la VM GLPI

### Étapes de configuration :

1. **Arrêtez la VM GLPI.**
2. Dans votre hyperviseur, modifiez la carte réseau :  
   - Passez-la de **bridge** à **réseau interne**.
3. **Redémarrez la VM.**

### Mise en place d'une adresse IP fixe :

1. Choisissez une adresse IP et un masque de sous-réseau approprié. Configurez-les sur votre VM Ubuntu Server.
2. Redémarrez la connexion réseau pour appliquer les changements.

### Vérification de la connectivité :

1. Démarrez une autre VM sur le même réseau (client Windows ou Linux).
2. Testez la connexion avec une commande **ping** vers la VM Ubuntu Server :

   ```bash
   ping [adresse IP de la VM GLPI]
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
   - **Utilisateur** : `glpi`
   - **Mot de passe** : Le mot de passe défini précédemment pour le compte `glpi`.

2. Cliquez sur `Continuer` pour finaliser la configuration.

GLPI est maintenant prêt à être utilisé. Accédez à l'interface utilisateur et connectez-vous avec les identifiants par défaut.
```
