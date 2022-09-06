# Careot

Careot est une application mobile de suivi diététique basée sur Flutter et Firebase.

Jetez un oeil à [notre site](https://les-crepes.github.io/) pour une présentation de l'application

## Infrastructure

Nous utilisons Flutter pour l'application et trois services Firebase:

-   Storage: afin de stocker les fichiers
-   Authentication: afin d'authentifier nos utilisateurs
-   Firestore: afin de stocker nos données au format NoSql

![Our Tech Stack](.github/architecture.drawio.svg)

## Installation

Si vous voulez télécharger notre dernière release, vous pouvez la trouver dans l'[onglet release](https://github.com/les-crepes/CAREOT_APP/releases) sur GitHub.

### Android

1.  Téléchargez le dernier APK sur votre téléphone
2.  Autorisez votre explorateur de fichier à utiliser des fichiers `.apk`
3.  Installez l'application depuis là où vous l'avez téléchargé

## Guides de démarrage rapide

Si vous voulez directement construire l'application, il vous faudra installer la dernière version de Flutter.

### Build

1.  Installez [Flutter](https://docs.flutter.dev/get-started/install)
2.  Clonez notre repository
3.  `cd CAREOT_APP/`
4.  `flutter pub get`
5.  `flutter build apk --release`

### Test

Afin de respecter nos conventions de codage il faudra passer les commandes:

-   `flutter analyze`
-   `flutter test`

### Contribution

Si vous voulez contribuer à notre projet, il faudra effectuer un fork de notre repository et suivre les étapes ci-dessous:

1. Sélection le projet Github, prendre ou ajouter une tâche dans l'onglet TODO.
2. Créer un issue dans le repository correspondant
3. S'assigner à l'issue et ajouter les tags nécessaires (frontend, backend, bug, ehancement etc...)
4. Créer une branche associée à l'issue (petit bouton dans issue: create branch)
5. Charger la branche en local (copier la commande fournie par l'utilitaire)
6. Réaliser les modifications
7. Lancer les tests en local
8. Après validation, push sur la nouvelle branche dans la remote origin.
9. Créer une Pull Request et attendre un review d'un pair
10. Supprimer la branche après la fusion avec la branche principale (main)

Pour plus d'informations, vous pouvez consulter notre [cahier des charge](https://github.com/les-crepes/.github/blob/main/cahier_charge.md)

### Documentation

#### Flutter

Afin de débuter avec le développement de flutter il faut se référer à la [documentation en ligne](https://docs.flutter.dev/), qui propose des conseils, les références API ainsi que des examples.

#### Firebase

Afin de travailler avec la base de donnée noSql: [Documentation FireStore](https://firebase.google.com/docs/firestore/)
Afin de travailler avec le service d'identification: [Documentation Authentication](https://firebase.google.com/docs/auth/flutter/start)
Afin de travailler avec les fichiers: [Documentation Storage](https://firebase.google.com/docs/storage/flutter/start

### Structures

#### API

Comme nous utilisons Firebase, nous n'avons pas d'API. Cependant, nous avons une structure similaire qui permet de traiter les données.

Afin de travailler sur les données (CRUD et autre), nous utilisons une interface par type de donnée qui nous permet de changer de services rapidement. Par exemple, nous avons une classe FirebaseMessage qui implémente l'interface IMessage. De cette manière, si on utilisait un autre service, par exemple atlasDB nous pourrions créer la classe AtlasdbMessage.

Exemple pour utiliser l'API Firebase dans notre application.

```
IMessage messageApi = FirebaseMessage();

messageApi.createMessage();
messageApi.readMessage();
messageApi.updateMessage();
messageApi.deleteMessage();
messageApi.implementNewBadassFunctions(with, crazy, parameters);
...

```

#### Frontend

Nous utilisons les providers pour séparer la logique de l'interface.
