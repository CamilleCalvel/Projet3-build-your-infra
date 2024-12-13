# Création de règles de pare-feu sur PfSense

<details><summary><h1>:one: Bloquer le trafic sortant de tous les VLANs vers le VLAN12 (contenant les serveurs)</h1></summary>

- Se rendre sur **PfSense** -> **Firewall** -> **Rules**.  
- Ajouter une nouvelle règle :  
  ```plaintext
  Action : Block
  Interface : VLAN[x]
  Protocol : Any
  Source : VLAN[x] subnets
  Destination : VLAN12 subnets
  Description : Bloquer l'accès VLAN[x] -> VLAN12
  ```
![Part1-0](https://github.com/user-attachments/assets/04d26146-4c6d-4811-a0fe-f78e9c9c9fe9)  
  
![Part1-2](https://github.com/user-attachments/assets/5fcf6edc-a080-4e53-872a-1cb2ffa14d5f)  

  ![Part1-1](https://github.com/user-attachments/assets/4bc856c7-1b6c-45cf-a297-91f8eaa1179e)

</details>

---  

<details><summary><h1>:two: Bloquer le trafic sortant de tous les VLANs vers le VLAN11 (contenant la DMZ)</h1></summary>  
   
- Se rendre sur PfSense -> Firewall -> Rules.  
- Ajouter une nouvelle règle :  
  ```plaintext
  Action : Block
  Interface : VLAN[x]
  Protocol : Any
  Source : VLAN[x] subnets
  Destination : VLAN11 subnets
  Description : Bloquer l'accès VLAN[x] -> VLAN11
  ```


![Part1-0](https://github.com/user-attachments/assets/04d26146-4c6d-4811-a0fe-f78e9c9c9fe9)  
  
![Part1-2](https://github.com/user-attachments/assets/5fcf6edc-a080-4e53-872a-1cb2ffa14d5f)  

  ![Part2-1](https://github.com/user-attachments/assets/0d63433d-c275-4daa-ba4a-e0749a2f4f4b)

</details>

---  

<details><summary><h1>:three: Autoriser le trafic sortant depuis VLAN12 vers Internet</h1></summary>  
  
- Se rendre sur PfSense -> Firewall -> Rules.  
- Ajouter une nouvelle règle :  
  ```plaintext
  Action : Pass  
  Interface : VLAN12  
  Protocol : Any  
  Source : VLAN12  
  Destination : Any  
  Description : Autoriser le trafic sortant depuis VLAN12 vers Internet  
  ```
![Part1-0](https://github.com/user-attachments/assets/04d26146-4c6d-4811-a0fe-f78e9c9c9fe9)  
  
![Part1-2](https://github.com/user-attachments/assets/5fcf6edc-a080-4e53-872a-1cb2ffa14d5f)  

  ![Part3-1](https://github.com/user-attachments/assets/c0b65d77-4403-4e0d-9f34-cb84688a7e9d)

</details>

---

# Mise en place de la synchronisation de l'annuaire LDAP avec GLPI

<details><summary><h1></h1></summary>

## Dans l'interface GLPI :

- Aller dans **authentification**.
- Puis dans **annuaires**.
- Enfin **ajouter un nouvel annuaire**.


<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/glpi_ajout_ldap.png" alt="Pictures" width="800" >
</p>

- Entrer un nom d'annuaire, choisir serveur par défaut, et actif, rentrer l'adresse ip du serveur du **controlleur de domaine** et le port par défaut si on utilise pas TLS.

### Connection filter : 
Comment aller trouver des attributs dans l'interface graphique ? 

Les attributs les plus couramment utilisés pour les filtres LDAP incluent :

- **sAMAccountName** : Nom d'utilisateur (anciennement utilisé dans NT4, mais toujours largement utilisé).
- **userPrincipalName (UPN)** : Nom d'utilisateur complet dans le format utilisateur@domaine.
- **mail** : Adresse e-mail.
- **cn** : Nom commun (souvent utilisé pour stocker le nom complet).
- **uid** : Identifiant unique (souvent personnalisé dans certains environnements).
- **memberOf** : Groupe d'appartenance.
- **objectClass** : Type d'objet (par exemple, user, computer, group).

#### Lister les utilisateurs avec un filtre spécifique :

```powershell
Get-ADUser -Filter {sAMAccountName -like "admin"} -Properties *
```

#### Lister les utilisateurs d'un groupe spécifique

```powershell
Get-ADGroupMember -Identity "GroupName"
```
#### Cette commande renverra tous les objets dans Active Directory avec tous leurs attributs.

```powershell
Get-ADObject -Filter * -Properties *
```

le filtre utilisé par IT-connect :

(&
  (objectClass=user)
  (objectCategory=person)
  (!(userAccountControl:1.2.840.113556.1.4.803:=2))
)


* & (ET logique) : Le & indique que toutes les conditions qui suivent doivent être vraies (AND logique). Autrement dit, un utilisateur devra satisfaire toutes les conditions suivantes pour être retourné par la requête.
* objectClass=user : Cette condition filtre les objets pour n'inclure que ceux dont l'attribut objectClass est égal à user.
* objectCategory=person : Cette condition filtre les objets pour inclure uniquement ceux dont l'attribut objectCategory est égal à person.
* (!(userAccountControl:1.2.840.113556.1.4.803:=2)) : Cette condition est un peu plus complexe. Elle utilise l'opérateur de négation ! et la syntaxe de recherche de flags sur l'attribut userAccountControl. userAccountControl est un attribut qui contient des informations de contrôle sur le compte utilisateur, telles que son état (actif ou verrouillé), son expiration, etc. La partie 1.2.840.113556.1.4.803:=2 fait référence à un test de bit (un filtre LDAP étendu dans Active Directory) qui vérifie si un certain bit de l'attribut userAccountControl est défini. Le bit 2 dans userAccountControl correspond au compte désactivé. Si ce bit est défini (userAccountControl & 2), cela signifie que le compte utilisateur est désactivé. La négation !(...) permet de s'assurer que seuls les utilisateurs actifs (c'est-à-dire ceux dont le compte n'est pas désactivé) sont inclus dans les résultats.
  
Donc, cette condition exclut tous les utilisateurs dont le compte est désactivé.

### BaseDN 

Base Distinguished Name , spécifie à partir de quel point dans la hiérarchie de l'annuaire LDAP la recherche doit commencer

### Use Bind : choisir YEs (explication IT-connect)

le "bind" est le processus d'établissement d'une connexion sécurisée et authentifiée entre le client et le serveur LDAP. Lorsque ce processus est effectué, l'annuaire LDAP sait qui est l'utilisateur qui tente de se connecter et quel niveau d'accès cet utilisateur a. Le bind permet d'effectuer des recherches ou d'autres opérations sur l'annuaire en fonction des droits de l'utilisateur.
Si "Use bind" est activé : La connexion LDAP doit être authentifiée, donc un nom d'utilisateur et un mot de passe doivent être spécifiés.

### RootDN (for non anonymous binds)

RootDN (for non anonymous binds): cn=Administrator, cn=Users, dc=ekolocast, dc=local
Indique le chemin nécessaire pour retrouver l'utilisateur souhaité pour cette authentification. 
"Bind" est le processus par lequel un client LDAP s'authentifie auprès du serveur LDAP (avec ou sans mot de passe).
"Use bind" indique si l'authentification doit se faire de manière anonyme ou authentifiée.
"RootDN" spécifie le DN (Distinguished Name) utilisé pour effectuer un bind authentifié avec des droits élevés, généralement un administrateur.

### Password :  remplir avec le mdp souhaité

### Login Field 

Le Login Field spécifie l'attribut LDAP qui sera comparé avec le nom d'utilisateur saisi lors de l'authentification dans l'application (comme GLPI ou toute autre application utilisant LDAP pour l'authentification).
Par exemple, lorsqu'un utilisateur tente de se connecter, l'application va chercher dans l'annuaire LDAP pour voir si l'attribut spécifié dans le Login Field correspond à l'identifiant de l'utilisateur.
SamAccountName (recommandé pour Active Directory)
car cet attribut permet de faire référence à l'identifiant de l'utilisateur.

#### Pourquoi :
Cet attribut contient le nom d'utilisateur unique dans Active Directory. Par exemple, si l'utilisateur "John Doe" utilise jdoe pour se connecter, son sAMAccountName sera jdoe.
Avantages :
C'est généralement ce que les utilisateurs saisissent pour se connecter.
Court et pratique.
Exemple :
Utilisateur : Administrator
Attribut SamAccountName : administrator
userPrincipalName

#### Pourquoi :
C'est l'attribut qui contient l'UPN (User Principal Name), souvent au format d'une adresse e-mail comme jdoe@ekoloclast.local.
Quand le choisir :
Si vos utilisateurs se connectent en utilisant un format d'e-mail.
Exemple :
Utilisateur : Administrator
Attribut userPrincipalName : administrator@ekoloclast.local


<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/annuaireldap_glpi_filled.png" alt="Pictures" width="800" >
</p>

### Le synchronization field 

Le synchronization fiedl rempli par objectGuid pointera sur un id unique peu importe si le nom utilisateur change (donc en cas de synchronisation).


Une fois rempli, cliquer sur Add.

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/apres_add_glpi.png" width="800" >
</p>

Tester dans Setup  > Authentification > Cliquer sur L'annuaire créé > Choisir Test

<p align="center">
<img src="https://github.com/WildCodeSchool/TSSR-2409-VERT-P3-G3-build-your-infra/blob/main/Ressources/Pictures/capture_glpiLdap_test.png" width="800" >
</p>

</details>

---

# :incoming_envelope: Création d'un ticket via un compte utilisateur de l'AD

<details><summary><h1>:one: Connexion à glpi avec un compte utilisateur</h1></summary> 
  
- Renseigner:
  - Nom d'utilisateur: SamAccountName (prenom + nom) 
  - Mot de passe: Se reférer à la convention sur miro
  - LoginSource: Annuaire Ekoloclast
<img src="https://github.com/user-attachments/assets/26721233-1dc0-427d-9944-7ccce9654c0e" width="700">

</details>

---

<details><summary><h1>:two: Créer un ticket client</h1></summary>  
  
- Interface GLPI du client: Créer un ticket en cliquant sur le bouton **Create a Ticket**  
<img src="https://github.com/user-attachments/assets/b2640eb4-fb43-4242-a72b-ed22f916a483" width="700">
  
- Informations à renseigner par l'utilisateur:  
    - Type: Incident ou Request
    - Niveau d'Urgence
    - Watchers: Destinataires du ticket
    - Titre
    - Description
<img src="https://github.com/user-attachments/assets/58e15be9-1e4e-4aec-ae42-7a6ce45572e4" width="500">  

- Envoyer le ticket en appuyant sur **Submit Message**
- Une fenêtre s'affiche pour indiquant que le ticket a bien été crée 
<img src="https://github.com/user-attachments/assets/8771b6cb-bdb7-4926-9f8a-dc08b8fe36c3" width="350">

</details>

---

<details><summary><h1>:three: Résolution du ticket par l'administrateur</h1></summary> 

- A partir du dashboard ou de l'onglet Assistance, sélectionner **Tickets**  
<img src="https://github.com/user-attachments/assets/7c3c69bc-2b32-4842-8014-d749de5b0f3f" width="700">

- Sélectionner le ticket à traiter (si plusieurs tickets faire en fonction du niveau de priorité)  
<img src="https://github.com/user-attachments/assets/2541d6a9-5245-47cd-9f3e-745b7ca9311e" width="700">

- Répondre à la demande de l'utilsateur en cliquant sur le bouton **Answer**  
<img src="https://github.com/user-attachments/assets/8de74666-c966-4ca9-891e-36c9dddb7989" width="700">

</details>

