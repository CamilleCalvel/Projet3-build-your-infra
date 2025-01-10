# User Guide pour les nouvelles installations du sprint 6

## Zabbix

## I. Ajout d'un hôte et création d'un groupe

### 1. Connexion à l'interface Web

Utiliser les identifiants par défaut :
- **Utilisateur** : `Admin`
- **Mot de passe** : `zabbix`

### 2. Création de groupes d'hôtes

📌 **Dans le menu :** `Data collection > Host groups`
- Cliquez sur **Create host group**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_createhostGroup.png" alt="Pictures" width="800" >
</p>

- Ajoutez les groupes souhaités
> Dans notre cas, nous souhaitons faire la distinction entre clients Windows et serveurs Windows, ces groupes existant déjà pour Linux

### 3. Ajout des hôtes

📌 **Dans le menu :** `Data collection > Hosts`
- Cliquez sur **Create host**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_CreateHosts.png" alt="Pictures" width="800" >
</p>


- Ajoutez l'étiquette du groupe souhaité pour que l'hôte soit assigné à ce groupe

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_HostCreation2.png" alt="Pictures" width="800" >
</p>

> Exemple : ajout de la machine `CLIWIN-02-ADM` au groupe `Windows hosts`
- Ajoutez l'interface Agent
- Renseignez l'adresse IP de votre client

---

## II. Configuration des alertes et des notifications

### Application du template pour la supervision des hôtes Windows

📌 **Dans le menu :** `Data collection > Hosts`

1. Sélectionnez l'hote créé
2. Dans le champ **Templates**, cliquez sur **Select**


3. Dans le champ **Template group**, cliquez sur **Select**
4. Choisissez **Template**
5. **Cochez** `Windows by Zabbix agent`

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_AlerteNot_Template.png" alt="Pictures" width="400" >
</p>

6. Cliquez sur **Select**, puis **Update**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_AlerteNot_update.png" alt="Pictures" width="700" >
</p>

### Configurer la notification avec une adresse mail

