# Création de règles de pare-feu sur PfSense

## :one: Bloquer le trafic sortant de tous les VLANs vers le VLAN12 (contenant les serveurs)

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
---
## :two: Bloquer le trafic sortant de tous les VLANs vers le VLAN11 (contenant la DMZ)
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

## :three: Autoriser le trafic sortant depuis VLAN12 vers Internet
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
