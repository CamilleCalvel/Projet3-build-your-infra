# :minidisc: Mise en place de RAID1

<details><summary><h1>:one:Configuration matérielle et logicielle</h1></summary>
  
- **Système d'exploitation :** Windows Server 2022  
- **Nom de la machine :** `SRVWIN-01-AD-DH`  
- **Disques disponibles :**
  - **Disk 0** : Disque système (32 Go)
  - **Disk 1** : Sauvegarde Active Directory (32 Go)
  - **Disk 2** : Volume vide (32 Go)

</details>

---

<details><summary><h1>:two:Étapes de création du RAID1</h1></summary>

1. **Ouvrir le Gestionnaire de disques** :
   - Utilisez la combinaison `Win + X` et sélectionnez **Gestion des disques**.

2. **Convertir les disques en disques dynamiques** :
   - Cliquez avec le bouton droit sur **Disk 1** et **Disk 2**.
   - Sélectionnez **Convertir en disque dynamique**.

3. **Ajouter un miroir** :
   - Cliquez avec le bouton droit sur **Disk 1**.
   - Sélectionnez **Ajouter un miroir...**.
   - Choisissez **Disk 2** comme miroir.

4. **Synchronisation** :
   - Attendez que la synchronisation entre les deux disques soit terminée.
   - Le processus peut être suivi via l'interface du Gestionnaire de disques.

</details>

---

<details><summary><h1>:three:Résultat attendu</h1></summary>

Une fois la configuration terminée, les deux disques seront en miroir (RAID1).  
Ci-dessous, un exemple du résultat final dans le Gestionnaire de disques :

![Capture d'écran - RAID1 terminé](https://github.com/user-attachments/assets/73ca108c-75de-4723-9a72-7a291db6f444)

</details>

---




<details><summary><h1>:one: Mise en place de plages d'adresses IP sur DHCP</h1></summary>  

Mettre en place une plage d'adresse IP permet d'attribuer automatiquement une adresse IP faisant partie du réseau sur lequel se trouve la machine concernée.  
Voici un mode d'emploi qui détaille les étapes de la mise en place des plages d'adresses IP sur le serveur DHCP.  

## Créer une plage d'adresse IP (Scope)  

➡️ Se rendre sur le `Server Manager` -> `Tools` -> `DHCP`
  
➡️ Faire un clic droit sur `IPv4` -> `New Scope` :
  
![NomScope](https://github.com/user-attachments/assets/44c6c381-bca8-496c-9144-9c9a6b1dd449)  
  
➡️ Cliquer sur `Next` jusqu'à arriver à la fenêtre `Scope Name` ci dessous :
   
![NewScope](https://github.com/user-attachments/assets/494a2fde-9d4e-485c-b69c-a5655b01f65b)  

➡️ Une fois le nom choisi, cliquer sur `Next` pour définir la plage d'adresses IP :
  
![Range](https://github.com/user-attachments/assets/9d67ffaf-5dcc-4200-87fe-e67cd996144a)  


➡️ Cliquer sur `Next` jusqu'à arriver à la fenêtre `Configure DHCP Options`  
  
➡️ Laisser la case `Do you want to configure the DHCP otpions for this scope now?` cochée par défaut `Yes)`  
  
![ConfigureDHCP](https://github.com/user-attachments/assets/48bf5ed7-bf5e-4d1d-b69a-e25e0aed9c24)  
  

➡️ Cliquer sur `Next` jusqu'à arriver à la fenêtre `Router (Default Gateway)`  
  
➡️ Entrer l'adresse passerelle pour le réseau que l'on est en train de configurer (pour un réseau `172.24.1.0`, mettre l'adresse `172.24.1.254`)  
  
![Router](https://github.com/user-attachments/assets/5e82587c-52f7-4847-bfcb-3c137440dc0c)  

  
➡️ Cliquer sur `Next`, on arrive sur la fenêtre de configuration du DNS et du nom de domaine :  
  
  • `Parent domain : ekoloclast.local`    
  
  • `IP address : mettre 8.8.8.8 et 172.24.0.1`.  
  Une fois ces deux adresses entrées, cliquer sur l'adresse `172.24.0.1` et cliquer sur `Up`.  
  
![DomainNameDNS](https://github.com/user-attachments/assets/ae757d58-3b04-479c-a643-ec5403ff20f2)  

  
➡️ Cliquer sur `Next` jusqu'à arriver à la fenêtre `Activate Scope`. Cocher `Yes, I want to activate this scope now`.  
  
![ActivateScope](https://github.com/user-attachments/assets/9d109cb1-6e4d-483e-914e-4c9ac2f247c3)  

  
➡️ Cliquer sur `Next` jusqu'à terminer l'installation  
</details>
