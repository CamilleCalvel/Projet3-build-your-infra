# Demander le nom du groupe à l'utilisateur
$NomGroupe = Read-Host "Entrez le nom du groupe à créer"

# Si le chemin OU n'est pas fourni en argument, demander à l'utilisateur
if (-not $CheminOU) {
    $CheminOU = Read-Host "Entrez le chemin de l'Unité Organisationnelle (OU) dans le format 'OU=Groupes,DC=mondomaine,DC=com'"
}

# Demander la description du groupe
$Description = Read-Host "Entrez une description pour le groupe"

# Créer le groupe dans Active Directory
New-ADGroup -Name $NomGroupe -GroupScope Global -Path $CheminOU -Description $Description -PassThru

Write-Host "Le groupe '$NomGroupe' a été créé dans l'OU '$CheminOU'."
