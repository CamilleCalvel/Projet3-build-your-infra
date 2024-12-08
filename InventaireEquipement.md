> Prend en compte les conventions de nommage des équipements


# Serveurs

| NomEquipInProxmox     | Hostname            | Adresse IP   | Adresse Réseau | Masque de sous réseau |
|---------------------------|---------------------|--------------|----------------|-------------|
| 1321 (G3-SRV-WIN22GUI)     | SRVWIN-01-AD-DH   | 172.24.0.1   | 172.24.0.0     | 255.255.255.0 |
| 1322 (G3-SRV-LINUX)       | SRVLIN-03-NOFONCTIONYET   | 172.24.0.3   | 172.24.0.0     | 255.255.255.0 |
| ~~1323 (G3-SRV-WIN22Core)~~    | ~~SRVWIN-02-WIN22CORDC~~  | ~~172.24.0.2~~  | 172.24.0.0     | 255.255.255.0 |
| 1325 (G3_SRV-WIN22Core)   | SRVWIN-04-CORDC    | 172.24.0.5   | 172.24.0.0     | 255.255.255.0 |

# Clients

| NomEquipInProxmox     | Hostname            | Adresse IP   | Adresse Réseau | Masque de sous réseau |
|---------------------------|---------------------|--------------|-------------|-------------|
| 1324 (G3-CLI-UBU24)       | CLIUBU-01-      | 172.24.0.4   | 172.24.0.0  | 255.255.255.0 |

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
| \ | SWIVLA-12-                | 172.24.12.0         |
| \ | SWIVLA-13-                | 172.24.13.0         |

# Routeur

| NomMachineInProxmox   |NomConvention | Adresse IP   | Adresse Réseau     |
|----------------------|-------------|-------------|-------------|
| \ | ROUXXX-01-XXX            |\ |\ |
| \ | ROUXXX-02-XXX            |\ |\ |
