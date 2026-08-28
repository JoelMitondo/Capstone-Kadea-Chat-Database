# Capstone-Kadea-Chat-Database
Projet de conception et de déploiement d'une base de données relationnelle robuste pour Kadea Chat, une application de messagerie instantanée privée et de groupe.

---

## Présentation

**Kadea Chat** est une solution de messagerie instantanée conçue pour gérer des échanges de messages sécurisés en temps réel. 

Ce projet couvre l'ensemble de la modélisation de la base de données relationnelle sous PostgreSQL :
- Gestion des utilisateurs et profilage (vérification d'âge >= 18 ans, statuts en ligne).
- Support des discussions privées (2 personnes) et de groupe (multi-participants).
- Gestion fine du rôle des participants (`admin`, `member`).
- Traçabilité et distribution des messages avec accusés de réception et de lecture (`sent`, `delivered`, `read`).

---

## Technologies Utilisées

* **SGBD :** [PostgreSQL 18](https://www.postgresql.org/)
* **Gestionnaire SQL :** [pgAdmin 4](https://www.pgadmin.org/)
* **Modélisation & Schémas :** [Draw.io](https://app.diagrams.net/)
* **Langage :** SQL (DDL, DML, Contraintes de Check, Triggers & Clés étrangères)

---

## Modélisation

La base de données s’articule autour de 7 tables clés :

### Entités principales :
1. **`users`** : Stocke les informations des utilisateurs (nom, prénom, mail, date de naissance, bio, statut en ligne, horodatages).
2. **`conversations`** : Centralise les salons de discussion (privés ou groupes avec titre).
3. **`messages`** : Contient le corps des messages, leur type (`text`, `media`), la date d'envoi et la clé de l'expéditeur (`user_id`).

### Tables de référence & types :
4. **`conversation_types`** : Définit la nature de la discussion (`private` ou `group`).
5. **`message_status`** : Définit les étapes du cycle de vie d'un message (`sent`, `delivered`, `read`).

### Tables de liaison / association :
6. **`participants`** (Clé composée `user_id, conversation_id`) : Associe les utilisateurs aux conversations et précise leur rôle (`admin` ou `member`).
7. **`message_recipients`** (Clé composée `recipient_id, message_id`) : Suit le statut de remise et l'heure de lecture (`read_at`) pour chaque destinataire.

---

## Installation

Suivez ces étapes pour installer et initialiser la base de données sur votre environnement local :

### Prérequis
- PostgreSQL (v14+) et pgAdmin 4 installés sur votre machine.

### Étapes d'exécution :
1. **Cloner le dépôt GitHub :**
   ```bash
   git clone [https://github.com/votre-compte/kadea-chat-db.git](https://github.com/JoelMitondo/Capstone-Kadea-Chat-Database.git)
   cd kadea-chat-db
