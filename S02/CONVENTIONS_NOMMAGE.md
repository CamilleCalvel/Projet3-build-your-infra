# Nom de domaine FQDN

| Domaine                   |
|---------------------------|
| ekoloclast.local          |

## OU
| Localisation? | Nom Département ou Ensemble logique | Niveau (Optionnel?) |
|---------------|-------------------------------------|---------------------|
| Paris20       | Communication                      |                     |

**Exemple** : `paris20-communication`  


---

# Groupes de sécurité

| Indicateur Groupe | Portée | Gamme    | Secteur/Fonctionnalité   |
|-------------------|--------|----------|--------------------------|
| group             | L/G    | pc/us/fc | mktg/comm/...            |

**Exemple** : `group-L-pc-dsi`

---

# Ordinateurs/Noms des équipements

| Nom Équipement (FR --> EN) / Composé en capital de 3 lettres représentant le nom équipement + 3 lettres représentant OS/type/marque d'équipement  | Numéro | Département/fonction |
|----------------------------|--------|-------------|
| Smartphone                 | 01    | comm        |
| Serveur --> Server         |        |             |
| Switch                     |        |             |
| Routeur --> Router         |        |             |
| Répéteur --> Repeater       |        |             |
| Pare-feu --> Firewall       |        |             | 

> liste d'exemples incomplète pour les équipement, à enrichir. Pour ce qui est des équipements essentiels en DSI, comme serveur, établir une limite de numérotation aorès laquelle on considère que l'équipement fait > partie d'une autre zone géographique
> Pour les serveurs par exemple, une numérotation inférieure à 20 correspon à l'emplacement géographique "Paris". Au delà, la numérotation est réservée pour un potentiel autre lieu géographique

**Exemple** : `SRVWIN-01-AD-DHCP-DNS`

---

# Utilisateurs

| Nom    | Prénom | Département    |
|--------|--------|----------------|
| Taiev  | Olga   | Communication  |

**Exemple** : `taiev-ol-comm`  

*Gestion des invités/utilisateurs temporaires? Gestion des homonymes?*

---

# GPO

| Cible                     | Stratégie             | Numéro ou Version |
|---------------------------|-----------------------|-------------------|
| marketing (+nom domaine?) | empêcher accès terminal | 001               |

**Exemple** : `mktg-noterminal-001`

---

# Noms des départements

| Département                           | Code  |
|---------------------------------------|-------|
| Communication                         | Comm  |
| Direction Financière                  | DFin  |
| Direction Générale                    | DG    |
| Marketing                             | Mktg  |
| Direction des Systèmes d'Information  | DSI   |
| Recherche et Développement            | RD    |
| Ressources Humaines                   | RH    |
| Services Généraux                     | SG    |
| Service Juridique                     | SJuri |
| Ventes et Développement Commercial    | VDC   |
