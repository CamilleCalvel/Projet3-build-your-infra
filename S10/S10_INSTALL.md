# Installation et configuration d'un serveur de messagerie iRedMail et client Thunderbird

## ✔️ Prérequis et préparation de Debian 12

### 1.1. Préparation du serveur iredmail :
Mise à jour du système:
```bash
sudo apt update && sudo apt upgrade -y
```
Configuration du nom d'hôte: Remplacez mail.tssr.lab par le FQDN de votre serveur.

```bash
sudo hostnamectl set-hostname mail
echo "mail.tssr.lab" | sudo tee /etc/hostname
```

Configuration du fichier `/etc/hosts`:
172.20.0.3  localhost mail.tssr.lab

- Redémarrer la machine

### 1.2. Préparation du server DNS :

#### Enregistrement MX:

- Clic droit sur votre domaine -> "Nouvel enregistrement...".
- Choisir "Échangeur de courrier (MX)" et cliquer sur "Créer un enregistrement...".
- Dans "Nom de l'hôte de l'échangeur de courrier", entrer le nom d'hôte de votre serveur iredmail (ex: mail).
- Dans "Priorité", entrer une valeur faible (ex: 10).
- Cliquer sur "OK".

![Capture d'écran 2025-02-06 100503](https://github.com/user-attachments/assets/dbc7df65-deaa-4cd9-8c1e-47d0135c6176)


#### Enregistrement A:

- Clic droit sur votre domaine -> "Nouvel enregistrement...".
- Choisir "Hôte (A)" et cliquer sur "Créer un enregistrement...".
- Dans "Nom", entrer le nom d'hôte de votre serveur Iredmail (ex: mail).
- Dans "Adresse IP", entrer l'adresse IP de votre serveur iredmail.
- Cliquer sur "OK".

#### Enregistrement CNAME (optionnel):

- Clic droit sur votre domaine -> "Nouvel enregistrement...".
- Choisisser "Alias (CNAME)" et cliquer sur "Créer un enregistrement...".
- Dans "Nom d'alias", entrer un alias pour votre serveur iredmail (iredmail)).
- Dans "Nom de domaine complet de la cible", entrer le nom de domaine complet de votre serveur iredmail (ex: mail.tssr.lab).
- Cliquer sur "OK".

## 📥 Téléchargement et installation d'iRedMail

### Installation :

```bash
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.7.2.tar.gz
tar xvf 1.7.2.tar.gz
cd iRedMail-1.7.2
bash iRedMail.sh
```

### Configuration :

Stockage des emails: Choisissez l'emplacement (par défaut /var/vmail).
Serveur web: Nginx .
Backend: OpenLDAP.
Premier domaine: ekoloclast.local
Mot de passe administrateur de la base de donnée: Fort et sécurisé.
Nom de domaine du premier mail: ekoloclast.local
Mot de passe administrateur du premier mail: Fort et sécurisé.
Composant optionnel cochez toutes les options
Confirmation: Vérifiez les options et confirmez.
- Erreur lors de l'installation 
```bash
dpkg --configure -a
```
- Relancer le script 
```bash
bash iRedMail.sh
```
- Taper sur y pour continuer l'installation 
Il installera et configurera automatiquement les packages requis.

## ⚙️  Configuration initiale d'iRedMail

Depuis un client windows ou ubuntu :

- Accès à l'administration: https://mail.tssr.lab/iredadmin
- Connexion: Avec postmaster@ekoloclast.local et le mot de passe.

- Configuration:
  - Vérifier la configuration du domaine existant : Nom de domaine, adresse

## 🧑‍💻 Gestion des domaines et des comptes
Cette étape vous permet de créer des comptes utilisateurs sur votre domaine.

### Créer un compte utilisateur :

- Cliquer sur le bouton "Ajouter" puis utilisateur.

- Exemple de configuration :
  - Email: utilisateur1@ekoloclast.local
  - Password: Un mot de passe fort (au moins 8 caractères avec des lettres majuscules et minuscules, des chiffres et des symboles).
  - Name: Utilisateur Un
  - Quota: 1024 (quota de 1 Go)
  - Active: Cochez la case pour activer le compte.
  - Cliquez sur "Add" pour créer le compte utilisateur.

![Capture d'écran 2025-02-06 121751](https://github.com/user-attachments/assets/1f209632-2b83-45be-b9c3-64fc92e257cb)

## 📨 Accès à la messagerie via webmail

Webmail: https://mail.ekoloclast.local/mail (Roundcube).

- Se connecter avec un utilisateur
  
![Capture d'écran 2025-02-06 122714](https://github.com/user-attachments/assets/e3524584-d758-47bc-93fc-ed765c0241de)

- Tester l'envoi de mail entre 2 utilisateurs du domain ekoloclast.local
  
![Capture d'écran 2025-02-06 123302](https://github.com/user-attachments/assets/7ceb2775-dc89-42ef-a5ca-d14e10f9f7e4)

