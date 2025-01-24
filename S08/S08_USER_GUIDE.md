<details><summary><h1>🏢 Rôles FSMO dans Active Directory<h1></summary> 

## 📊 Répartition des rôles FSMO entre les DC

### 🎯 Pourquoi répartir les rôles FSMO ?

Répartir les rôles FSMO entre plusieurs contrôleurs de domaine permet :

- **Éviter les points de défaillance uniques** : Si un seul DC détient tous les rôles, une panne pourrait bloquer le fonctionnement de l'AD.  
- **Optimiser la charge** : Certains rôles sont plus sollicités que d'autres (ex. PDC Emulator).  
- **Améliorer la résilience et la récupération** : En cas de panne, il est plus facile de transférer un rôle FSMO d'un DC à un autre.

---

### 🏷️ Les 5 rôles FSMO en détail

Active Directory possède **5 rôles FSMO**, répartis comme suit :

1. **Maître d'attribution de noms de domaine (Domain Naming Master)**  
   - Gère l'ajout et la suppression de domaines dans la forêt AD.

2. **Maître de schéma (Schema Master)**  
   - Responsable des modifications du schéma AD.

3. **Émulateur PDC (PDC Emulator)**  
   - Gère la synchronisation horaire et la compatibilité avec les anciennes versions de Windows.

4. **Maître RID (Relative ID Master)**  
   - Gère l'attribution des identifiants uniques (RIDs) pour les objets AD.

5. **Maître d'infrastructure (Infrastructure Master)**  
   - Assure la correspondance entre les objets AD provenant d'autres domaines.

---

## ⚙️ Prérequis techniques

Avant de répartir les rôles FSMO, il est nécessaire d'avoir **trois contrôleurs de domaine (DC)** sur le domaine :

- **SRVWIN-01-AD-DHCP-DNS** (GUI)  
- **SRVWIN-04-CORDC** (CLI)  
- **SRVWIN-09-DC** (CLI)  

---

## 🔄 Partager les rôles FSMO entre les DC

### 1. Vérifier les rôles FSMO actuels

Utiliser la commande suivante pour afficher la répartition actuelle des rôles FSMO :

```powershell
netdom query fsmo
```

