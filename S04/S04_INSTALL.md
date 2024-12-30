# Installation et Configuration de Windows Server Backup

## Introduction
Windows Server Backup est un outil puissant pour gérer les sauvegardes sur un serveur Windows. Ce guide explique comment :

1. Installer Windows Server Backup.
2. Ajouter un disque de stockage dédié aux sauvegardes.
3. Configurer le système pour une sauvegarde planifiée.

---

## **1. Installation de Windows Server Backup**

1. **Ouvrir le Gestionnaire de serveur :**
   - Connectez-vous au serveur.
   - Lancez le **Gestionnaire de serveur** via le menu **Démarrer**.

2. **Ajouter le rôle ou la fonctionnalité :**
   - Cliquez sur **Gérer** > **Ajouter des rôles et fonctionnalités**.
   - Dans l'assistant, choisissez l'option **Installation basée sur un rôle ou une fonctionnalité**.
![Capture d’écran 2024-12-12 110303](https://github.com/user-attachments/assets/81b3c7ed-6618-4ae7-a16e-a0870bf54a09)

3. **Sélectionner la fonctionnalité Windows Server Backup :**
   - Parcourez les fonctionnalités disponibles et cochez **Windows Server Backup**.
   - Cliquez sur **Suivant**, puis sur **Installer**.
![Capture d’écran 2024-12-12 110644](https://github.com/user-attachments/assets/eb4b6706-74dc-4806-9ebc-5532bd6e9308)
![Capture d’écran 2024-12-12 110737](https://github.com/user-attachments/assets/054277e0-3296-4bb4-b8ce-2daf9b72d5b2)
4. **Finaliser l'installation :**
   - Une fois l'installation terminée, redémarrez le serveur si nécessaire.
![Capture d’écran 2024-12-12 111125](https://github.com/user-attachments/assets/7e2433d0-5c8a-42a9-9a87-8eb4f7f5657c)
---

## **2. Ajout d’un disque dédié pour les sauvegardes**

1. **Connecter le disque au serveur :**
   - Branchez un disque dur externe ou ajoutez un disque interne au serveur.

2. **Initialiser et formater le disque :**
   - Ouvrez l’outil **Gestion des disques** :
     - Cliquez droit sur le menu **Démarrer** et sélectionnez **Gestion des disques**.
   - Si le disque est neuf, initialisez-le (MBR ou GPT).
   - Formatez le disque avec le système de fichiers **NTFS** :
     - Faites un clic droit sur le volume > **Formater** > choisissez NTFS.

3. **Attribuer une lettre au lecteur :**
   - Faites un clic droit sur le disque > **Modifier la lettre de lecteur et les chemins d'accès**.
   - Attribuez une lettre unique pour identifier facilement le disque.

---

## **3. Configuration de Windows Server Backup**

1. **Lancer Windows Server Backup :**
   - Accédez à l'outil via :
     - **Menu Démarrer** > **Outils d'administration Windows** > **Sauvegarde de Windows Server**.

2.1. **Configurer la sauvegarde planifiée :**
   - Dans le volet droit, sélectionnez **Sauvegarde planifiée**.
   - Suivez les étapes de l’assistant :
     - **Options de configuration** : Choisissez si vous souhaitez sauvegarder l'intégralité du serveur ou des volumes/fichiers spécifiques.
     - **Planification** : Définissez l'heure et la fréquence des sauvegardes.
     - **Cible de la sauvegarde** : Sélectionnez **Disque dur**.
       - Choisissez le disque ajouté comme cible.
      
2.2. **Configurer une sauvegarde:**
   - Dans le volet droit, sélectionnez **Back Up Once**.
   - Suivez les étapes de l’assistant :
     - **Options de configuration** : Choisissez si vous souhaitez sauvegarder l'intégralité du serveur ou des volumes/fichiers spécifiques.
     - **Cible de la sauvegarde** : Sélectionnez **Disque dur**.
       - Choisissez le disque ajouté comme cible.

3. **Copier la sauvegarde sur un client:**
   - Sur le serveur
      - Faire clic droit sur le dossier du Back Up > Properties
      - Selectionner l'onglet **Sharing** > **Advanced Sharing...** > cochez la case **Share folder** et recuperer l'adresse de ce dossier partager qui s'affiche
   - Sur le client
      - Ouvrez un exploreur de fichiers > Dans le volet de gauche, selectionnez Network
      - Dans la barre de recherche, mettre l'adresse du dossier partage où ce trouve le Back UP
      - Copier/Coller le dossier sur le client
        
3. **Configurer les paramètres avancés :**
   - Si nécessaire, définissez des exclusions ou des paramètres VSS (Volume Shadow Copy Service) pour garantir la cohérence des sauvegardes.

4. **Vérifier la configuration :**
   - Une fois la planification terminée, vérifiez que le disque est listé comme cible.
   - Exécutez une sauvegarde manuelle en cliquant sur **Sauvegarder maintenant** pour tester la configuration.

---

## **4. Conseils supplémentaires et bonnes pratiques**

- **Rotation des disques :** Si possible, configurez plusieurs disques pour les sauvegardes et effectuez une rotation régulière. Cela offre une meilleure protection contre les défaillances matérielles.
- **Surveillance des sauvegardes :** Vérifiez régulièrement les journaux de sauvegarde dans l’Observateur d’événements pour identifier les éventuels échecs.
- **Plan de reprise :** Testez périodiquement la restauration pour garantir l'intégrité des sauvegardes.

---

## **5. Exemple de Script PowerShell pour Automatiser la Configuration**

Voici un script PowerShell pour automatiser l'installation et la configuration de Windows Server Backup :

```powershell
# Installer Windows Server Backup
Install-WindowsFeature -Name Windows-Server-Backup

# Créer une sauvegarde planifiée
$backupPolicy = New-WBPolicy
$volume = Get-WBVolume -VolumePath "D:"
Add-WBVolume -Policy $backupPolicy -Volume $volume

# Configurer la cible de sauvegarde
$backupTarget = New-WBDiskTarget -Disk (Get-Disk | Where-Object { $_.FriendlyName -eq "BackupDisk" })
Add-WBBackupTarget -Policy $backupPolicy -Target $backupTarget

# Planification quotidienne
Set-WBSchedule -Policy $backupPolicy -Schedule (Get-Date -Hour 2 -Minute 0)

# Enregistrer la politique de sauvegarde
Set-WBPolicy -Policy $backupPolicy
```

---

Avec ces étapes, vous disposez d'un système de sauvegarde fiable pour votre serveur Windows. N'oubliez pas de surveiller vos sauvegardes et de maintenir une copie hors site pour les situations d'urgence.
