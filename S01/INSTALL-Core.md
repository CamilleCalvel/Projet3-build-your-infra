# Configuration du Core

## 1. Configuration IP static dans le réseau interne

![Capture d'écran 2024-12-08 145238](https://github.com/user-attachments/assets/e4c193ef-cbd8-4d85-90a1-c5d202bd7148)

## 2. Configuration DNS
![Capture d'écran 2024-12-08 145245](https://github.com/user-attachments/assets/c53e8003-4c32-4922-9821-a46cc91f2c69)
![Capture d'écran 2024-12-08 145255](https://github.com/user-attachments/assets/cf10f072-55f9-41e2-9949-1578dd3d87c1)

## 3. Configuration du nom du serveur en suivant la nomenclature

![Capture d'écran 2024-12-08 150207](https://github.com/user-attachments/assets/7815f4cb-abb4-4f8d-a647-1e4ad2c34501)
- Redemarrer la machine

# Ajout au domaine Active Directory ekoloclast.local

![Capture d'écran 2024-12-08 150531](https://github.com/user-attachments/assets/581af956-1887-4ec6-a1d7-c8b64ad79a22)
- Redemarrer la machine

# Installer le rôle Active Directory  
![Capture d'écran 2024-12-08 151104](https://github.com/user-attachments/assets/4b622d01-5a66-4f67-9eb3-1389f589622a)

# Ajouter le Windows Core en Domaine Controller de ekoloclast.local

## 1. Dans le windows Core
- Installer le  Domaine Controller
![Capture d'écran 2024-12-08 151412](https://github.com/user-attachments/assets/df6bd629-0726-45c6-a26b-dbbbb7381eb4)  
Attention ! Changer le / en \ : ekoloclast.local\Administrator

- Renseigner le mot de passe  

![Capture d'écran 2024-12-08 151524](https://github.com/user-attachments/assets/58efaf71-65db-43ad-8ea0-2daafc4fe04c)

![Capture d'écran 2024-12-08 151616](https://github.com/user-attachments/assets/8651e168-ccb6-42fb-bc20-71b860cddd8e)
Choisir l'option: A (Yes to All)
![Capture d'écran 2024-12-08 151648](https://github.com/user-attachments/assets/3a418448-ce57-4a77-83ad-2b8038747648)
- Suite à cette fênetre, la machine va redémarrer

- Vérification de l'ajout du core en tant que domain controler au domain ekoloclast.local
![Capture d'écran 2024-12-08 152025](https://github.com/user-attachments/assets/9dc4ee96-3121-4759-9e0e-2da9002eaf51)
WoW It's Wonderfull !!! (accent Français)

## 2. Dans le Windows Serveur graphique
- Dans le windows-server qui contient l'AD ajouter le Windows Core dans la liste des servers
- Dashboard: Option 3 Add other servers to manage
![Capture d'écran 2024-12-08 152903](https://github.com/user-attachments/assets/29cc80f8-89e3-440d-b4c5-98d5812ad85d)


