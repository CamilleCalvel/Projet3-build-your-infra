# Mise en place de la synchronisation de l'annuaire LDAP avec GLPI

## Dans l'interface GLPI :

- Aller dans **authentification**.
- Puis dans **annuaires**.
- Enfin **ajouter un nouvel annuaire**.
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


### Le synchronization field 

Le synchronization fiedl rempli par objectGuid pointera sur un id unique peu importe si le nom utilisateur change (donc en cas de synchronisation).


Une fois rempli, cliquer sur Add.

Tester dans Setup  > Authentification > Cliquer sur L'annuaire créé > Choisir Test

