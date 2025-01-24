                                                                                                                                                                                                                                                # Configuration de la machine et déploiement de WSUS

## Configurer la nouvelle machine

Pour configurer la machine, changez son nom pour qu'il corresponde à la convention de nommage et intégrez-la au réseau à l'adresse `172.24.0.10` :

```powershell
Rename-Computer -NewName "SRVWIN-07-WSUS" -Force -Restart
```

---

## Installer un rôle

Pour installer un rôle, procédez comme suit :

1. Utilisez le **Server Manager** pour installer le rôle **Windows Server Update Services**.
2. Validez les fonctionnalités supplémentaires qui seront ajoutées automatiquement.
3. Sélectionnez **WID Connectivity** et **WSUS Service**.
4. Indiquez le dossier créé pour l'emplacement de stockage des mises à jour.  
   Exemple : le dossier se trouve à la racine du disque C : `C:/WSUS`.
![Proj3_WSUS_installRole](https://github.com/user-attachments/assets/1bbf67ee-69d4-4a07-ab95-d487dba61986)

> **Note** : L'installation peut être longue et se termine par une "post-deployment configuration", signalée par un drapeau jaune dans l'interface.

Une fois l'installation terminée, redémarrez le serveur.

---

## Configurer WSUS en tant que service

1. Dans le volet de gauche, accédez à **WSUS**.

### Si l’assistant de configuration est lancé :

1. Décochez la case **Yes, I would like to join the Microsoft Update Improvement Program**.
2. Laissez sélectionnée la case **Synchronize from Microsoft Update**.
3. Ne configurez pas de proxy.
4. Cliquez sur **Start Connecting**. 
> Cette action peut être longue (entre 10 et 20 minutes).  Si cela ne fonctionne pas, vérifiez la connexion internet.
5. Sélectionnez les langues **English** et **French**.
6. Dans la fenêtre suivante, sélectionnez les produits pour lesquels vous souhaitez des mises à jour, comme **Windows 10** et les **serveurs**.
7. Pour les classifications, laissez les choix par défaut.
8. Configurez 4 synchronisations par jour, à partir de 2h.
9. Cochez la case **Begin initial synchronization** et cliquez sur **Finish**.

Pour voir l'état de la synchronisation, se rendre dans Tools et choisir le "Update Services". 

> Et là ca prend vraiment longtemps ...

Aller dans **Options** puis **Automatic Approvals**
Dans l'onglet **Update Rules** , cocher **Default Automatic Approval Rule**

![Proj3_WSUS_config_auto_approvals](https://github.com/user-attachments/assets/cb2d4812-64ee-4059-89f0-67b684688584)

> Cela permet d'approuver automatiquement les mises à jour suivant les règles de la section Rule Properties se trouvant en dessous. Par défaut, une mise à jour Critique ou de Sécurité sont Approuvées sur tout les ordinateurs.

Cliquer sur **Run Rules** puis sur **Apply** et **OK**



> Avant d'appliquer des mises à jour à des OU, il faut répartir les machines dans les bons OU, du moins celles correspondant à Clients, Serveurs, Domaine Controller
> Dans notre cas nous avons pour l'instant 2 domaines controllers : AD-DH et Core DC (potentiellement le serveur 09 CoreDC)
> 1 Serveurs Windows : WSUS
> 1 machine client : CLIWIN-04-Test(DSI)
> Les réels noms des OU concernées pour les mise à jour WSUS : * pour les DC = Domain Controllers (dans ekoloclast). 
Paris.ekoloclast > Ordinateurs > Windows-server-2022 = Servers
Paris.ekoloclast > Utilisateurs = Clients


Ce tuto IT-connect en parle très bien : https://www.it-connect.fr/chapitres/lier-les-machines-du-domaine-active-directory-serveur-wsus/

Après suivi du mix Atelier-IT connect : Les GPO sont appliquées en synchronicité avec les groupes WSUS , on a pu faire vérification avec commandes PS sur un domain controller (alias le GUI AD-DH), cependant pas réussi à faire le gpupdate /force sur la machine client DSI/Test, il semble que celle-ci ne parvient pas à ping le WSUS.

En résumé, ce qu'il reste à formuler comme étapes après les sync sur WSUS : 


File and Printer Sharing (echo request ICMPIPv+) dans InboundRules du Firewall

* paramétrer WSUS computers sur group policies
* Créer 3 groupes de computers sur WSUS Clients, Servers et DC
* Ajouter WSUS à l'AD
* Ajouter WSUS dans les serveurs AD disponibles depuis le main server GUI AD-DH
* Créer de nouvelles GPO avec les politiques Windows Update définies dans l'Atelier.
* La politique Win Update appelée "Enable client-side targeting" doit renvoyer à chaque fois à un groupe spécifique de WSUS
* Appliquer les GPO créés aux machines concernées considérées comme Clients, Servers, DC.
* Vérifier que ces GPO sont opérationnelles en appliquant gpupdate /force sur ces quelques machines et récupérer les résultats.
* On peut démontrer l'intérête des groupes WSUS en suivant la partie 4 de l'Atelier, sauf que dans notre cas nous avons coché tellement peu de Maj à synchroniser que nous n'en avons aucune apparaissant dans le panel Updates de WSUS. (Afin de limiter les pb d'espace).


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
!! BROUILLON !! ET CONSEILS DE CHATGPT EN ATTENDANT LA SYNCHRONISATION

> d'après d'autres requêtes auprès de l'IA, il faut bien intégrer la machine WSUS dans l'AD avant de passer à la suite, ce qui semble logique pour la gestion des GPO.
> Pour cela il faut renommer le nom du domaine de la machine WSUS (Settings > System > Advanced system settings )


Lier les groupes WSUS à l'Active Directory (AD) pour gérer les mises à jour en fonction des Unités d'Organisation (OU) implique plusieurs étapes. Voici une explication claire et détaillée :

---

### 1. Préparer le serveur WSUS et Active Directory

#### Sur le serveur WSUS :  
- Assurez-vous que WSUS est correctement configuré et synchronisé avec Microsoft Update.
- Créez des **groupes WSUS** qui correspondent aux différentes catégories d'appareils (clients, serveurs, DC). Par exemple :
  - **Clients**
  - **Serveurs**
  - **Domain Controllers (DC)**

#### Sur le serveur Active Directory :
- Organisez les appareils dans des **Unités d'Organisation (OU)** spécifiques en fonction de leur rôle. Par exemple :
  - `OU=Clients`
  - `OU=Servers`
  - `OU=DomainControllers`

---

### 2. Configurer la stratégie de groupe (GPO)

Pour lier WSUS aux appareils via l'Active Directory, utilisez des **GPO** (Group Policy Objects) pour spécifier les paramètres WSUS et définir les groupes de mise à jour.

#### Étapes :
1. **Créer une GPO pour WSUS** :  
   - Ouvrez la console **Group Policy Management**.
   - Associez une nouvelle GPO aux OUs concernées (`Clients`, `Servers`, `DomainControllers`).

2. **Configurer les paramètres WSUS dans la GPO** :
   - Allez dans :  
     `Computer Configuration > Administrative Templates > Windows Components > Windows Update`.

   - **Configurer le serveur WSUS** :
     - Activez **Specify intranet Microsoft update service location**.
     - Définissez l'URL du serveur WSUS. Par exemple :
       - Serveur de mise à jour : `http://wsusserver:8530`
       - Serveur de statistiques : `http://wsusserver:8530`

   - **Affecter les groupes WSUS** :
     - Activez **Enable client-side targeting**.
     - Entrez le nom du groupe WSUS auquel les appareils de cette OU appartiennent (par exemple, `Clients`, `Servers`, ou `Domain Controllers`).

3. **Appliquer les stratégies** :  
   - Liez chaque GPO à l'OU correspondante pour que les appareils reçoivent les paramètres WSUS appropriés.

---

### 3. Gérer les mises à jour dans WSUS

#### Sur le serveur WSUS :
1. **Associer les appareils aux groupes WSUS** :
   - Activez le **client-side targeting** dans les paramètres WSUS. Cela permet aux appareils de s'auto-associer aux groupes WSUS définis dans la GPO.

2. **Configurer les règles d'approbation des mises à jour** :
   - Allez dans la console WSUS et créez des règles d'approbation automatique ou manuelle pour chaque groupe :
     - **Clients** : Approuvez les mises à jour critiques et de sécurité.
     - **Serveurs** : Approuvez uniquement les mises à jour validées et les mises à jour de sécurité.
     - **Domain Controllers (DC)** : Approuvez avec précaution, en testant les mises à jour avant de les déployer.

---

### 4. Superviser et ajuster

1. **Surveiller les rapports WSUS** :  
   - Utilisez la console WSUS pour vérifier quels appareils reçoivent les mises à jour et identifier les éventuels problèmes.

2. **Tester les mises à jour avant le déploiement** :
   - Créez un sous-groupe WSUS pour le test avant de propager les mises à jour aux groupes principaux.

3. **Ajuster les GPO et les règles WSUS** :  
   - En cas de changement dans la structure de l'AD ou des besoins spécifiques, mettez à jour les GPO et les règles WSUS.

---

### Résumé

En configurant **WSUS** pour travailler avec l'**AD** à l'aide de GPO, vous pouvez :
- Associer automatiquement les appareils aux groupes WSUS.
- Différencier les mises à jour par rôle (Clients, Serveurs, DC).
- Gérer les mises à jour efficacement grâce à une organisation claire basée sur les OU.

Cela garantit un contrôle précis des mises à jour tout en limitant les interruptions liées aux mises à jour inappropriées pour certains rôles.


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
