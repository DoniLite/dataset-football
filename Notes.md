# Notes de contributions

Merci de participer à l'évolution du projet `DataSet Football` ce document comporte le journal de développement de l'ensemble des **fonctionnalités** , **corrections** , **tests**  ou **modifications** apportées au projet tout u long de son dveloppement à compter du `22 Novembre 2024`.

## Comment écrire dans ce journal ?

Le principe étant de permettre à tous les développurs travaillant sur ce projet de disposer des mêmes informations concernant toute action entreprise ou toute action à entreprendre durant tout le long du développemnt vous avez pour obligation de:

- **Renseigner la date d'écriture de votre journal avant sa rédaction**
- **Renseigner l'auteur du journal**
- **(optionel) renseigner une brève description ou une introducton après les deux informations fournies**
- **Lister les taches et les modifications efectuées avec des listes non ordonnées**
- **ajouter vos suggesions ou des `TODOS #[index]` à la fin de vos notes après les avoir lister sous un heading portant le titre (## TODOS)**

## Début du journal de développement

Ici débute la listes des historiques de modification du projet.

## Journal du 22/11/2024

## Auteur: [Doni Lite](https://github.com/DoniLite/)

Le journal qui suit comporte l'ensemble des modifications effectuées sur le projet avec des suggestions et des pratiques à adopter pour mettre en place un environnement de développement adapté

- Mise en place de drivers pour migrer la base de données MySQL vers PostgreSQL
- Mise à jour des modèles de labase de données pour corriger les erreurs de migrations
- installation du module `pytest` pour effectuer des tests unitaires
- installation du module `pdoc` pour la géération de documentation
- Mise en place de `Jupiter notebook` pour l'écriture de notes
- Refactoring du projet avec la migrationde quelques fonctions dans le package `utils` du projet

### TODOS #1

- **Executer `make install` pour mettre à jour votre projet avec les dépendences requises**
- **Créez une base de donnéés locale PostgreSQL pour vos test**

## Jornal du 24/11/2024

## Auteur [Doni Lite](https;//github.com/DoniLite/)

Résumé de l'ensemble des modifications et apports effectués en ce jour sur le projet

- Mise à jour des modèles de la base de donnéés et ajout de quelques modèles (en cours)
- Mise en place du package [championship](./championship/__init__.py) pour mieux séparer les différents sports à étingrer dans la dataset avec lien de scroll
- Mise à jour du notebook `data_test` et correction de quelques bugs
- ajout d'`alembic` pour gérer les migrations de la base de données

### TODOS #2

- **Ecrire les fonction de crawle dans les fichiers dédiés à chaque championat en vue de séparer la logique**
- **Chaque fonction destiné à un job de crawling doit recevoir deux paramètres principaux #1 `le driver` #2 `le lien à crawler` suivi de la logique**
-**Lorsque vous modifiez le Schema de la base de données assurez vous de rendre `optionnel` toutes les nouvelles entrées pour éviter des conflits de migrations**
- **Utiliser des alias sur les imports du package `championship` pour éviter les conflits**
- **refacto le code du module principal pour le rendrre plus modulaire en séparant les fonctions utilitaires du code principal**
