
# Installation de Moodle (CMS) sur une distribution basée sur Debian

## Documentation de référence
- [Installer Moodle sur Debian](https://docs.moodle.org/405/en/Installing_Moodle_on_Debian_based_distributions)
- [Guide pour installer Moodle sur Debian 12](https://idroot.us/install-moodle-debian-12/)
- [Documentation officielle Moodle](https://docs.moodle.org/405/en/Installing_Moodle)


> Modifications à prendre en compte.

> L'étape 1 n'est pas indispensable et surtout ne marche pas systématiquement sur debian.

> La partie dans le fichier ini php à l'étape 3 ne nécessite pas forcément extension=gs.so ni extension=sqli.so (elles seront installées automatiquement dans un autre .ini)

> ajouter la partie cron du moodle doc debian



---

## Étape 1 : Préparer l'installation PHP
Exécutez les commandes suivantes pour préparer les paquets à installer, les mettre à jour, et vérifier leurs signatures :

```bash
apt-get -y install lsb-release ca-certificates curl
```
Installe les paquets nécessaires pour gérer les versions et les certificats.

```bash
curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
```
Télécharge le fichier de clé pour le dépôt PHP Sury.

```bash
dpkg -i /tmp/debsuryorg-archive-keyring.deb
```
Installe la clé de vérification du dépôt.

```bash
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
```
Ajoute le dépôt PHP Sury à la liste des sources APT.

---

## Étape 2 : Installer MariaDB et PHP

### Installer MariaDB
Exécutez les commandes suivantes pour configurer le dépôt MariaDB :
```bash
curl -fsSL https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash
```
Ajoute le dépôt MariaDB à votre système (remplacez `sudo` si vous êtes connecté en tant que root).

```bash
apt update
```
Met à jour les informations de paquets.

### Installer les paquets requis

```bash
apt-get install apache2 php8.2 mariadb-server php8.2-mysql libapache2-mod-php8.2 php8.2-gd php8.2-curl php8.2-xmlrpc php8.2-xml php8.2-soap php8.2-intl php8.2-zip php8.2-mbstring
```
Installe Apache, PHP 8.2, MariaDB, et les extensions PHP requises pour Moodle. Les erreurs potentielles liées à `xml` et `soap` ont été corrigées.

---

## Étape 3 : Configuration du fichier `php.ini`

Modifiez le fichier `/etc/php/8.2/apache2/php.ini` en ajoutant ou modifiant les entrées suivantes (Dans un 1er temps éviter les ajouts extensions=xxx.so, elles risques de faire doublon) :

```ini
; Désactivez les doublons si besoin :
;extension=gd.so
;extension=mysqli.so

; Activez les extensions requises :
extension=mysqli.so
extension=gd.so

; Ajustez les limites pour Moodle :
memory_limit = 40M
post_max_size = 80M
upload_max_filesize = 80M
max_input_vars = 25000
```
Redémarrez Apache pour appliquer les modifications :
```bash
systemctl restart apache2
```

---

## Étape 4 : Tester l'installation PHP
Créez un fichier de test nommé `phpinfo.php` dans `/var/www/html` avec le contenu suivant :

```php
<?php
phpinfo();
?>
```
Appliquez les autorisations nécessaires :
```bash
sudo chown www-data:www-data /var/www/html/phpinfo.php
sudo chmod 644 /var/www/html/phpinfo.php
```
Modifiez le fichier `/etc/apache2/sites-available/000-default.conf` pour autoriser l'accès :

```xml
<Directory /var/www/html>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
```
Redémarrez Apache :
```bash
systemctl restart apache2
```
Accédez ensuite à `http://localhost/phpinfo.php` depuis un navigateur.

---

## Étape 5 : Configurer la base de données

Définissez un mot de passe administrateur MariaDB :
```bash
mariadb-admin -u root password "mySecurePassword"
```
Créez une base de données pour Moodle :
```sql
CREATE DATABASE moodle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
Redémarrez MariaDB :
```bash
systemctl restart mariadb
```

---

## Étape 6 : Télécharger et décompresser Moodle

Téléchargez Moodle depuis GitHub :
```bash
curl -L https://github.com/moodle/moodle/archive/refs/tags/v4.5.0.tar.gz -o moodle-4.5.0.tar.gz
```
Décompressez les fichiers dans `/var/www/html` :
```bash
tar -xzvf moodle-4.5.0.tar.gz -C /var/www/html/
```
Appliquez des permissions sécurisées :
```bash
chmod -R 755 /var/www/html/moodle-4.5.0
```

---

## Étape 7 : Créer un répertoire de données et attribuer des permissions

Créez le répertoire de données Moodle :
```bash
mkdir /var/www/MoodleData
```
Attribuez les permissions à Apache :
```bash
chown -R www-data:www-data /var/www/html/moodle-4.5.0
chown -R www-data:www-data /var/www/MoodleData
chmod -R 755 /var/www/MoodleData
```

---

## Étape 8 : Configurer Apache pour Moodle

Modifiez le fichier `/etc/apache2/sites-available/000-default.conf` :

```xml
<VirtualHost *:80>
    DocumentRoot /var/www/html/moodle-4.5.0
    <Directory /var/www/html/moodle-4.5.0>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>
```
Redémarrez Apache :
```bash
systemctl restart apache2
```

---

## Étape 9 : Configurer le crontab 

Il s'agit d'un processus qui va périodiquement parcourir les bases de données et les mettre à jour, en gros qui réalise de la tâche de maintenance en fond (développer un peu plus cette explication).


```bash
crontab -u www-data -e
```
Ensuite ajouter cette ligne à la fin du doc et le sauvegarder

```bash
*/2 * * * * /usr/bin/php /var/www/moodle/admin/cli/cron.php  >/dev/null
```
Redémarrer Apache :
```bash
systemctl restart apache2
```

---

## Étape 10 : Résoudre les problèmes de modules PHP

Pour corriger les erreurs comme :
- "PHP Warning : PHP Startup : Unable to load dynamic library 'mysqli.so'"
- "PHP Warning : Module \"gd\" is already loaded"

### Vérifiez les doublons dans `/etc/php/8.2/apache2/php.ini`

Supprimez ou commentez les entrées en double :
```ini
;extension=gd.so
;extension=mysqli.so
```

Désactivez et réactivez les modules si besoin :
```bash
sudo phpdismod gd
sudo phpenmod gd
```
Réinstallez les modules manquants si besoin (mais normalement non) :
```bash
sudo apt-get install --reinstall php-mysql php8.2-mysqlnd
```
Redémarrez Apache :
```bash
systemctl restart apache2
```

---