![Capture d'écran 2025-01-23 115952](https://github.com/user-attachments/assets/953351d5-00d7-4a4c-95b2-7ef9882adec4)

Actuellement, **les 5 rôles FSMO** sont détenus par le DC suivant :

**🔹 SRVWIN-01-AD-DHCP-DNS**

---

### 2. Transférer les rôles FSMO à d'autres DC :
 Pour redistribuer les rôles FSMO vers un autre contrôleur de domaine :

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity "Nouveau-DC" -OperationMasterRole PDCEmulator, RIDMaster, InfrastructureMaster
```

---

### 3. Forcer la réplication des changements FSMO :

Une fois les rôles FSMO transférés, il est essentiel de propager les modifications à l'ensemble des contrôleurs de domaine.  
Pour cela, utiliser  la commande suivante :

```powershell
repadmin /syncall /AdeP
```

---

### Autre Méthode
- [IT-Connect : Active Directory : transfert des rôles FSMO avec NTDSUTIL](https://www.it-connect.fr/transfert-des-roles-fsmo-avec-ntdsutil/)

---
</details>  
  

<details><summary><h1>:train: Mise en place d’un VPN site-à-site entre Ekoloclast et PharmGreen<h1></summary> 

---

## :office: Architecture

<p align="center">
  <img src="https://github.com/user-attachments/assets/6d066ecc-eb3f-4284-a882-4455117414c9" alt="Architecture du VPN" width="700">
</p>

---

## :gear: Paramétrage du tunnel VPN IPsec sous PFsense

### Phase 1

#### Étapes pour ajouter une nouvelle phase 1 IPsec :

1. Accéder à **VPN > IPsec**  
2. Dans l'onglet **Tunnel**, cliquer sur :heavy_plus_sign: **Add P1**  
3. Remplir les paramètres comme décrit ci-dessous  

#### Configuration de la phase 1

**IKE Endpoint Configuration :**  
- **Interface :** Sélectionner l'interface sur laquelle le tunnel doit être monté (ex: WAN).  
- **Remote Gateway :** Entrer l'adresse IP publique du site distant.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/8924b554-3e61-4687-b5ed-fbad13417087" alt="Phase 1 Configuration" width="600">
</p>

**Phase 1 Proposal (Authentication) :**  
- **My identifier :** Identifiant unique (laisser par défaut "My IP address").  
- **Peer identifier :** Identifiant de l'autre pair (laisser par défaut "Peer IP address").  
- **Pre-Shared Key :** Cliquer sur **"Generate new Pre-Shared Key"** pour générer une clé partagée.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/20eb5955-644c-4eec-85aa-997e4196c391" alt="Authentication Configuration" width="600">
</p>

4. Cliquer sur **"Save"**, puis sur **"Apply changes"** sur la page suivante.  

---

### Phase 2

#### Ajout d’une nouvelle phase 2 au VPN :

1. Cliquer sur :heavy_plus_sign: **Show Phase 2 Entries**  
2. Cliquer sur :heavy_plus_sign: **Add P2**  

Nous allons établir une connexion entre le **VLAN12** d'Ekoloclast et le **VLAN20** de PharmGreen.

**Configuration de la phase 2 :**  
- **Local Network :** Sélectionner le réseau local joignable (ex: "VLAN12 subnet").  
- **Remote Network :** Ajouter le sous-réseau du site distant (ex: `10.15.0.32/27`).  

<p align="center">
  <img src="https://github.com/user-attachments/assets/61e14e58-bbdd-45a2-828a-9447e833a3eb" alt="Phase 2 Configuration" width="600">
</p>

3. Cliquer sur **"Save"**, puis sur **"Apply changes"** sur la page suivante.  
4. Répéter la phase 2 pour tous les LAN/VLAN à connecter.  

---

### Résultat

<p align="center">
  <img src="https://github.com/user-attachments/assets/55773f8e-8391-4661-8b42-0f4a15212182" alt="Résultat configuration" width="700">
</p>

---

## :shield: Paramétrage des règles de pare-feu IPsec sous PFsense

1. Accéder à **Firewall > Rules** dans l'onglet **IPsec**, puis ajouter des règles pour autoriser le trafic du site distant.  
2. Cliquer sur :arrow_heading_up: **Add** pour créer une nouvelle règle.  
3. Configurer la règle comme suit :  

<p align="center">
  <img src="https://github.com/user-attachments/assets/6c727cdf-f7b0-4849-b6a6-114c948b9380" alt="Firewall Rule" width="500">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ccd7262c-2274-4db9-a232-f79f3eba5058" alt="Firewall Rule Details" width="500">
</p>

4. Attendre environ une minute pour que les pare-feu négocient la connexion VPN.  

> **Remarque :** Adapter les règles selon les besoins. Ici, les règles sont volontairement larges pour des tests.  

---

## :rocket: Activation du tunnel

1. Aller dans **Status > IPsec**  
2. Dans l'onglet **Overview**, cliquer sur **"Connect P1 et P2"** pour établir la connexion.  
3. Cliquer sur :arrow_heading_up: **Show Child SA Entries**, puis sur **"Connect P2"** si nécessaire.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/391aa447-28bb-4593-ac3e-9e047f27be2e" alt="Tunnel Activation" width="700">
</p>

- La colonne **Status** indiquera si la connexion est bien établie.  

---

## :mag: Test de connexion entre Ekoloclast et PharmGreen

- Vérifier la connexion en effectuant les tests suivants :  
  - **Ping** sur l'interface WAN : `10.0.0.4` :white_check_mark:  
  - **Ping** sur une machine du VLAN20 : `10.15.0.36` :white_check_mark:  

---
</details>

    
<details><summary><h1> 👨‍🦲📂 Dossiers partagés individuels<h1></summary>  
    
Pour mettre en place des dossiers partagés sur Windows Server, il faut que ce serveur soit promu contrôleur de domaine.  
  
# :one: Création du dossier partagé individuel   
  
➡️ Ouvrir l'explorateur de fichiers, créer un dossier `Partages` (qui va contenir nos trois dossiers `Individuels` `Département` et `Service` et y créer un sous dossier `Individuels`  
  
![image](https://github.com/user-attachments/assets/0d599b3e-d0ef-47b6-8226-29749a9e54f5)  
  
![image](https://github.com/user-attachments/assets/c8a6c805-fbaf-4d60-9bdb-2639a323d314)  
   
![image](https://github.com/user-attachments/assets/c30ba37a-7103-4ada-9147-ea2a3d1faf21)  
  
➡️ Dans les permissions, supprimer "Everyone" de la liste et ajouter `Administrator` et lui accorder un niveau de permissions en **Full Control**   
  
![image](https://github.com/user-attachments/assets/05fb93c9-07b4-4a6e-b079-c1289c71d7ad)  
  
➡️ Ajouter également les utilisateurs authentifiés (`Authenticated Users`) et leur accorder également un niveau de permissions en **Full Control**  
  
![image](https://github.com/user-attachments/assets/c6fb2c7d-e089-4e94-849e-2ede3d8639c8)  
  
➡️ Cliquer sur `Apply` puis `OK`  
  
➡️ On voit désormais que le dossier est bien partagé sur le réseau, et son chemin est précisé :  
  
![image](https://github.com/user-attachments/assets/239fb5c6-3411-4039-8df6-889547745a5f)  
  
# 2️⃣ Configuration des droits NTFS  
  
➡️ Toujours dans les propriétés du dossier, se rendre dans l'onglet `Security` puis cliquer sur `Advanced`  
  
![image](https://github.com/user-attachments/assets/e2f81193-00dc-4b1c-9c3d-50993d1f31ba)  
  
➡️ Cliquer sur `Disable inheritance` pour supprimer les permissions héritées et configurer nos permissions personnalisées  
  
➡️ Cliquer sur `Add` puis sur `Select a principal`, et suivre les étapes ci-dessous :  
  
![image](https://github.com/user-attachments/assets/4fe6a788-6c64-4299-aa74-6e8ca156eb04)  
  
➡️ Ajouter `CREATOR OWNERS`, `SYSTEM`, `Administrator`, `Authenticated Users` et leur donner un contrôle total  
  
![image](https://github.com/user-attachments/assets/c9b8c230-bbf3-45cf-a8a0-f88a64cec569)  
  
➡️ Appliquer les changements et fermer la fenêtre  
  
# 3️⃣ Création d'une GPO d'automatisation de création de dossiers individuels  
  
➡️ Server Manager -> Tools -> Group Policy Management  
  
![image](https://github.com/user-attachments/assets/206e2a06-8274-4d32-abe2-45a281c84213)  
  
➡️ Donner un nom à la GPO, par exemple "Raccourci et mappage lecteurs individuels"  
  
➡️ Faire un clic droit sur la GPO créée puis `Edit...`  
  
![image](https://github.com/user-attachments/assets/e55ec568-595a-4be9-bbd4-bf5e6257484a)  
  
![image](https://github.com/user-attachments/assets/057e703e-dd76-4ee3-b745-6fc30add3723)  
  
➡️ Spécifier le chemin de notre dossier partagé, dans notre cas, c'est `\\SRVWIN-08-SHARE\Individuels$` et rajouter à la fin du chemin `%LogonUser%`
  
➡️ Dans l'onglet `Common`, cocher la case `Run in logged-on user's security context (user policy option)`  
  
➡️ Cliquer sur `Apply` puis `OK`  
  
➡️ Aller dans `Folders` sur le menu déroulant de gauche, faire un clic droit puis `New > Folder`  
  
![image](https://github.com/user-attachments/assets/3b04d466-8d11-42bd-bff4-be7c450d000c)  
  
➡️ Décocher la case `Archive` puis dans l'onglet `Common`, cocher la case `Run in logged-on user's security context (user policy option)`  
  
![image](https://github.com/user-attachments/assets/64b02ece-4a52-49e0-bd1d-5a19a854efcb)
  
# 4️⃣ Création d'un raccourci sur le bureau [optionnel]  
  
➡️ `Shortcuts` -> `New > Shortcut`  
  
![image](https://github.com/user-attachments/assets/27e1e9a4-9306-49ae-ad13-badf4040e1f4)  
  
➡️ Dans l'onglet `Common`, cocher la case `Run in logged-on user's security context (user policy option)`  
    
➡️ Cliquer sur `Apply` puis `OK`    
  
![image](https://github.com/user-attachments/assets/97435908-3cab-477c-8e06-c8d5c6e25b51)  
  
➡️ Ouvrir un invite de commande et taper `gpupdate /force` pour enregistrer la nouvelle GPO  
  
![image](https://github.com/user-attachments/assets/db001645-a159-40a4-a093-1a4715963b3d)

</details>

