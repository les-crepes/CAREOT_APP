import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

/// https://github.com/atn832/firebase_auth_mocks/blob/master/test/firebase_auth_mocks_test.dart

final tUser = MockUser(
  isAnonymous: false,
  uid: 'T3STU1D',
  email: 'bob@thebuilder.com',
  displayName: 'Bob Builder',
  phoneNumber: '0800 I CAN FIX IT',
  photoURL: 'http://photos.url/bobbie.jpg',
  refreshToken: 'some_long_token',
);

void main() {
  test('Returns no user if not signed in', () async {
    final auth = MockFirebaseAuth();
    final user = auth.currentUser;
    expect(user, isNull);
  });

  group('Emits an initial User? on startup.', () {
    test('null if signed out', () async {
      final auth = MockFirebaseAuth();
      expect(auth.authStateChanges(), emits(null));
      // expect(auth.userChanges(), emitsInOrder([isA<User>()]));
    });
    test('a user if signed in', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      expect(auth.authStateChanges(), emitsInOrder([isA<User>()]));
      expect(auth.userChanges(), emitsInOrder([isA<User>()]));
    });
  });

  group('Returns a mocked user user after sign up', () {
    test('with email and password', () async {
      const email = 'some@email.com';
      const password = 'some!password';
      final auth = MockFirebaseAuth();
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user!;
      expect(user.email, email);
      expect(auth.authStateChanges(), emitsInOrder([null, isA<User>()]));
      expect(auth.userChanges(), emitsInOrder([null, isA<User>()]));
      expect(user.isAnonymous, isFalse);
    });

    test('is email valid?', () async {
      const email = 'some@email.com';
      const password = 'some!password';
      final auth = MockFirebaseAuth();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
   
    });
  });

  group('Returns a mocked user after sign in', () {
    test('with email and password', () async {
      final auth = MockFirebaseAuth(mockUser: tUser);
      final result = await auth.signInWithEmailAndPassword(
          email: 'some email', password: 'some password');
      final user = result.user;
      expect(user, tUser);
      expect(auth.authStateChanges(), emitsInOrder([null, isA<User>()]));
      expect(auth.userChanges(), emitsInOrder([null, isA<User>()]));
    });
  });

  test('Returns a mocked user if already signed in', () async {
    final auth = MockFirebaseAuth(signedIn: true, mockUser: tUser);
    final user = auth.currentUser;
    expect(user, tUser);
  });

  test('Returns null after sign out', () async {
    final auth = MockFirebaseAuth(signedIn: true, mockUser: tUser);
    final user = auth.currentUser;

    await auth.signOut();

    expect(auth.currentUser, isNull);
    expect(auth.authStateChanges(), emitsInOrder([user, null]));
    expect(auth.userChanges(), emitsInOrder([user, null]));
  });

  test('signInWithEmailAndPassword', () async {
    final auth = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword: FirebaseAuthException(code: 'bla'),
      ),
    );
    expect(
      () async =>
          await auth.signInWithEmailAndPassword(email: '', password: ''),
      throwsA(isA<FirebaseAuthException>()),
    );
  });

  test('createUserWithEmailAndPassword', () async {
    final auth = MockFirebaseAuth(
      authExceptions: AuthExceptions(
        createUserWithEmailAndPassword: FirebaseAuthException(code: 'bla'),
      ),
    );
    expect(
      () async =>
          await auth.createUserWithEmailAndPassword(email: '', password: ''),
      throwsA(isA<FirebaseAuthException>()),
    );
  });
}
