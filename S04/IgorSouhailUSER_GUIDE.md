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


