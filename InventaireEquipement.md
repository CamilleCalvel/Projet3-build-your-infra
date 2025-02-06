> Prend en compte les conventions de nommage des équipements


# Serveurs

| NomEquipInProxmox     | Hostname            | Adresse IP   | Adresse Réseau | Masque de sous réseau | Vlan |
|---------------------------|---------------------|--------------|----------------|-------------|------|
| 1321 (G3-SRV-WIN22GUI)     | SRVWIN-01-AD-DH   | 172.24.0.1   | 172.24.0.0     | 255.255.255.0 | 12 |
| 1322 (G3-SRV-LINUX)       | SRVLIN-03-NOFONCTIONYET   | 172.24.0.3   | 172.24.0.0     | 255.255.255.0 | 12 |
| 1325 (G3_SRV-WIN22Core)   | SRVWIN-04-CORDC    | 172.24.0.5   | 172.24.0.0     | 255.255.255.0 | 12 |
| 1328 (G3_SRVLIN-04-ZBX)   | SRVLIN-04-ZBX  | 172.24.0.7   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1329 (G3_SRVLIN-05-SMTP)   | SRVLIN-05-SMTP  | 172.24.0.8   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1331 (G3_SRVWIN-07-WSUS)   | SRVWIN-07-WSUS  | 172.24.0.10   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1332 (G3_SRVWIN-08-FILE-SHARE)   | SRVWIN-08-SHARE  | 172.24.0.11   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1333 (G3-SRVWINCore-09-DC) | SRVWIN-09-DC  | 172.24.0.12   | 172.24.0.0  | 255.255.255.0 | 12 | 
| 1334 (G3-SRVLIN-10-Web) | SRVWLIN-10-Web  | 172.24.11.1   | 172.24.0.0  | 255.255.255.0 | 11|
| 1335 (G3-SRVLIN-11-VOIP) | SRVWLIN-11-VOIP  | 172.24.0.13   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1336 (G3-SRVLIN-GUACAMOLE) | SRVWLIN-12-GUAC  | 172.24.11.2   | 172.24.0.0  | 255.255.255.0 | 11 |
> le serveur 06-SMTP n'est pas finalisé, c'est toujours la tentative d'un SMPT avec iRedMail en suivant l'atelier


# Clients

| NomEquipInProxmox     | Hostname            | Adresse IP   | Adresse Réseau | Masque de sous réseau | Vlan |
|---------------------------|---------------------|--------------|-------------|-------------|------|
| 1324 (G3-CLI-UBU24)       | CLIUBU-01-ADM  | 172.24.0.4   | 172.24.0.0  | 255.255.255.0 | 12 |
| 1323 (G3-CLI02-WIN-ADM)   | CLIWIN-02-ADM  | 172.24.0.2   | 172.24.0.0     | 255.255.255.0 | 12 |
| 1326 (G3_CLI03-WIN-BKUP)   | CLIWIN-03-BKUP   | 172.24.0.6   | 172.24.0.0     | 255.255.255.0 | 12 |
| 1327 (G3_CLI04-WIN-TEST)   | CLIWIN-04-DSI    | 172.24.7.1   | 172.24.0.0  | 255.255.255.0 | 7 |


# Switch

| NomEquipInProxmox | NomConvention     | Adresse Réseau     |
|-----------|---------------------------|---------------------|
| \ | SWIVLA-01-COMM            | 172.24.1.0          |
| \ | SWIVLA-02-DFIN            | 172.24.2.0          |
| \ | SWIVLA-03-DG              | 172.24.3.0          |
| \ | SWIVLA-04-MKTG            | 172.24.4.0          |
| \ | SWIVLA-05-DSI             | 172.24.5.0          |
| \ | SWIVLA-06-RD              | 172.24.6.0          |
| \ | SWIVLAN-07-RH             | 172.24.7.0          |
| \ | SWIVLA-08-SG              | 172.24.8.0          |
| \ | SWIVLA-09-SJURI           | 172.24.9.0          |
| \ | SWIVLA-10-VDC             | 172.24.10.0         |
| \ | SWIVLA-11-DMZ             | 172.24.11.0         |
| \ | SWIVLA-12-SRVT0           | 172.24.0.0         |
| \ | SWIVLA-13-                | 172.24.13.0         |

# Routeur

| NomMachineInProxmox   |NomConvention | Adresse IP   | Adresse Réseau     |
|----------------------|-------------|-------------|-------------|
| \ | ROUXXX-01-XXX            |\ |\ |
| \ | ROUXXX-02-XXX            |\ |\ |
