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

### Lister les utilisateurs avec un filtre spécifique :

```powershell
Get-ADUser -Filter {sAMAccountName -like "admin"} -Properties *
