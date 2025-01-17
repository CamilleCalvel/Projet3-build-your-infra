# 📧 Installation d'un Serveur de Messagerie SMTP avec Postfix et Dovecot

## 🛠️ 1. Préparer le Serveur DNS

### 📂 Ouvrir la Console DNS
1. Ouvrir le **Gestionnaire de serveur** (Server Manager).
2. Cliquer sur **Outils** > **DNS** pour ouvrir la console de gestion DNS.

### ➕ Ajouter un Enregistrement A (Address Record)
Lier le sous-domaine `mail` à l'adresse IP du serveur mail Debian.

1. Aller dans **Zones de recherche directes** > sélectionner la zone de domaine `ekoloclast.local`.
2. Faire un clic droit dans la zone > **Nouvel hôte (A ou AAAA)**.
   - **Nom** : `mail`
   - **Adresse IP** : `172.24.0.8`
3. Cliquer sur **Ajouter un hôte**.

### 📬 Ajouter un Enregistrement MX (Mail Exchanger)
Diriger les emails vers le serveur mail.

1. Dans la zone DNS `ekoloclast.local`, faire un clic droit > **Autres nouveaux enregistrements**.
2. Sélectionner **Enregistrement MX** > **Créer un enregistrement**.
   - **Nom** : *(laisser vide)*
   - **Nom du serveur de messagerie** : `mail.ekoloclast.local`
   - **Priorité** : `10`
3. Cliquer sur **OK**.

### ✅ Vérifier la Configuration
1. Redémarrer le service DNS : **Outils** > **Services** > redémarrer **DNS Server**.
2. Vérifier les enregistrements depuis un poste client :
   ```bash
   nslookup mail.ekoloclast.local
   nslookup -type=MX ekoloclast.local
   ```

## 📦 2. Installer et Configurer Postfix

### 🔧 Installer Postfix
- Installer Postfix et ses dépendances :
```bash
apt-get install postfix postfix-mysql libsasl2-modules sasl2-bin
```

#### 📝 Configurer Postfix
- **Étape 1** : Choisir **Site Internet**.
<p align="center">
<img src="https://github.com/user-attachments/assets/034837a4-bcf8-4808-aa41-14d5f97f435c" alt="Pictures" width="600" >
</p>

- **Étape 2** : Renseigner le nom de domaine du serveur mail.
<p align="center">
<img src="https://github.com/user-attachments/assets/94fb5c35-42a8-4940-8e05-808ec2069c1c" alt="Pictures" width="900" >
</p>

### 🌐 Installer PostfixAdmin
PostfixAdmin permet de gérer les comptes mails via une interface web.

```bash
apt-get install postfixadmin
```

#### 📂 Configurer la Base de Données
- **Étape 3** : Choisir **Oui** pour configurer la base de données.
<p align="center">
<img src="https://github.com/user-attachments/assets/a871a6d3-48f9-4de0-969b-c442d8e5ec2a" alt="Pictures" width="900" >
</p>

- **Étape 4** : Renseigner et conserver le mot de passe de la base de données.
<p align="center">
<img src="https://github.com/user-attachments/assets/8d500ba1-db2c-4b1a-9d27-757a4744bef4" alt="Pictures" width="900" >
</p>

#### 🌍 Configurer PostfixAdmin dans Apache
- Créer un raccourci vers PostfixAdmin :
```bash
sudo ln -s /usr/share/postfixadmin /var/www/postfixadmin
```

#### 🔐 Installer et configurer UFW (pare-feu)
```bash
# Installer UFW (Uncomplicated Firewall)
apt install ufw
# Activer UFW pour commencer à filtrer les connexions réseau
ufw enable
# Autoriser le trafic HTTP (port 80) à travers le pare-feu
sudo ufw allow 80/tcp
# Vérifier l'état d'UFW pour s'assurer qu'il est actif
systemctl status ufw
# Redémarrer le serveur web Apache pour appliquer les modifications
sudo systemctl restart apache2
```

## 🔑 3. Configurer PostfixAdmin

### 🔒 Générer le Setup Password
1. Depuis une machine distante, accéder à l'interface de configuration depuis un navigateur: `http://<IP_ou_nom_de_domaine_server_mail>/postfixadmin/public/setup.php`
2. Générer le **setup_password** et le copier.
<p align="center">
<img src="https://github.com/user-attachments/assets/1413571d-9a40-4a20-8844-72e6a37b8573" alt="Pictures" width="900" >
</p>

3. Copier le hash généré dans le fichier config.inc.php de PostfixAdmin du server de mail :
   ```bash
   nano /etc/postfixadmin/config.inc.php
   ```
4. Modifier la ligne suivante avec le hash généré précédemment: 
   ```php
   $CONF['setup_password'] = 'votre_hash';
   ```
5. Rafraîchir la page setup.php et se connecter avec le mot de passe.
<p align="center">
<img src="https://github.com/user-attachments/assets/2d0ccf6b-e17f-4cd3-9d50-5dfe3ce1ea89" alt="Pictures" width="900" >
</p>

### 👤 Créer le Compte Super Admin
1. Accéder à la section **Add Superadmin Account** :
   - **Setup password** : `Azerty12*`
   - **Administrateur** : `ekoloclast@gmail.com`
   - **Mot de passe** : `Azerty1*`

### ➕ Ajouter un Nom de Domaine
1. Se connecter à : `/postfixadmin/public/login.php`
2. Accéder à **Liste des domaines** > **Ajouter un domaine**.
<p align="center">
<img src="https://github.com/user-attachments/assets/de1179ab-0331-408a-9ba1-57fea719e587" alt="Pictures" width="400" >
</p>

3. - Une fois les différents champs complétés, cliquer sur **Ajouter un domaine**.


