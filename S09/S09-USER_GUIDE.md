# 👤Création d'utilisateurs et de lignes sur le serveur FreePBX

Plan de numérotation :
| Poste Client | Numéro de ligne | Nom | Mot de passe |
|---------|--------|---------|---------|
| CLIWIN-02-ADM | 80100 | Petra Rossi | Azerty1* |
| CLIWIN-02-ADM | 80101 | Rosa Silva  | Azerty1* |
| CLIWIN-04-TEST | 80102 | Bruno Blanchard | Azerty1* |
| CLIWIN-04-TEST | 80103 | Dario Costa | Azerty1* |

- Se connecter en interface web à partir d'une machine cliente, sur l'adresse `172.24.0.13` du serveur FreePBX
- Dans le menu : `Connectivity > Extensions`
- Aller sur l'onglet `SIP [chan_pjsip] Extensions` et cliquer sur le bouton `+Add New SIP [chan_pjsip] Extension`
- Pour créer une ligne, renseigner les informations suivantes :
  - **User Extension** 
  - **Display Name** 
  - **Secret**
  - **Password For New User**

![Capture d'écran 2025-01-30 145238](https://github.com/user-attachments/assets/91d16679-e4ec-4a9b-a24c-3fc3775385e0)

- Cliquer sur le bouton `Submit` puis `Apply Config` pour enregistrer l'utilisateur
  
![Capture d'écran 2025-01-30 145612](https://github.com/user-attachments/assets/687f50a4-d0e5-4eac-9183-485dc019c30d)

# 📝Configuration du logiciel SIP

- Sur les postes clients, aller denas le menu démarrer et chercher le logiciel 3CX Phone pour l'éxecuter
- Sur l'écran du SIP phone, cliquer sur `Set Account` 
- Dans la fenêtre `Accounts`, cliquer sur `New`
- Dans la fenêtre `Accounts settings`, renseigner les informations suivantes :
  - **Account Name**
  - **Caller ID**
  - **Extension**
  - **ID**
  - **Password**
  - **I am in the office - local IP** : l'adrresse IP du serveur FreePBX (ici: `172.24.0.13`)
    
![Capture d'écran 2025-01-30 150545](https://github.com/user-attachments/assets/2d87346c-0145-4faa-90c3-4a3087836637)

- Cliquer sur `Ok`
  
![Capture d'écran 2025-01-30 150710](https://github.com/user-attachments/assets/6a691d7c-a212-481e-84ea-458f7dd0cb29)

# :phone: Communication entre les postes

- Sur le client 1 : Tester la communication en tappant sur le clavier du SIP le numéro et cliquer sur la touche d'appel
  
![Capture d'écran 2025-01-30 151514](https://github.com/user-attachments/assets/1c2f8db7-4e3c-4760-b643-c6d971148d7f)

- Sur le client 2 : Répondre en cliaquant sur le bouton vert ou refuser l'appel en cliaquant sur le bouton rouge

![Capture d'écran 2025-01-30 151534](https://github.com/user-attachments/assets/de41f370-38c1-46d4-b392-7d18c6091577)


