import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notifications/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginUser _userFromFirebaseUser(auth.User user) {
    return user != null
        ? LoginUser(
            uid: user.uid,
            photoUrl: user.photoURL,
            phoneNumber: user.phoneNumber,
            displayName: user.displayName,
          )
        : null;
  }

  Stream<LoginUser> get fireUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in with google auth
  Future googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = await _auth.signInWithCredential(credential);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user.uid)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.user.uid)
            .set({
              'uid': user.user.uid,
              'name': user.user.displayName,
              'phoneNumber': user.user.phoneNumber,
              'email': user.user.email,
              'photoUrl': user.user.photoURL,
              'joiningDate': FieldValue.serverTimestamp(),
            })
            .then((value) => print('User Added'))
            .catchError((error) => print('Failed to add user: $error'));
      }
    });

    return _userFromFirebaseUser(user.user);
  }

  Future<auth.UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential =
        auth.FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    final user = await _auth.signInWithCredential(facebookAuthCredential);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user.uid)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.user.uid)
            .set({
              'uid': user.user.uid,
              'name': user.user.displayName,
              'phoneNumber': user.user.phoneNumber,
              'email': user.user.email,
              'photoUrl': user.user.photoURL,
              'joiningDate': FieldValue.serverTimestamp(),
            })
            .then((value) => print('User Added'))
            .catchError((error) => print('Failed to add user: $error'));
      }
    });
    return user;
  }

  //Register with email and password
  registerEmailPass(
    email,
    password,
  ) async {
    try {
      auth.UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.user.uid)
              .set({
                'uid': user.user.uid,
                'name': user.user.displayName,
                'phoneNumber': user.user.phoneNumber,
                'email': user.user.email,
                'photoUrl': user.user.photoURL,
                'joiningDate': FieldValue.serverTimestamp(),
              })
              .then((value) => print('User Added'))
              .catchError((error) => print('Failed to add user: $error'));
        }
      });
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //Sign In with email and password
  emailPassSignIn(email, password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
        } else {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.user.uid)
              .set({
                'uid': user.user.uid,
                'name': user.user.displayName,
                'phoneNumber': user.user.phoneNumber,
                'email': user.user.email,
                'photoUrl': user.user.photoURL,
                'joiningDate': FieldValue.serverTimestamp(),
              })
              .then((value) => print('User Added'))
              .catchError((error) => print('Failed to add user: $error'));
        }
      });
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //Sign out
  signOut() {
    _auth.signOut();
  }
}
