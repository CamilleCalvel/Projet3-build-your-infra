# Création d'utilisateurs et de lignes sur le serveur FreePBX

Plan de mumérotation :
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
  - User Extension 
  - Display Name 
  - Secret
  - Password For New User


- Cliquer sur le bouton `Submit` puis `Apply Config` pour enregistrer l'utilisateur

# Configuration du logiciel SIP

- Sur les postes clients, aller denas le menu démarrer et chercher le logiciel 3CX Phone pour l'éxecuter
- Sur l'écran du SIP phone, cliquer sur `Set Account` 
- Dans la fenêtre `Accounts`, cliquer sur `New`
- Dans la fenêtre `Accounts settings`, renseigner les informations suivantes :
  - Account Name
  - Caller ID
  - Extension
  - ID
  - Password
  - I am in the office - local IP : l'adrresse IP du serveur FreePBX (ici: `172.24.0.13`)
- Cliquer sur `Ok`

# Communication entre les postes

- Sur le client 1 : Tester la communication en tappant sur le clavier du SIP le numéro et cliquer sur la touche d'appel
- Sur le client 2 : Répondre en cliaquant sur le bouton vert ou refuser l'appel en cliaquant sur le bouton rouge