🔗 [Vidéo explicative sur YouTube](https://www.youtube.com/watch?v=9DT7kR8fa0o)

---

#### 1. Générer un mot de passe d'application

1. **Activer IMAP dans Gmail**  
   - Allez dans les paramètres de votre compte Gmail.  
   - Rendez-vous dans l'onglet **Transfert et POP/IMAP**, puis cochez la case **Activer IMAP**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/72915fd3-b649-47b1-9f78-81587b9dc962" alt="Paramètres Gmail" width="500">
   </p>

2. **Accéder à la gestion du compte Google**  
   - Cliquez sur votre photo de profil.  
   - Sélectionnez **Gérer votre compte Google**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/20562fb7-d871-4c3b-9607-b2cd5e30a280" alt="Gestion du compte Google" width="300">
   </p>

3. **Activer la validation en deux étapes**  
   - Rendez-vous dans l'onglet **Sécurité**.  
   - Cliquez sur **Validation en 2 étapes**, puis suivez les instructions pour l'activer.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/79bf5ed5-5544-426c-9174-70ba0165c57a" alt="Validation en 2 étapes" width="700">
   </p>

4. **Générer un mot de passe d'application**  
   - Dans la barre de recherche, saisissez **Mots de passe des applications**.  
   - Donnez un nom à l'application (par exemple : **Zabbix-Email**) et générez le mot de passe.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/f215a01f-662b-48cd-8544-2aa82e609d72" alt="Génération de mot de passe d'application" width="500">
   </p>

   :warning: **Notez bien le mot de passe généré**, il sera nécessaire pour les étapes suivantes.


#### 2. Créer un nouveau Media Type dans Zabbix

1. **Accéder aux Media Types**  
   - Dans le menu de Zabbix, naviguez vers : **Alerts > Media Types**.  
   - Cliquez sur **Email** dans la liste.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/427d9c82-913c-4949-ab79-2c40e8c8a7f6" alt="Menu Media Types" width="800">
   </p>

2. **Configurer les paramètres du Media Type**  
   Remplissez les champs comme suit :  
   - **Name** : Zabbix_Email  
   - **Type** : Email  
   - **Email Provider** : Generic SMTP  
   - **SMTP server** : smtp.gmail.com  
   - **SMTP server port** : 465  
   - **Email** : ekoloclast@gmail.com  
   - **SMTP helo** : gmail.com  
   - **Connection security** : SSL/TLS  
   - **Authentication** : Username and password  
     - **Username** : ekoloclast@gmail.com  
     - **Password** : Mot de passe généré précédemment  
   - **Message format** : HTML  
   - **Description** : Zabbix_Email  

   <p align="center">
     <img src="https://github.com/user-attachments/assets/4201fcce-d798-40ef-88c9-be42ad963bc3" alt="Configuration partie 1" width="600">
   </p>
   <p align="center">
     <img src="https://github.com/user-attachments/assets/40c875c3-7402-440f-bdbf-136ffe3f0329" alt="Configuration partie 2" width="600">
   </p>

3. **Sauvegarder**  
   - Cliquez sur **Update** pour enregistrer les modifications.
     

#### 3. Tester l'envoi de notifications

1. **Tester le Media Type**  
   - Sur la page du Media Type **Zabbix_Email**, cliquez sur le bouton **Test**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/4c9e5c89-38ff-4b20-87bf-62ec0fab4594" alt="Test du Media Type" width="900">
   </p>

2. **Renseigner l'adresse email**  
   - Entrez l'adresse email : **ekoloclast@gmail.com** et cliquez sur **Test**.

   <p align="center">
     <img src="https://github.com/user-attachments/assets/eac6d1d6-7dc4-46b4-b68d-5168dede995b" alt="Test d'envoi d'email" width="600">
   </p>

3. **Vérifier l'email**  
   - Confirmez que le message de test est bien reçu dans la boîte mail **ekoloclast@gmail.com**.


### Création d'une alerte spécifique liée à l'utilisation de notre RAM :

Dans le menu **"Data collection"** > **"Hosts"** :

- Clique sur **Items** qui se trouve sur la ligne de ton client.
- Dans le champ **Name** écris "memory utilization" puis tape entrée.
- Clique sur **Memory utilization** puis sur le bouton **Clone**.
- Donne un nom et une **key** à ton item pour le test (ex : **Alerte RAM** et **AlerteRAM**).
- Clique sur **Add**.

### Configuration du déclencheur de l'alerte précédemment créée.

Dans le menu **"Data collection"** > **"Hosts"** :

- Clique sur **Triggers** qui se trouve sur la ligne de ton client.
- Clique sur le bouton **Create trigger** et donne-lui un nom (ex : **WindowsAlerteRam**).
- Clique sur **Disaster** et sur **Add** du champ **Expression**.
- Sélectionne dans la liste ton item **Alerte RAM**.
- Dans **Result** sélectionne **>=** puis la valeur qui va te permettre de déclencher l'alerte.
- Clique sur **Insert** puis **Add** en bas de la fenêtre.

### Paramétrage supplémentaire pour la réception d'alerte.

- Zou dans **"Users"** > **"Users"**
- Cliquer sur **"Admin"** et choisir l'onglet **"Media"** à droite de **"User"**
- Dans l'encart **media**, cliquer sur **"Add"**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_Users_Users.png" alt="Pictures" width="700" >
</p>

- Définir **type** = **"Zabbix_Email"**
- Dans le champ **"send to"** choisir l'adresse email précédemment rentrée dans le **media type** en étape 2.
- Cocher le niveau de **sévérité** de votre choix. Vérifier si c'est bien **"Enabled"**

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/ConfigureZBX/Zbx_levelseverite.png" alt="Pictures" width="700" >
</p>

- Cliquer sur **"Add"** et, de même, ne pas oublier de **"Update"**.

Pour tester, déclencher l'alerte. Pour vérifier qu'elle a été déclenchée, se rendre dans **"Monitoring"** > **"Problems"** où devraient s'afficher les alertes déclenchées.
Enfin, se rendre dans la **boîte mail concernée** et vérifier que le mail d'alerte a bien été reçu, puis après un retour à la normale, vérifier également la réception d'un mail indiquant la **résolution de problème**.

