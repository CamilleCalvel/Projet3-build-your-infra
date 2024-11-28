# Guide d'Installation des Rôles AD et DHCP

## 1. Installation du rôle Active Directory (AD)

1. **Ouvrir Server Manager**.
2. Dans le _Dashboard_, cliquer sur **Add roles and features**.
3. Dans _Before You Begin_, cliquer sur **Next**.
4. Dans _Installation Type_ :  
   - Cocher **Role-based or feature-based installation**.  
   - Cliquer sur **Next**.
5. Dans _Server Selection_ :  
   - Sélectionner un serveur (exemple : **SRV-DHCP-DNS**).  
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
- Un message apparaît : _"Configuration required. Installation on SRV-DHCP-DNS."_  
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

## 2. Installation du rôle DHCP

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
