# :train: Mise en place d’un VPN site-à-site entre Ekoloclast et PharmGreen

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

