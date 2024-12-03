# Importer le module Active Directory si ce n'est pas déjà fait
Import-Module ActiveDirectory

# Définir le chemin de l'OU à créer
$PathOU = "DC=NotreDomaine,DC=com"

# Créer l'unité d'organisation
New-ADOrganizationalUnit -Name $args[0] -Path $PathOU
