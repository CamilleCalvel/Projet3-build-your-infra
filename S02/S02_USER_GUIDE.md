# :computer: Gérer le domaine Active Directory en GUI

#### 1- Créer une Unité d'Organisation

- Ouvrir l'application **Active Directory Users and Computers**
- Faire clic droit sur le nom de domain (ici:**ekoloclast.local**), sélectionner **New** puis Cliquer sur **Organizational Unit**
- Nommer l'unité d'organisation et Cliquer sur **OK**

#### 2- Créer un Groupe d'utilisateurs
- Faire clic droit sur le nom de l'unité d'organisation, sélectionner **New** puis Cliquer sur **Group**
- Nommer le groupe et Cliquer sur **OK**

#### 3- Créer un utilisateur 
- Faire clic droit sur le nom de l'unité d'organisation, sélectionner **New** puis Cliquer sur **User**
- Renseigner les informations utilisateurs:
	- Indiquer le **First Name**
	- Indiquer le **Last Name**
	- Indiquer le **User logon Name**
	- Cliquer sur **Next**
- Créer le mot de passe de l'utilisateur et cocher **Password never expires**
- Lire le résumé et Cliquer sur **Finish**

![Capture d'écran 2024-11-28 180927](https://github.com/user-attachments/assets/97b2556b-3490-4b84-ad19-cc5d33520e73)
![Capture d'écran 2024-11-28 180941](https://github.com/user-attachments/assets/0bcaf208-c7a9-4a4f-8602-d34de62db0e3)

# :fax: Gérer le domaine Active Directory via Powershell

#### 1- Créer une Unité d'Organisation

```powershell
# Importer le module Active Directory si ce n'est pas déjà fait
Import-Module ActiveDirectory

# Définir le chemin de l'OU à créer
$PathOU = "DC=NotreDomaine,DC=com"

# Créer l'unité d'organisation
New-ADOrganizationalUnit -Name $args[0] -Path $PathOU
```

#### 2- Créer un Groupe d'utilisateurs

```powershell
# Demander le nom du groupe à l'utilisateur
$NomGroupe = Read-Host "Entrez le nom du groupe à créer"

# Demander le chemin à l'utilisateur
$CheminOU = Read-Host "Entrez le chemin de l'Unité Organisationnelle (OU) dans le format 'OU=Groupes,DC=mondomaine,DC=com'"

# Demander la description du groupe
$Description = Read-Host "Entrez une description pour le groupe"

# Créer le groupe dans Active Directory
New-ADGroup -Name $NomGroupe -GroupScope Global -Path $CheminOU -Description $Description -PassThru

Write-Host "Le groupe '$NomGroupe' a été créé dans l'OU '$CheminOU'."
```

#### 3- Créer un utilisateur 
