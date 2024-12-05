# Vérifier si le module ImportExcel est installé
$moduleName = "ImportExcel"

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

# Exporter les données au format CSV
try {
    $excelData | Export-Csv -Path $csvFile -NoTypeInformation
    Write-Host "Conversion en CSV réussie ! Le fichier a été enregistré à : $csvFile"
} catch {
    Write-Host "Erreur lors de l'exportation en CSV : $_"
    exit 1
}
