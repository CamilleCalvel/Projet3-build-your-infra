# Prérequis technique

**Serveur**:  
OS: **Windows server 2022** 
Nom: **SRV-DHCP-DNS**  
Mode d'accès réseau: **Réseau interne (intnet)** -> Allow all  
IP statique: **172.20.0.50 255.255.255.0** 
DNS Server (Preferred): **172.20.0.50**

# Installation du rôle AD

- Ouvrir **Server Manager**
- Dans le _Dashbooard_: Cliquer sur **2 Add roles and features**
- Dans _Before You Begin_: Cliquer sur **Next**
- Dans _Installation Type_: Cocher **Role-based or feature-based installation** puis cliquer sur **Next**
- Dans _Server Selection_: Selectionner un Serveur (ici: **SRV-DHCP-DNS**) puis cliquer sur **Next**
- Dans _Server roles_: Cocher **Active Directory Domain Services** puis une fenetre s'ouvre, il faut cocher **Include management tools (if applicable)**, cliquer sur **Add Features** puis sur **Next**
- Dans _Features_: Cliquer sur **Next**
- Dans _DNS Server_: Cliquer sur **Next**
- Dans _Confirmation_: Cliquer sur **Install**  
  
\
A la fin du processus d'installation apparait le message _"Configuration required. Installation on SRV-DHCP-DNS."_
- Cliquer sur **Promote this server to a domain controller**
- Dans _Deployment Configuration_: Cliquer sur **Add a new forest**, Indiquer un nom dans **Root domain name** (ici:**wilders.lan**) puis **Next**
- Dans _Domain Controller Options_:
	- Forest functional level: **Windows Server 2012 R2**
	- Domain functional level: **Windows Server 2012 R2**
	- Laisser cocher **Domain Name System (DNS) server** et **Global Catalog (GC)**
	- Entrer le mot de passe de récupération des services d'annuaire dans **Password** et sa confirmation dans **Confirm password**
	- Cliquer sur **Next**
- Dans _DNS Options_: Cliquer sur **Next**
- Dans _Additional Options_: Choisir le nom de domaine NetBIOS (ici:**WILDERS**) puis **Next**
- Dans _Path_: Laisser les noms de dossiers par défaut et Cliquer sur **Next**
- Lire la **Review Options** et passer à la suite avec **Next**
- Une vérification de la configurer est lancée, si tout est ok le message **All prerequisite checks passed successfully** s'affiche, Cliquer sur **Install** comme indiquer dans la suite du message
- A la fin de l'installation la machine redémarre automatiquement, le nom de session affiche ici: **WILDERS\Administrator**
