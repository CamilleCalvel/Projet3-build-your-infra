# Configuration de la machine et déploiement de WSUS

## Configurer la nouvelle machine

Pour configurer la machine, changez son nom pour qu'il corresponde à la convention de nommage et intégrez-la au réseau à l'adresse `172.24.0.10` :

```powershell
Rename-Computer -NewName "SRVWIN-07-WSUS" -Force -Restart
```

---

## Installer un rôle

Pour installer un rôle, procédez comme suit :

1. Utilisez le **Server Manager** pour installer le rôle **Windows Server Update Services**.
2. Validez les fonctionnalités supplémentaires qui seront ajoutées automatiquement.
3. Sélectionnez **WID Connectivity** et **WSUS Service**.
4. Indiquez le dossier créé pour l'emplacement de stockage des mises à jour.  
   Exemple : le dossier se trouve à la racine du disque C : `C:/WSUS`.

> **Note** : L'installation peut être longue et se termine par une "post-deployment configuration", signalée par un drapeau jaune dans l'interface.

Une fois l'installation terminée, redémarrez le serveur.

---

## Configurer WSUS en tant que service

1. Dans le volet de gauche, accédez à **WSUS**.

### Si l’assistant de configuration est lancé :

1. Décochez la case **Yes, I would like to join the Microsoft Update Improvement Program**.
2. Laissez sélectionnée la case **Synchronize from Microsoft Update**.
3. Ne configurez pas de proxy.
4. Cliquez sur **Start Connecting**. Cette action peut être longue (entre 10 et 20 minutes).  
   Si cela ne fonctionne pas, vérifiez la connexion internet.
5. Sélectionnez les langues **English** et **French**.
6. Dans la fenêtre suivante, sélectionnez les produits pour lesquels vous souhaitez des mises à jour, comme **Windows 10** et les **serveurs**.
7. Pour les classifications, laissez les choix par défaut.
8. Configurez 4 synchronisations par jour, à partir de 2h.
9. Cochez la case **Begin initial synchronization** et cliquez sur **Finish**.

