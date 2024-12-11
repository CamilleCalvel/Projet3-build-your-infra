# Import Active Directory module and ImportExcel module
Import-Module ActiveDirectory
Import-Module ImportExcel

# Define the path to the Excel file
$excelFilePath = "C:\s01_Ekoloclast_v2.xlsx"

# Import the data from the Excel file
$employees = Import-Excel -Path $excelFilePath

# Mapping table for department names (to match AD OUs)
$departmentMapping = @{
    "Direction Financiere" = "DFIN"
    "R&D" = "RD"
    "Communication" = "COMM"
    "Direction Generale" = "DG"
    "DSI" = "DSI"
    "Service Juridique" = "SJURI"
    "Service Generaux" = "SG"
    "Ventes et Developpement Commercial" = "VDC"
    "Direction Marketing" = "MKTG"
    "RH" = "RH"
}

# Iterate through each employee in the file
foreach ($employee in $employees) {
    # Extract user details
    $firstName = $employee.Prenom
    $lastName = $employee.Nom
	$username = ($firstName + $lastName).Tolower() -replace '[^\w`\d]', ''
    $departmentOriginal = $employee.Departement
   # $service = $employee.Service

    # Map the department name from the spreadsheet to the AD structure
	$department = $departmentMapping[$departmentOriginal]
	
    if (-not $department) {
        Write-Host "Unknown department: $departmentOriginal for user $username" -ForegroundColor Yellow
        continue
    }

    # Define the OU paths
    $userOUPath = "OU=$department,OU=LAboUtilisateurs,DC=labo,DC=lan"
    $groupOUPath = "OU=LaboSecurite,DC=labo,DC=lan"

    # Define user details for creation
    $userPrincipalName = "$lastName@labo.lan"
    $password = ConvertTo-SecureString "Azerty1*" -AsPlainText -Force

    # Check if user already exists
    if (-not (Get-ADUser -Filter {SamAccountName -eq $username})) {
        try {
            # Create the user in the appropriate OU
            New-ADUser -Name "$firstName $lastName" `
                       -GivenName $firstName `
                       -Surname $lastName `
                       -SamAccountName $usernamee `
                       -UserPrincipalName $userPrincipalName `
                       -Path $userOUPath `
                       -AccountPassword $password `
                       -Enabled $true -Verbose

            Write-Host "User $firstName $lastName created in OU: $userOUPath" -ForegroundColor Green
        } catch {
            Write-Host "Error creating user $firstName $lastName in OU $userOUPath $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "User $username already exists. Skipping." -ForegroundColor Yellow
    }

    # Attempt to add user to their service group
   # try {
    #    Add-ADGroupMember -Identity $service -Members $username
     #   Write-Host "User $username added to group: $service" -ForegroundColor Green
    #} catch {
     #   Write-Host "Error adding user $username to group $service $($_.Exception.Message)" -ForegroundColor Red
    #}
}
