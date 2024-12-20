## Mise en place de RAID1

### Configuration matérielle et logicielle
- **Système d'exploitation :** Windows Server 2022  
- **Nom de la machine :** `SRVWIN-01-AD-DH`  
- **Disques disponibles :**
  - **Disk 0** : Disque système (32 Go)
  - **Disk 1** : Sauvegarde Active Directory (32 Go)
  - **Disk 2** : Volume vide (32 Go)

### Étapes de création du RAID1

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

## Résultat attendu

Une fois la configuration terminée, les deux disques seront en miroir (RAID1).  
Ci-dessous, un exemple du résultat final dans le Gestionnaire de disques :

![Capture d'écran - RAID1 terminé](https://github.com/user-attachments/assets/73ca108c-75de-4723-9a72-7a291db6f444)


## LVM

```apt-install lvm2```
