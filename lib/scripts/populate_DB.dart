import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/firebase_message.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:pdg_app/model/dietitian.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:pdg_app/model/message.dart';
import 'package:pdg_app/model/user.dart';

final db = FirebaseFirestore.instance;
DateTime fisherDay = DateTime(2017, 9, 7, 17, 30);
Aftercare a1 = Aftercare(
    bmi: 12,
    weight: 14.0,
    startDate: DateTime.now(),
    comments: "commentaire",
    diagnostic: "diagnostic",
    documents: ['dfdf']);

User u1 = User(
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0795438759',
    birthDate: DateTime(1996, 10, 9),
    avs: '7561352485592',
    uid: 'FS3RqfWpeuVXcdZrTQJdBPfFbwV2',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_olivier.jpeg?alt=media&token=0166b19f-428f-419d-b0d5-4b9b665e62f5');
User u2 = User(
    firstName: 'Chloé',
    lastName: 'Fontaine',
    phoneNumber: '0780002334',
    birthDate: DateTime(1998, 12, 8),
    avs: '7561352485592',
    uid: 'Zaf2afuSAGcicn5DziZTrr4MYCA2',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_chloe.jpg?alt=media&token=9195f8d5-e8ab-491b-9c61-3fe91ff1c9b3');
User u3 = User(
    firstName: 'Luca',
    lastName: 'Coduri',
    phoneNumber: '0770003445',
    birthDate: DateTime(1996, 12, 18),
    avs: '7561352485592',
    uid: 'PSCOEhz98TORfOb9BizGfjUA8hc2',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_luca.webp?alt=media&token=12aa7417-fd0c-41bf-8f80-7db9f16c9fc4');
User u4 = User(
    firstName: 'Nelson',
    lastName: 'Jeanrenaud',
    phoneNumber: '0766834556',
    birthDate: DateTime(2001, 9, 1),
    avs: '',
    uid: 'iKO7fJfMKgawEDtnd9Ll0kjBNBW2',
    photoUrl:
        'https://firebasestorage.googleapis.com/v0/b/pdg-otcare-72f5c.appspot.com/o/crepe_nelson.jpeg?alt=media&token=a5af4d67-1522-4355-a647-d29496809463');
Dietitian d1 = Dietitian(
    firstName: 'Claire',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '7561352485592',
    clientList: [u1.uid, u2.uid, u3.uid, u4.uid],
    phoneNumber: '0266634556',
    uid: 'bZB6G7LbLSfp8lTPsh00fWxiHb03');

Meal m1 = Meal(
    startTime: fisherDay,
    endTime: fisherDay,
    owner: u1.uid,
    hunger: 4,
    satiety: 5,
    comment: 'no comment',
    title: 'mojo');

Message msg1 = Message(
    content: 'Bonjour', fromId: 'alice', toId: 'bob', time: DateTime.now());
Message msg2 = Message(
    content: 'ciao', fromId: 'alice', toId: 'bob', time: DateTime.now());
Message msg3 = Message(
    content: 'ciao', fromId: 'alice', toId: 'jean', time: DateTime.now());
Message msg4 = Message(
    content: 'ciao', fromId: 'jean', toId: 'alice', time: DateTime.now());

void createUsers() {
  IUser userApi = FirebaseUser(db);
  userApi.createUser(u1);
  userApi.createUser(u2);
  userApi.createUser(u3);
  userApi.createUser(u4);
}

void createAftercare() {
  IAftercare aftercareApi = FirebaseAftercare(db);
  aftercareApi.createAftercare(a1);
}

void createDietitian() {
  IDietitian dietitianApi = FirebaseDietitian(db);
  dietitianApi.createDietitian(d1);
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
  createDietitian();
}
