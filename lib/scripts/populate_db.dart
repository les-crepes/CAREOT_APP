import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/firebase_message.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/model/message.dart';
import 'package:pdg_app/model/user.dart';

final db = FirebaseFirestore.instance;
DateTime fisherDay = DateTime(2022, 9, 5, 17, 30);

User u1 = User(
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0795438759',
    birthDate: DateTime(1996, 10, 9),
    avs: '7561352485592',
    uid: 'FS3RqfWpeuVXcdZrTQJdBPfFbwV2',
    email: 'olivier.dancona@heig-vd.ch',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_olivier.jpeg?alt=media&token=0166b19f-428f-419d-b0d5-4b9b665e62f5');
User u2 = User(
    firstName: 'Chloé',
    lastName: 'Fontaine',
    phoneNumber: '0780002334',
    birthDate: DateTime(1998, 12, 8),
    avs: '7561352485592',
    uid: 'Zaf2afuSAGcicn5DziZTrr4MYCA2',
    email: 'chloe.fontaine@heig-vd.ch',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_chloe.jpg?alt=media&token=9195f8d5-e8ab-491b-9c61-3fe91ff1c9b3');
User u3 = User(
    firstName: 'Luca',
    lastName: 'Coduri',
    phoneNumber: '0770003445',
    birthDate: DateTime(1996, 12, 18),
    avs: '7561352485592',
    uid: 'PSCOEhz98TORfOb9BizGfjUA8hc2',
    email: 'luca.coduri@heig-vd.ch',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_luca.webp?alt=media&token=12aa7417-fd0c-41bf-8f80-7db9f16c9fc4');
User u4 = User(
    firstName: 'Nelson',
    lastName: 'Jeanrenaud',
    phoneNumber: '0766834556',
    birthDate: DateTime(2001, 9, 1),
    avs: '',
    uid: 'iKO7fJfMKgawEDtnd9Ll0kjBNBW2',
    email: 'nelson.jeanrenaud@heig-vd.ch',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_nelson.jpeg?alt=media&token=a5af4d67-1522-4355-a647-d29496809463');
User d1 = User(
    firstName: 'Claire',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '7561352485592',
    clientList: [u1.uid, u2.uid, u3.uid, u4.uid],
    phoneNumber: '0266634556',
    email: 'claire.emery@heig-vd.ch',
    uid: 'bZB6G7LbLSfp8lTPsh00fWxiHb03',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/claire.jpg?alt=media&token=f03c1b9a-b851-40dc-a3c5-a8b4b2afdb02');

Aftercare a1 = Aftercare(
    clientId: u1.uid,
    bmi: 12,
    weight: 14.0,
    startDate: DateTime.now(),
    comments: "commentaire",
    diagnostic: "diagnostic",
    documents: ['dfdf'],
    endDate: DateTime.now(),
    foodObjectives: "Manger plus, prendre du gras, suer de l'huile",
    motivations: "Etre chaud en hiver",
    uid: 'aftercare1');

Meal m1 = Meal(
    startTime: fisherDay,
    endTime: fisherDay,
    owner: u1.uid,
    hunger: 5,
    satiety: 5,
    comment:
        'Hey les gars vous êtes prêt pour votre sandwich à la saucisse? Non? Faudrait bien que ça vous vienne car c\'est tout un gros sandwich qui vous attends',
    title: 'Le gros sandwich',
    photo:
        'https://st.depositphotos.com/1044737/1853/i/450/depositphotos_18533723-stock-photo-baguette-with-ham.jpg');

Message msg1 = Message(
    content: 'Bonjour', fromId: u1.uid, toId: d1.uid, time: DateTime.now());
Message msg2 = Message(
    content: 'Hello, tu vas bien?',
    fromId: d1.uid,
    toId: u1.uid,
    time: DateTime.now());
Message msg3 = Message(
    content:
        'Oui super, est-ce que c\'est une bonne idée de manger des huitres au fromage? Niveau libido?',
    fromId: u1.uid,
    toId: d1.uid,
    time: DateTime.now());
Message msg4 = Message(
    content:
        'Alors je suis pas experte en la matière mais je sais que ce n\'est pas forcément un bon combo pour le foie.',
    fromId: d1.uid,
    toId: u1.uid,
    time: DateTime.now());

void createUsers() {
  IUser userApi = FirebaseUser(db);
  userApi.createUser(u1);
  userApi.createUser(u2);
  userApi.createUser(u3);
  userApi.createUser(u4);
  userApi.createUser(d1);
}

void createAftercare() {
  IAftercare aftercareApi = FirebaseAftercare(db);
  aftercareApi.createAftercare(a1);
}

void createMeal() {
  IMeal mealApi = FirebaseMeal(db);
  mealApi.createMeal(m1);
}

void createMessage() {
  IMessage messageApi = FirebaseMessage(db);
  messageApi.createMessage(msg1);
  messageApi.createMessage(msg2);
  messageApi.createMessage(msg3);
  messageApi.createMessage(msg4);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp());

  createUsers();
  createAftercare();
  createMeal();
  createMessage();
}
