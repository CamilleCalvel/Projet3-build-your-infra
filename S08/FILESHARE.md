<details><summary><h1> 👨‍🦲📂 Dossiers partagés individuels<h1></summary>  
  
# Mise en place de dossiers partagés  
  
Pour mettre en place des dossiers partagés sur Windows Server, il faut que ce serveur soit promu contrôleur de domaine.  
  
## :one: Création du dossier partagé individuel   
  
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
  
## 2️⃣ Configuration des droits NTFS  
  
➡️ Toujours dans les propriétés du dossier, se rendre dans l'onglet `Security` puis cliquer sur `Advanced`  
  
![image](https://github.com/user-attachments/assets/e2f81193-00dc-4b1c-9c3d-50993d1f31ba)  
  
➡️ Cliquer sur `Disable inheritance` pour supprimer les permissions héritées et configurer nos permissions personnalisées  
  
➡️ Cliquer sur `Add` puis sur `Select a principal`, et suivre les étapes ci-dessous :  
  
![image](https://github.com/user-attachments/assets/4fe6a788-6c64-4299-aa74-6e8ca156eb04)  
  
➡️ Ajouter `CREATOR OWNERS`, `SYSTEM`, `Administrator`, `Authenticated Users` et leur donner un contrôle total  
  
![image](https://github.com/user-attachments/assets/c9b8c230-bbf3-45cf-a8a0-f88a64cec569)  
  
➡️ Appliquer les changements et fermer la fenêtre  
  
## 3️⃣ Création d'une GPO d'automatisation de création de dossiers individuels  
  
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
  
## 4️⃣ Création d'un raccourci sur le bureau [optionnel]  
  
➡️ `Shortcuts` -> `New > Shortcut`  
  
![image](https://github.com/user-attachments/assets/27e1e9a4-9306-49ae-ad13-badf4040e1f4)  
  
➡️ Dans l'onglet `Common`, cocher la case `Run in logged-on user's security context (user policy option)`  
    
➡️ Cliquer sur `Apply` puis `OK`    
  
![image](https://github.com/user-attachments/assets/97435908-3cab-477c-8e06-c8d5c6e25b51)  
  
➡️ Ouvrir un invite de commande et taper `gpupdate /force` pour enregistrer la nouvelle GPO  
  
![image](https://github.com/user-attachments/assets/db001645-a159-40a4-a093-1a4715963b3d)

</details>






  


  




  


