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

## Étapes d'exécution 

### 1. Créer la base de données

Ouvrez votre terminal **PostgreSQL (`psql`)** ou **pgAdmin**, puis exécutez la commande suivante :

```sql
CREATE DATABASE kadea_chat_db;
```

### 2. Exécuter le fichier d'initialisation SQL

Une fois la base de données créée, vous devez exécuter le fichier `kadea_chat_db.sql` afin de créer les différentes tables, contraintes et relations.

#### Avec pgAdmin

1. Ouvrez **pgAdmin**.
2. Connectez-vous à votre serveur PostgreSQL.
3. Sélectionnez la base de données `kadea_chat_db`.
4. Ouvrez le **Query Tool**.
5. Ouvrez le fichier `schema.sql` (ou `database_dump.sql`).
6. Exécutez le script avec **F5**.

#### Avec le terminal `psql`

```bash
psql -U postgres -d kadea_chat_db -f kadea_chat_db.sql
```

> **Remarque :** si votre configuration PostgreSQL utilise un autre utilisateur, remplacez `postgres` par le nom de votre utilisateur PostgreSQL.

---

## Modèle de données — Draw.io

Le modèle de données complet est disponible au format **Draw.io**. Il contient :

* Le dictionnaire de données
* Le MCD (Modèle Conceptuel des Données)
* Le MLD (Modèle Logique des Données)

**[Consulter le fichier Draw.io en lecture seule](https://app.diagrams.net/#G1ln482dgjjn96XQLPuMOZVIQ2zKahFC7k#%7B%22pageId%22%3A%225gq9YktDmbHNNwszc5ET%22%7D)**


---

## Organisation du fichier Draw.io

Conformément au cahier des charges, le fichier `.drawio` est organisé en **3 onglets distincts**.

### Onglet 1 — Dictionnaire de données

Cet onglet présente un tableau exhaustif décrivant chaque entité et ses attributs :

* Nom table
* Nom des attributs
* Types de données PostgreSQL
* Taille
* Contraintes 
* Description
* Obligatoire

---

### Onglet 2 — MCD — Modèle Conceptuel des Données

Le MCD présente une vue conceptuelle de la base de données.

Il représente notamment :

* Les entités `USERS`, `CONVERSATIONS` et `MESSAGES`
* Les associations `APPARTENIR`, `ENVOYER` et `RECEVOIR`
* Les différentes cardinalités :

  * `0,N`
  * `1,N`
  * `1,1`

---

### Onglet 3 — MLD — Modèle Logique des Données

Le MLD présente le schéma relationnel détaillé de la base de données.

Il met notamment en évidence :

* Les différentes tables
* Les types de données PostgreSQL
* Les clés primaires (**PK**)
* Les clés étrangères (**FK**)
* Les relations entre les tables

Les principaux types PostgreSQL utilisés sont notamment :

```text
BIGSERIAL
TIMESTAMPTZ
VARCHAR
BOOLEAN
```

---

## Structure du dépôt

```text
kadea-chat-db/
│
├── kadea_chat_db.sql             # Script SQL de création des tables et contraintes
├── kadea_chat_model.drawio       # Modèle Draw.io (Dictionnaire, MCD et MLD)
└── README.md                     # Documentation du projet
```

---

## Technologies utilisées

* **PostgreSQL** — Système de gestion de base de données
* **SQL** — Langage de définition et manipulation des données
* **pgAdmin** — Interface d'administration PostgreSQL
* **Draw.io** — Modélisation du système d'information

---

## Contexte du projet

Ce projet a été développé dans le cadre des **projets de formation Kadea Academy**.

Il a pour objectif de mettre en pratique les concepts de :

* Modélisation des données
* Conception d'une base de données relationnelle
* SQL et PostgreSQL
* Clés primaires et étrangères
* Contraintes d'intégrité
* MCD et MLD
* Documentation technique

---

## Joel MITONDO

**Projet réalisé dans le cadre de la formation Kadea Academy.**

