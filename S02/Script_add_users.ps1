# Import Active Directory module and ImportExcel module
Import-Module ActiveDirectory
Import-Module ImportExcel

# Define the path to the Excel file
$excelFilePath = "C:\s01_Ekoloclast_v2.xlsx"

# Import the data from the Excel file
$employees = Import-Excel -Path $excelFilePath

# Mapping des services vers leurs chemins d'OU dans l'AD
$serviceMapping = @{
    # COMM
    "Publicite" = "OU=Publicité,OU=COMM,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Relation Publique Presse" = "OU=Relation-Publique-Presse,OU=COMM,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # DFIN
    "Controle Gestion" = "OU=Contrôle-Gestion,OU=DFIN,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Finance" = "OU=Finance,OU=DFIN,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Service Compatibilite" = "OU=Service-Compatibilité,OU=DFIN,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # DSI
    "Data" = "OU=Data,OU=DSI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Developpement Logiciel" = "OU=Développement-Logiciel,OU=DSI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Support" = "OU=Support,OU=DSI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # MKTG
    "Marketing Digital" = "OU=Mktg-Digital,OU=MKTG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Marketing Opérationnel" = "OU=Mktg-Opérationnel,OU=MKTG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Marketing Produit" = "OU=Mktg-Produit,OU=MKTG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Marketing Stratégique" = "OU=Mktg-Stratégique,OU=MKTG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # RD
    "Innovation Strategie" = "OU=Innovation-Stratégie,OU=RD,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Laboratoire" = "OU=Laboratoire,OU=RD,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # RH
    "Formation" = "OU=Formation,OU=RH,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Gestion Performances" = "OU=Gestion-Performances,OU=RH,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Recrutement" = "OU=Recrutement,OU=RH,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Sante Securite Travail" = "OU=Santé-Sécurite-Travail,OU=RH,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # SG
    "Gestion-Immobilière" = "OU=Gestion-Immobilière,OU=SG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Logistique" = "OU=Logistique,OU=SG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # SJURI
    "Contentieux" = "OU=Contentieux,OU=SJURI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Contrats" = "OU=Contrats,OU=SJURI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    
    # VDC
    "ADV" = "OU=ADV,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "B2B" = "OU=B2B,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "B2C" = "OU=B2C,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Developpement International" = "OU=Développement-International,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Grands Comptes" = "OU=Grands-Comptes,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Service Achat" = "OU=Service-Achat,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Service Client" = "OU=Service-Client,OU=VDC,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
}

# Mapping des départements vers leurs chemins d'OU dans l'AD
$departmentMapping = @{
    "R&H" = "OU=RH,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Direction Generale" = "OU=DG,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "Communication" = "OU=COMM,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    "DSI" = "OU=DSI,OU=Utilisateurs,OU=Paris,DC=ekoloclast,DC=local"
    # Ajoutez ici les autres départements nécessaires
}

# Iterate through each employee in the file
foreach ($employee in $employees) {
    # Extract user details
    $firstName = $employee.Prenom
    $lastName = $employee.Nom
    $department = $employee.Departement
    $service = $employee.Service

    # Generate the username
    $username = ($firstName + $lastName).ToLower() -replace '[^\w\d]', ''

    # Determine the OU Path
    if ($service -and $service -ne "-") {
        # If a service is specified, map to the corresponding OU path
        if ($serviceMapping.ContainsKey($service)) {
            $ouPath = $serviceMapping[$service]
        } else {
            Write-Host "Service $service not found in mapping. Skipping user $firstName $lastName." -ForegroundColor Red
            continue
        }
    } elseif ($department -and $department -ne "-") {
        # If no service but a department is specified, map to the department OU
        if ($departmentMapping.ContainsKey($department)) {
            $ouPath = $departmentMapping[$department]
        } else {
            Write-Host "Department $department not found in mapping. Skipping user $firstName $lastName." -ForegroundColor Red
            continue
        }
    } else {
        # Skip users with no valid department or service
        Write-Host "No department or service found for user $firstName $lastName. Skipping." -ForegroundColor Yellow
        continue
    }

    # Define user details for creation
    $userPrincipalName = "$username@ekoloclast.local"
    $password = ConvertTo-SecureString "Azerty1*" -AsPlainText -Force

    # Check if user already exists
    if (-not (Get-ADUser -Filter {SamAccountName -eq $username})) {
        try {
            # Create the user in the appropriate OU
            New-ADUser -Name "$firstName $lastName" `
                       -GivenName $firstName `
                       -Surname $lastName `
                       -SamAccountName $username `
                       -UserPrincipalName $userPrincipalName `
                       -Path $ouPath `
                       -AccountPassword $password `
                       -Enabled $true -Verbose

            Write-Host "User $firstName $lastName created in OU: $ouPath" -ForegroundColor Green
        } catch {
            Write-Host "Error creating user $firstName $lastName in OU $ouPath $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "User $username already exists. Skipping." -ForegroundColor Yellow
    }
}
