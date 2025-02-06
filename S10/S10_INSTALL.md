# Installation et configuration d'un serveur de messagerie (SMTP) iRedMail

## ✔️ Prérequis et préparation de Debian 12

### 1.1. Préparation du serveur iredmail :
- Mise à jour du système :
```bash
sudo apt update && sudo apt upgrade -y
```
 - Configuration du nom
   Sous Debian/Ubuntu Linux, le nom d'hôte est défini dans deux fichiers : /etc/hostname et /etc/hosts

    - /etc/hostname: nom d'hôte court, pas FQDN  
    `mail `
    - /etc/hosts:  indiquer le nom d'hôte FQDN comme premier élément. 
    `172.24.0.8 localhost mail.ekoloclast.local`

- Redémarrer la machine et Vérifier le nom d'hôte FQDN
  ```bash
  hostname -f  
  mail.ekoloclast.local
  ``` 

### 1.2. Préparation du server DNS :

#### Enregistrement MX:

- Clic droit sur votre domaine -> `Nouvel enregistrement...`
- Choisir `Échangeur de courrier (MX)` et cliquer sur `Créer un enregistrement...`
- Dans `Nom de l'hôte de l'échangeur de courrier`, entrer le nom d'hôte de votre serveur iredmail (ici: mail)
- Dans `Priorité`, entrer une valeur faible (ex: 10)
- Cliquer sur `OK`  
<p align="center">
<img src="https://github.com/user-attachments/assets/dbc7df65-deaa-4cd9-8c1e-47d0135c6176" alt="Pictures" width="350" >
</p>

#### Enregistrement A:

- Clic droit sur votre domaine -> `Nouvel enregistrement...`
- Choisir `Hôte (A)` et cliquer sur `Créer un enregistrement...`
- Dans `Nom`, entrer le nom d'hôte de votre serveur Iredmail (ici: mail)
- Dans `Adresse IP`, entrer l'adresse IP de votre serveur iredmail
- Cliquer sur `OK`  

<p align="center">
<img src="https://github.com/user-attachments/assets/4706c5cf-37b5-4f22-8f95-61817e83004a" alt="Pictures" width="350" >
</p>

## 📥 Téléchargement et installation d'iRedMail

### Installation :

```bash
# Téléchargement de la dernière version stable d’iRedMail depuis la page officielle
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.7.2.tar.gz
# Extraction de l'archive tar 
tar xvf 1.7.2.tar.gz
# Déplacment dans le répertoire iRedMail-1.7.2
cd iRedMail-1.7.2
# Lancement du script d'installation d'iRedMail
bash iRedMail.sh
```

### Configuration :

- Lancement de la configuration  

<p align="center">
<img src="https://github.com/user-attachments/assets/a4d8adf3-a306-4af4-bbee-47f8abde19db" alt="Pictures" width="600" >
</p>

- Choisir l'emplacement de stockage des emails (par défaut /var/vmail)  

<p align="center">
<img src="https://github.com/user-attachments/assets/0c3ac600-ff7a-4bd3-8e9e-cc950b482a44" alt="Pictures" width="600" >
</p>


- Choisir le Serveur web  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/4f609f6f-e8a5-4c77-990d-4d2cb92ea351" alt="Pictures" width="600" >
</p>

- Chosir le Backend: OpenLDAP  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/22debabc-5426-4076-8d32-a7c70b46e602" alt="Pictures" width="600" >
</p>

- Renseigner le premier domaine: ekoloclast.local  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/f2dcff1b-ddd3-4011-be7f-88d9079e1d98" alt="Pictures" width="600" >
</p>

- Renseigner le mot de passe administrateur de la base de donnée  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/238ed2bf-eb6f-4ece-81cc-0612d7426c9a" alt="Pictures" width="600" >
</p>

- Renseigner le nom de domaine du premier mail: ekoloclast.local  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/c97aeeb9-b1c3-4911-a9e5-91aec50c9462" alt="Pictures" width="600" >
</p>

- Renseigner le mot de passe administrateur du premier mail  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/af1477e2-89b8-4e7b-bfb3-caf8bd0784ff" alt="Pictures" width="600" >
</p>

- Composant optionnel, cocher toutes les options  
  
<p align="center">
<img src="https://github.com/user-attachments/assets/b7b55b9e-2181-4a11-a3fc-40a4e5a83b32" alt="Pictures" width="600" >
</p>

- Vérifier les options et confirmer  
 
- Erreur lors de l'installation, lancer la commande :
```bash
dpkg --configure -a
```
- Relancer le script 
```bash
bash iRedMail.sh
```
- Taper sur `y` pour continuer l'installation  
Il installera et configurera automatiquement les packages requis.

<p align="center">
<img src="https://github.com/user-attachments/assets/e75abc78-6ba4-442a-ba56-c249707c92ad" alt="Pictures" width="600" >
</p>

- Rentrer 2 fois `y` pour finir l'installation
  
<p align="center">
<img src="https://github.com/user-attachments/assets/da376980-eece-4345-b3c2-c05713356349" alt="Pictures" width="600" >
</p>

## ⚙️  Configuration initiale d'iRedMail

Depuis un client windows ou ubuntu :

- Accès à l'administration: `https://mail.tssr.lab/iredadmin`
- Connexion: `postmaster@ekoloclast.local` et le mot de passe.

<p align="center">
<img src="https://github.com/user-attachments/assets/2525c5eb-8a44-4642-ae99-d569451fdf90" alt="Pictures" width="600" >
</p>

- Configuration:
  - Vérifier la configuration du domaine existant : Nom de domaine, adresse

## 🧑‍💻 Gestion des domaines et des comptes

### Créer un compte utilisateur sur le domaine :

- Cliquer sur le bouton `Ajouter` puis utilisateur.

- Exemple de configuration :
  - **Email**: utilisateur1@ekoloclast.local
  - **Password**: Un mot de passe fort (au moins 8 caractères avec des lettres majuscules et minuscules, des chiffres et des symboles).
  - **Name**: Utilisateur Un
  - **Quota**: 1024 (quota de 1 Go)
  - **Active**: Cocher la case pour activer le compte.
  - Cliquer sur `Ajouter` pour créer le compte utilisateur.
    
<p align="center">
<img src="https://github.com/user-attachments/assets/3b31f7b3-ec2a-4dc5-9995-ca24c9c86737" alt="Pictures" width="600" >
</p>

## 📨 Accès à la messagerie via webmail

Webmail: `https://mail.ekoloclast.local/mail` (Roundcube).

- Se connecter avec un utilisateur
  
<p align="center">
<img src="https://github.com/user-attachments/assets/e3524584-d758-47bc-93fc-ed765c0241de" alt="Pictures" width="400" >
</p>

- Tester l'envoi de mail entre 2 utilisateurs du domain ekoloclast.local
  
<p align="center">
<img src="https://github.com/user-attachments/assets/7ceb2775-dc89-42ef-a5ca-d14e10f9f7e4" alt="Pictures" width="700" >
</p>

---
