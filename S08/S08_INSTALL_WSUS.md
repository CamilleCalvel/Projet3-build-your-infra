# Déploiement de WSUS

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

Pour voir l'état de la synchronisation, se rendre dans **Tools** et choisir le **Update Services**. 

> Et là ça prend vraiment longtemps si on a oublié de décocher des maj non souhaitées pour la démonstration...

Aller dans **Options** puis **Automatic Approvals**.  
Dans l'onglet **Update Rules**, cocher **Default Automatic Approval Rule**.

![Proj3_WSUS_config_auto_approvals](https://github.com/user-attachments/assets/cb2d4812-64ee-4059-89f0-67b684688584)

> Cela permet d'approuver automatiquement les mises à jour suivant les règles de la section **Rule Properties** se trouvant en dessous. Par défaut, une mise à jour Critique ou de Sécurité sont Approuvées sur tous les ordinateurs.

Cliquez sur **Run Rules** puis sur **Apply** et **OK**.

### Permettre à WSUS l'application de GPO depuis l'AD sur ses groupes

* Se rendre dans le Panel de gauche de **WSUS**.
* Choisir l'onglet **Options** et se rendre dans **Computers**.
* Cocher **User Group Policy or registry settings on computers**.


![WSUSPanel_computerConfigs](https://github.com/user-attachments/assets/9402e912-7819-4bdb-a84e-c0f1744ee62c)


### Création de groupes dans WSUS

* Dans le panel de gauche toujours, se rendre dans **Computers** > **All Computers**.
* Dans le panel de droite choisir **Add Group**.
* Et créer les 3 types de groupe **Grp-Clients** / **Grp-Servers** / **Grp-DC**.

![WSUSPanel_AddComputerGroups](https://github.com/user-attachments/assets/36b0fcd5-2aa0-446c-8d22-64c72aa491ec)


### Ajouter le serveur WSUS à l'AD

* Côté machine dédiée WSUS, se rendre dans **Settings** > **System** > **Advanced system settings** et changer le nom de domaine **ekoloclast.local**.
* Côté machine serveur principal **SRVWIN-01-AD-DH**, ajouter un nouveau serveur et entrer le nom **SRVWIN-07-WSUS**.

## Créer les GPO Windows Update pour les différentes OU concernées

### Configurer les GPO

* Sur l'AD, créer une GPO **Computer-WSUS-Clients**.
* Aller dans **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **Windows update**.
* Aller dans **Specify intranet Microsoft update service location**, qui indiquera où est le serveur de mise à jour.
  * Cocher **Enabled**.
  * Dans les options, pour les 2 premiers champs, mettre l'URL avec le nom du serveur sous sa forme FQDN, ajouter le numéro du port 8530. Dans notre cas il s'agit de **http://172.24.0.10:8530**.
  * Valider la configuration.

![WSUS_GPO_Update1](https://github.com/user-attachments/assets/9c7317fa-6e67-440f-903d-1007549b7bfa)


* Aller dans **Do not connect to any Windows Update Internet locations** qui bloque la connexion aux serveurs de Microsoft.
  * Cocher **Enabled** et valider la configuration.
   
* Aller dans **Configure Automatic Updates**.
  * Cocher **Enabled**.
  * Dans les options mettre :
    * Dans **Configure automatic updating** sélectionnez **4- Auto Download and schedule the install**.
    * Dans **Scheduled install day** mettre **0 - Every day**.
    * Dans **Scheduled install time** mettre **09:00**.
    * Cocher **Every week**.
    * Cocher **Install updates for other Microsoft Products**.
    * 
![WSUS_GPO_Update2](https://github.com/user-attachments/assets/42e44646-74df-4722-a566-0be0ea6e47e5)


* Aller dans **Enable client-side targeting** qui fait la liaison avec les groupes créés dans WSUS.
  * Cocher **Enabled**.
  * Dans les options, mettre le nom du groupe WSUS pour les ordinateurs cible à savoir **Grp-Clients** par exemple.
  * Valider la configuration.
* Aller dans **Turn off auto-restart for updates during active hours** qui permet d'empêcher les machines de redémarrer après l'installation d'une mise à jour pendant leurs heures d'utilisations.
  * Cocher **Enabled**.
  * Dans les options, mettre (par exemple) **8 AM - 6 PM**.

![WSUS_GPOClientConfig_Resume2](https://github.com/user-attachments/assets/50000512-e3f5-4c96-b1d7-51ab66c132f3)



### Répartir les GPO

- Une fois cette GPO **Computer-WSUS-Clients** créée, copier et coller la même GPO dans **Group Policies Objects** et la renommer une fois pour **Computer-WSUS-Servers** et une deuxième fois pour **Computer-WSUS-DC**.  
- Retourner dans l'édition des GPO pour **Servers** et **DC** et modifier dans **Enable client-side targeting** et changer le nom des groupes WSUS en fonction.  
- Appliquer chacune de ces GPO aux OU concernées :
   * à savoir l'OU **Domain Controller** pour **Computer-WSUS-DC**.
   * l'OU **Paris.ekoloclast > Ordinateurs > Windows Serveur 2022** pour **Computer-WSUS-Servers**.
   * l'OU **Paris.ekoloclast > Utilisateurs** pour **Computer-WSUS-Clients**.

### Vérifier l'application des GPO

Tel que vu dans l'atelier, on peut tester via des commandes **PowerShell** la prise en compte des GPO Update avec serveur WSUS opérationnel sur chaque type de machine :
* exécuter la commande avec le compte administrateur local :
```powershell
gpupdate /force.
```
On peut vérifier si les GPO sont appliquées avec la commande :
```powershell
gpresult /R
```

<p align="center">
<img src="https://github.com/user-attachments/assets/c735eb48-ef64-471c-8e27-d2b7d9f73fee" alt="Pictures" width="600" >
</p>

ou avec la commande **PowerShell** :
```powershell
Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name WUServer, WUStatusServer
```
![WSUS_PowerShellVerification](https://github.com/user-attachments/assets/0fb6a6ae-2d5d-4c15-a104-2d7fa8cea729)


* On peut démontrer l'intérêt des groupes WSUS en suivant la partie 4 de l'Atelier, sauf que dans notre cas nous avons coché tellement peu de Maj à synchroniser que nous n'en avons aucune apparaissant dans le panel **Updates** de WSUS. (Afin de limiter les problèmes d'espace).



**Tuto IT-connect** : https://www.it-connect.fr/chapitres/lier-les-machines-du-domaine-active-directory-serveur-wsus/

