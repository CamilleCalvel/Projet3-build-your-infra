# 📋 Mode d'emploi : Configuration des GPO  
>Prérequis  
Accès à un contrôleur de domaine avec Active Directory configuré.  
Utilisation de la Console de Gestion des Stratégies de Groupe (GPMC).  
Les ressources nécessaires (image pour le fond d'écran, configuration de plan d'alimentation).  
---
## :one: GPO - Configuration d’un Fond d’écran  
>Objectif :  
Définir un fond d’écran unique et uniforme pour tous les utilisateurs d’une OU.  

## Étapes :  
### 1. Ouvrir la Console GPMC :  

- Lancer gpmc.msc via le menu Démarrer ou la commande Exécuter (Win + R).  

### 2. Créer une nouvelle GPO :

- Clic droit sur l’OU ou le domaine souhaité.  
- Choisir Créer un objet GPO dans ce domaine et le lier ici.  
- Nommer la GPO (exemple : GPO - Fond d'écran).  
### 3. Modifier la GPO :

- Clic droit sur la GPO créée -> Modifier.   
### 4. Configurer le fond d’écran :  

- Naviguer jusqu’à :  
_Configuration utilisateur > Stratégies > Modèles d'administration > Bureau > Fond d'écran._
- Double-cliquer sur Fond d'écran de bureau.  
- Activer la stratégie :  
• Cocher Activé.  
• Spécifier le chemin UNC de l’image (exemple : \\Serveur\Partage\fond.jpg).  
• Style d’affichage : Choisir parmi Rempli, Centré, Adapté, etc.  
### 5. Lier la GPO à l’OU :  
 
- Associer la GPO à une OU contenant les utilisateurs concernés.  
### 6. Tester la configuration :   

- Exécuter gpupdate /force sur un poste client.  
- Vérifier que le fond d’écran s’applique.   
---  
### Note :  

Le fichier d’image doit être accessible via un chemin réseau UNC et les utilisateurs doivent avoir les permissions de lecture.  
En cas de problème, vérifier que l’accès réseau est correctement configuré.

---
## :two: GPO - Gestion de l’Alimentation
>Objectif :  
Uniformiser les paramètres d’alimentation des postes clients (mise en veille, arrêt de l’écran, etc.).
---

## Étapes :  
### 1. Ouvrir la Console GPMC :  

- Lancer gpmc.msc.  
### 2. Créer une nouvelle GPO :  

- Clic droit sur l’OU ou le domaine souhaité.  
- Choisir Créer un objet GPO dans ce domaine et le lier ici.  
- Nommer la GPO (exemple : GPO - Gestion alimentation).  
### 3. Modifier la GPO :  

- Clic droit sur la GPO créée -> Modifier.  
### 4. Configurer les options d’alimentation :  

- Naviguer jusqu’à :  
_Configuration ordinateur > Préférences > Panneau de configuration > Options d’alimentation._  
### 5. Créer une configuration :  

- Clic droit dans la fenêtre -> Nouveau -> Options d’alimentation.  
**- Action** :  
• Choisir Créer, Remplacer, ou Mettre à jour.  
**- Paramètres généraux** :  
• Sélectionner ou personnaliser un plan d’alimentation existant (Économie d’énergie, Utilisation normale, etc.).  
**- Paramètres avancés** :  
• Mise en veille (30 minutes sur secteur).  
• Arrêt de l’écran (15 minutes sur secteur).  
• Gestion du processeur (ex. utilisation minimale 5%, maximale 100%).  
### 6. Lier la GPO à l’OU :  

- Associer la GPO à une OU contenant les postes clients concernés.  
### 7. Tester la configuration :

- Exécuter gpupdate /force sur un poste client.  
- Vérifier que les options d’alimentation sont appliquées dans "Options d’alimentation" sur le poste.  
### Note :  
Cette GPO s’applique généralement à des ordinateurs (et non aux utilisateurs).
