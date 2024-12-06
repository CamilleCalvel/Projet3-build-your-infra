
##################################################################################
#                                                                                #
#  Script pour modifier un fichier xlsx en CSV                                   #
#               avec la gestion des accents                                      #
##################################################################################



##################################################################################
# VERIFICATIONS
##################################################################################


# Vérifier si le module ImportExcel est installé
$moduleName = "ImportExcel"

# Vérifie si l'utilisateur actuel est un administrateur
$isAdmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    # Applique la politique d'exécution Unrestricted uniquement pour les administrateurs
    Set-ExecutionPolicy Unrestricted -Scope Process
}

# Vérification de l'existence du module
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "$moduleName n'est pas installé. Installation en cours..."
    
    # Installer le module ImportExcel depuis le PowerShell Gallery
    try {
        Install-Module -Name $moduleName -Force -Scope CurrentUser
        Write-Host "$moduleName installé avec succès."
    } catch {
        Write-Host "Erreur lors de l'installation du module $moduleName : $_"
        exit 1
    }
} else {
    Write-Host "$moduleName est déjà installé."
}

##################################################################################
# FONCTIONS
##################################################################################

# Fonction pour supprimer les caractères spéciaux (accents et autres)
function Remove-StringSpecialCharacters
{
    param ([string]$String)

    # Convertir les caractères spéciaux en ASCII en utilisant l'encodage cyrillique
    $String = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String))

    return $String
}


# Fonction pour supprimer uniquement les accents dans les titres
function Remove-AccentsFromHeaders
{
    param ([string]$String)

    # Vérification que la valeur est bien une chaîne de caractères (string)
    if ($String -is [string]) {
        # Définir un dictionnaire des caractères accentués à remplacer
        $accents = @{
            'é' = 'e'
            'è' = 'e'
            'ê' = 'e'
            'ë' = 'e'
            'à' = 'a'
            'á' = 'a'
            'â' = 'a'
            'ä' = 'a'
            'ç' = 'c'
            'î' = 'i'
            'ï' = 'i'
            'ô' = 'o'
            'ó' = 'o'
            'ö' = 'o'
            'ù' = 'u'
            'û' = 'u'
            'ü' = 'u'
            'ÿ' = 'y'
            'œ' = 'oe'
            'æ' = 'ae'
        }

        # Remplacer les caractères accentués par leur version non accentuée
        foreach ($key in $accents.Keys) {
            $String = $String.Replace($key, $accents[$key])
        }
    } else {
        Write-Host "L'entrée n'est pas une chaîne valide."
    }

    return $String
}


##################################################################################
# CONVERSION
##################################################################################


# Demander à l'utilisateur de saisir le chemin du fichier source .xlsx
$sourceFile = Read-Host "Veuillez entrer le chemin complet du fichier source .xlsx"

# Vérifier si le fichier source existe
if (-not (Test-Path $sourceFile)) {
    Write-Host "Le fichier source spécifié n'existe pas. Veuillez vérifier le chemin."
    exit 1
}

# Demander à l'utilisateur de saisir le chemin du fichier de sortie .csv
$csvFile = Read-Host "Veuillez entrer le chemin complet du fichier de sortie .csv (ex. C:\dossier\monfichier.csv)"

# Si l'utilisateur ne spécifie pas de chemin, utiliser le chemin actuel par défaut
if (-not $csvFile) {
    $csvFile = Join-Path (Get-Location) "fichier_converti.csv"
    Write-Host "Le fichier CSV sera créé dans le répertoire courant : $csvFile"
}

# Importer les données du fichier Excel (première feuille)
try {
    $excelData = Import-Excel -Path $sourceFile
    Write-Host "Fichier Excel importé avec succès."
} catch {
    Write-Host "Erreur lors de l'importation du fichier Excel : $_"
    exit 1
}

# Séparer la première ligne (les titres des colonnes)
$headers = $excelData[0]

# Traiter la première ligne d'en-tête (supprimer les accents dans les titres)
$headers = $headers | ForEach-Object { Remove-AccentsFromHeaders $_ }

# Traiter les autres lignes de données (supprimer les caractères spéciaux dans les valeurs)
$data = $excelData[1..($excelData.Count - 1)] | ForEach-Object {
    $newObj = $_ | Select-Object *
    $newObj.PSObject.Properties.GetEnumerator() | ForEach-Object {
        if ($_.Value -is [string]) {
            $_.Value = Remove-StringSpecialCharacters $_.Value
        }
    }
    $newObj
}

# Réintégrer la première ligne (headers)
$data = @($headers) + $data

# Exporter les données au format CSV
try {
    $data | Export-Csv -Path $csvFile -NoTypeInformation
    Write-Host "Conversion en CSV réussie ! Le fichier a été enregistré à : $csvFile"
} catch {
    Write-Host "Erreur lors de l'exportation en CSV : $_"
    exit 1
}
