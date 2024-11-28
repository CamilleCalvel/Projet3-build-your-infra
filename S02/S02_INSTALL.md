# 🔱 Guide d'installation des Rôles AD, DHCP et DNS

## :one: Installation du rôle Active Directory (AD)

1. **Ouvrir Server Manager**.
2. Dans le _Dashboard_, cliquer sur **Add roles and features**.
3. Dans _Before You Begin_, cliquer sur **Next**.
4. Dans _Installation Type_ :  
   - Cocher **Role-based or feature-based installation**.  
   - Cliquer sur **Next**.
5. Dans _Server Selection_ :  
   - Sélectionner un serveur: **SRVWIN-01-AD-DHCP-DNS**
   - Cliquer sur **Next**.
6. Dans _Server Roles_ :  
   - Cocher **Active Directory Domain Services**.  
   - Une fenêtre s’ouvre :  
     - Cocher **Include management tools (if applicable)**.  
     - Cliquer sur **Add Features**.  
   - Cliquer sur **Next**.
7. Dans _Features_, cliquer sur **Next**.
8. Dans _DNS Server_, cliquer sur **Next**.
9. Dans _Confirmation_, cliquer sur **Install**.  

---

### À la fin de l’installation :
- Un message apparaît : _"Configuration required. Installation on SRVWIN-01-AD-DHCP-DNS."_  
- Cliquer sur **Promote this server to a domain controller**.

---

### Configuration du serveur AD :
10. Dans _Deployment Configuration_ :  
    - Sélectionner **Add a new forest**.  
    - Indiquer un nom dans **Root domain name**: **Ekoloclast.local**
    - Cliquer sur **Next**.
11. Dans _Domain Controller Options_ :  
    - **Forest functional level** : Windows Server 2016.  
    - **Domain functional level** : Windows Server 2016.  
    - Laisser cochés :  
      - **Domain Name System (DNS) server**.  
      - **Global Catalog (GC)**.  
    - Entrer un mot de passe dans **Password** et le confirmer dans **Confirm password**.  
    - Cliquer sur **Next**.
12. Dans _DNS Options_, cliquer sur **Next**.
13. Dans _Additional Options_ :  
    - Choisir un nom NetBIOS: **EKOLOCLAST**
    - Cliquer sur **Next**.
14. Dans _Path_ :  
    - Laisser les dossiers par défaut.  
    - Cliquer sur **Next**.
15. Lire les **Review Options** puis cliquer sur **Next**.
16. Une vérification de la configuration s’effectue :  
    - Si tout est correct, le message **All prerequisite checks passed successfully** s’affiche.  
    - Cliquer sur **Install**.
17. À la fin de l’installation :  
    - La machine redémarre automatiquement.  
    - La session affiche : **EKOLOCLAST\Administrator**.

---

## :two: Installation du rôle DHCP

1. **Ouvrir Server Manager**.
2. Cliquer sur **Manage** -> **Add Roles and Features**.  
   - Une fenêtre s’ouvre avec les étapes suivantes :

---

### Étapes :
3. Dans _Before You Begin_, cliquer sur **Next**.
4. Dans _Installation Type_ :  
   - Garder **Role-based or feature-based installation** coché.  
   - Cliquer sur **Next**.
5. Dans _Server Selection_ :  
   - Sélectionner le serveur par défaut.  
   - Cliquer sur **Next**.
6. Dans _Select Server Roles_ :  
   - Cocher **DHCP Server**.  
   - Cliquer sur **Next**.
7. Dans _Add Roles and Features Wizard_ :  
   - Cliquer sur **Add Features**.
8. Dans _Features_ :  
   - Laisser les options par défaut.  
   - Cliquer sur **Next**.
9. Dans _DHCP Server_, cliquer sur **Next**.
10. Dans _Confirmation_, cliquer sur **Install**.

---

### Finalisation :
11. Une notification apparaît en haut de la fenêtre pour compléter la configuration :  
    - Cliquer dessus.  
    - Cliquer sur **Commit**.  
    - Cliquer sur **Close**.

## Installation du rôle DNS

1. **Ouvrir Server Manager**.
2. Dans le _Dashboard_, cliquer sur **Add roles and features**.
3. Dans _Before You Begin_, cliquer sur **Next**.
4. Dans _Installation Type_ :  
   - Cocher **Role-based or feature-based installation**.  
   - Cliquer sur **Next**.
5. Dans _Server Selection_ :  
   - Sélectionner un serveur (exemple : **SRV-DHCP**).  
   - Cliquer sur **Next**.
6. Dans _Server Roles_ :  
   - Cocher **DNS Server**.  
   - Une fenêtre s’ouvre :  
     - Cocher **Include management tools (if applicable)**.  
     - Cliquer sur **Add Features**.  
   - Cliquer sur **Next**.
7. Dans _Features_, cliquer sur **Next**.
8. Dans _DNS Server_, cliquer sur **Next**.
9. Dans _Confirmation_, cliquer sur **Install**.

---

## :three: Configuration du serveur DNS

### 1. Créer une zone de recherche directe (Domaine → Adresse IP)

1. Ouvrir l’application **DNS**.  
2. Aller dans **SRVWIN-01-AD-DHCP-DNS**.
3. Faire un clic droit sur **Forward Lookup Zones** et sélectionner **New Zone...**.
4. Dans _New Zone Wizard_ :  
   - Cliquer sur **Next**.
5. Dans _Zone Type_ :  
   - Cocher **Primary zone**.  
   - Cliquer sur **Next**.
6. Dans _Zone Name_ :  
   - Définir un nom de domaine: **Ekoloclast.local** 
   - Cliquer sur **Next**.
7. Dans _Zone File_ :  
   - Créer un fichier de zone en utilisant votre nom de domaine local suivi du suffixe ".dns" (exemple : **Ekoloclast.local.dns**).  
   - Cliquer sur **Next**.  
   - Les fichiers de zones sont généralement créés dans le dossier :  
     `C:\Windows\system32\dns`.
8. Dans _Dynamic Update_ :  
   - Cocher **Do not allow dynamic updates** si aucun Active Directory n’est installé.  
   - Cliquer sur **Next**.
9. Terminer la création en cliquant sur **Finish**.

---

### 2. Créer une zone de recherche inversée (Adresse IP → Domaine)

1. Faire un clic droit sur **Reverse Lookup Zones** et sélectionner **New Zone...**.
2. Dans _New Zone Wizard_ :  
   - Cliquer sur **Next**.
3. Dans _Zone Type_ :  
   - Cocher **Primary zone**.  
   - Cliquer sur **Next**.
4. Dans _Reverse Lookup Zone Name_ :  
   - Cocher **IPv4 Reverse Lookup Zone** 
   - Cliquer sur **Next**.  
   - Indiquer l’ID réseau dans **Network ID**: **172.24.0**
5. Dans _Zone File_ :  
   - Windows Server crée par défaut un fichier de zone basé sur l’ID réseau inversé suivi du suffixe **"in-addr.arpa.dns"**: **172.20.0.in-addr.arpa.dns**).  
   - Cliquer sur **Next**.
6. Dans _Dynamic Update_ :  
   - Cocher **Do not allow dynamic updates** si aucun Active Directory n’est installé.  
   - Cliquer sur **Next**.
7. Terminer la création en cliquant sur **Finish**.
