# :one: Mise en place de plages d'adresses IP sur DHCP  

Mettre en place une plage d'adresse IP permet d'attribuer automatiquement une adresse IP faisant partie du réseau sur lequel se trouve la machine concernée.  
Voici un mode d'emploi qui détaille les étapes de la mise en place des plages d'adresses IP sur le serveur DHCP.  

## A - Créer une plage d'adresse IP (Scope)  

- Se rendre sur le `Server Manager` -> `Tools` -> `DHCP`
- Faire un clic droit sur `IPv4` -> `New Scope` :
  SCREEN NEWSCOPE
  
- Cliquer sur `Next` jusqu'à arriver à la fenêtre `Scope Name` ci dessous :
  SCREEN NOM

- Une fois le nom choisi, cliquer sur `Next` pour définir la plage d'adresses IP :
  SCREEN RANGE

- Cliquer sur `Next` jusqu'à arriver à la fenêtre `Configure DHCP Options`
- Laisser la case `Do you want to configure the DHCP otpions for this scope now?` cochée par défaut `Yes)`
  SCREEN CONFIGUREDHCP

- Cliquer sur `Next` jusqu'à arriver à la fenêtre `Router (Default Gateway)`
- Entrer l'adresse passerelle pour le réseau que l'on est en train de configurer (pour un réseau `172.24.1.0`, mettre l'adresse `172.24.1.254`)
  SCREEN ROUTER
  
- Cliquer sur `Next`, on arrive sur la fenêtre de configuration du DNS et du nom de domaine :  
  • `Parent domain : ekoloclast.local`    
  • `IP address : mettre 8.8.8.8 et 172.24.0.1`. Une fois ces deux adresses entrées, cliquer sur l'adresse `172.24.0.1` et cliquer sur `Up`.  
  SCREEN DOMAINNAMEDNS

- Cliquer sur `Next` jusqu'à arriver à la fenêtre `Activate Scope`. Cocher `Yes, I want to activate this scope now`.
  SCREEN ACTIVATESCOPE
  
- Cliquer sur `Next` jusqu'à terminer l'installation
