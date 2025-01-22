


> Configurer notre nouvelle machine : Changement de nom pour correspondre à notre convention de nommage et intégrer la machine dans le réseau à l'adresse 172.24.0.10

````Rename-Computer -NewName "SRVWIN-07-WSUS" -Force -Restart````

### Installer un rôle tel que déjà décrit pour les précédents rôles à installer 

À partir du Server Manager, installe le rôle Windows Server Update Services.
Valide les fonctionnalités supplémentaires qui vont s'ajouter automatiquement.
Ensuite, sélectionne WID Connectivity et WSUS Service.
Indique le dossier que tu as créer pour l'emplacement du stockage des mises à jour.

Dans notre cas nous avons créé le dossier à la racine du disque C:  C:/WSUS

> L'installation peut être longue et se complète par un "post-deployment configuration" (drapeau jaune dans l'interface)


Termine l'installation et redémarre le serveur.




### Configurer WSUS en tant que service

Ensuite, dans la fenêtre de gauche, vas dans WSUS.


Si tu a lancé l'assistant :

Décoche la case Yes, I would like to join the Microsoft Update Improvement Program
Laisse sélectionné la case Synchronize from Microsoft Update
Ne mets pas de proxy
À la fin, clic sur Start Connecting. Cette action peut être longue (entre 10 et 20 min) !
Si cela ne fonctionne pas, vérifier la connexion internet
Après, sélectionne les languesEnglish et French
Dans la fenêtre d'après, sélectionne les produits pour lesquels tu souhaites avoir des mises à jour. Ici tu peux choisir parmi les produits Windows 10 et les serveurs
Pour les classifications laisse les choix par défaut
Pour la synchronisation, choisi 4 synchronisations par jour, à partir de 2h.
Enfin coche la case Begin initial synchronization et clic sur `Finish
