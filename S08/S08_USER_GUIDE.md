# 🏢 Rôles FSMO dans Active Directory

## 📊 Répartition des rôles FSMO entre les DC

### 🎯 Pourquoi répartir les rôles FSMO ?

Répartir les rôles FSMO entre plusieurs contrôleurs de domaine permet :

- **Éviter les points de défaillance uniques** : Si un seul DC détient tous les rôles, une panne pourrait bloquer le fonctionnement de l'AD.  
- **Optimiser la charge** : Certains rôles sont plus sollicités que d'autres (ex. PDC Emulator).  
- **Améliorer la résilience et la récupération** : En cas de panne, il est plus facile de transférer un rôle FSMO d'un DC à un autre.

---

### 🏷️ Les 5 rôles FSMO en détail

Active Directory possède **5 rôles FSMO**, répartis comme suit :

1. **Maître d'attribution de noms de domaine (Domain Naming Master)**  
   - Gère l'ajout et la suppression de domaines dans la forêt AD.

2. **Maître de schéma (Schema Master)**  
   - Responsable des modifications du schéma AD.

3. **Émulateur PDC (PDC Emulator)**  
   - Gère la synchronisation horaire et la compatibilité avec les anciennes versions de Windows.

4. **Maître RID (Relative ID Master)**  
   - Gère l'attribution des identifiants uniques (RIDs) pour les objets AD.

5. **Maître d'infrastructure (Infrastructure Master)**  
   - Assure la correspondance entre les objets AD provenant d'autres domaines.

---

## ⚙️ Prérequis techniques

Avant de répartir les rôles FSMO, il est nécessaire d'avoir **trois contrôleurs de domaine (DC)** sur le domaine :

- **SRVWIN-01-AD-DHCP-DNS** (GUI)  
- **SRVWIN-04-CORDC** (CLI)  
- **SRVWIN-09-DC** (CLI)  

---

## 🔄 Partager les rôles FSMO entre les DC

### 1. Vérifier les rôles FSMO actuels

Utiliser la commande suivante pour afficher la répartition actuelle des rôles FSMO :

```powershell
netdom query fsmo
```

![Capture d'écran 2025-01-23 115952](https://github.com/user-attachments/assets/953351d5-00d7-4a4c-95b2-7ef9882adec4)

Actuellement, **les 5 rôles FSMO** sont détenus par le DC suivant :

**🔹 SRVWIN-01-AD-DHCP-DNS**

---

### 2. Transférer les rôles FSMO à d'autres DC :
 Pour redistribuer les rôles FSMO vers un autre contrôleur de domaine :

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity "Nouveau-DC" -OperationMasterRole PDCEmulator, RIDMaster, InfrastructureMaster
```

---

### 3. Forcer la réplication des changements FSMO :

Une fois les rôles FSMO transférés, il est essentiel de propager les modifications à l'ensemble des contrôleurs de domaine.  
Pour cela, utiliser  la commande suivante :

```powershell
repadmin /syncall /AdeP
```

---

### Autre Méthode
- [IT-Connect : Active Directory : transfert des rôles FSMO avec NTDSUTIL](https://www.it-connect.fr/transfert-des-roles-fsmo-avec-ntdsutil/)



