# Installation de FreePBX  
  
## :one: Installation sur serveur Debian  
  
➡️ Créer une machine serveur Debian  
  
➡️ Éditer le fichier `/etc/hosts` avec la commande `nano`  
  
➡️ Ajouter après la ligne "10.0.0.2 debian" la ligne suivante : adresse.ip.du.serveur NomDuServeur (dans notre cas : `172.24.0.13 SRVLIN-11-VOIP`)  
  
![image](https://github.com/user-attachments/assets/985d9b30-3b0b-4f30-be2f-fe7bd7e3fd6d)  
  
➡️ Se déplacer dans le fichier /tmp avec la commande : `cd /tmp`  
  
➡️ Télécharger le script d'installation avec la commande :  
`wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh  -O /tmp/sng_freepbx_debian_install.sh`  
  
➡️ Exécuter le script avec la commande : `bash /tmp/sng_freepbx_debian_install.sh`  
  
Une fois le script exécuté, l'installation commence. Patienter une trentaine de minutes que l'installation se termine. 
  
![image](https://github.com/user-attachments/assets/a100d541-43fa-4c1d-adb0-903604f7cc19)  
  
Une fois l'installation terminée, nous pouvons accéder à l'interface web de FreePBX en tapant dans la barre de recherche de la machine client Windows, l'adresse IP du serveur Debian : `http://172.24.0.13`  
  
## :two: Configuration sur interface web  
  
➡️ Sur l'interface web, se connecter en root avec le mot de passe associé et indiquer une adresse mail pour les notifications, puis cliquer sur `Setup System`  
  
➡️ Cliquer sur `FreePBX Administration` et se reconnecter en root  
  
![image](https://github.com/user-attachments/assets/1ab14dd0-c3bf-4670-bc74-8fada10fd268)  
  
➡️ Cliquer sur `Skip` sur la fenêtre "Welcome to your new FreePBX Server" pour sauter l'activation du serveur et toutes les offres commerciales qui s'affichent  
  
➡️ Paramétrer la langue de votre choix  
  
➡️ A la fenêtre d'activation du firewall, cliquer sur `Abort`  
  
➡️ A la fenêtre de l'essai de SIP Station, cliquer sur `Not Now`  
  
Nous arrivons sur le dashboard qui ressemble à ceci :  
  
![image](https://github.com/user-attachments/assets/d93f4585-0b64-4916-83d3-215e7253b89b)  
  
➡️ Cliquer sur `Apply Config` pour sauvegarder les choix qui ont été faits précédemment  
  
## :three: Activation du serveur  
  
➡️ Aller dans le menu `Admin` puis `System Admin`  
  
➡️ Cliquer sur `Activation` puis `Activate`  
  
➡️ Dans la fenêtre qui s'affiche, cliquer sur `Activate`  
  
![image](https://github.com/user-attachments/assets/39a6851e-a135-4470-b379-76365ecd9f07)  
  
➡️ Entrer une adresse email et remplir les champs "Your Name" et "Password"  
  
➡️ Une fenêtre s'affiche avec différents champs à remplir :  
  
- `Physical lab` (optionnel) : entrer le nom de votre domaine  
  
- `Which best describes you` : choisir `I use your products and services with my Business(s) and do not want to resell it`  
  
- `Do you agree to receive product and marketing emails from Sangoma ?` : cocher `No`  
  
➡️ Cliquer sur `Create`  
  
➡️ Dans la fenêtre d'activation, cliquer sur `Activate` et attendre que l'activation se fasse  
  
![image](https://github.com/user-attachments/assets/5af5a5b3-9bf5-48ee-b8ea-daf2d4f1009a)  
  
➡️ Des fenêtres de publicités s'affichent, cliquer sur `Skip` pour chaque fenêtre  
  
![image](https://github.com/user-attachments/assets/5334e0ab-1f6c-48ae-8f7f-6f87a8c4ee94)  
  
## :four: Update des modules du serveur  
  
Après avoir cliqué sur `Skip` sur les fenêtres de publicité, une fenêtre de mise-à-jour des modules va s'afficher automatiquement. Si vous avez un bouton `Update Now`, cliquer dessus.  
  
## :five: Mise à jour du serveur Debian  
  
Mettre à jour le serveur Debian en CLI en tapant la commande : `apt update && apt upgrade`  
  
Une fois les mises à jour effectuées, redémarrer le serveur avec la commande : `init 6`  
  
## :six: Installation de 3cxphone sur les postes clients  
  
Pour commencer à utiliser la téléphonie sur IP avec FreePBX, installer, sur deux machines clientes, le logiciel `3cxphone` via le lien suivant : https://3cxphone.software.informer.com/download/  
  
![image](https://github.com/user-attachments/assets/5f256fbd-6a9f-4b34-b590-f575e0a48ff7)



  

 
  


