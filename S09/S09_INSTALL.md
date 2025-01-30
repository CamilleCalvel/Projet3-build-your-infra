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




  

 
  


