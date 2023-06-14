import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Make the FireAuth singletone instance as it only need 1.
class FireAuth {
  // make this instance singletone
  static final FireAuth _fireAuth = FireAuth._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollectionRef = FirebaseFirestore.instance.collection("users");

  factory FireAuth() {
    return _fireAuth;
  }
  FireAuth._internal();

  Future<User?> registerUsingEmailPassword({
    required String name, required String email,
    required String password, required String contact}) async {
    User? user;
    try {
      final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = _firebaseAuth.currentUser;

      // update user details
      await _userCollectionRef.add({
        'name': name,
        'email': email,
        'contact':contact
      });
    } on FirebaseAuthException catch(e) {
      rethrow;
    }
  }

  // Future createUser(User user) async {
  //   try {
  //     await _userCollectionRef.endAtDocument(user.id).  .document(user.id).setDate(user.toJson());
  //   } catch (e) {
  //     return e.message;
  //   }
  // }

  Future<User?> signInUsingEmailPassword({
    required String email, required String password}) async {
    User? user;
    try {
      final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
    return user;
  }

  Future<bool> isUserLogginIn() async {
    var user = _firebaseAuth.currentUser!;
    return user != null;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<User?> refreshUser(User user) async {
    await user.reload();
    User? refreshedUser = _firebaseAuth.currentUser;

    return refreshedUser;
  }

  void sendEmailVerification(User user) async {
    user.sendEmailVerification();
  }

  static Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({
        'login_hint': 'user@example.com'
      });

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }


  }

  // TODO: Supporring facebook causes crash
  // Future<UserCredential> signInWithFacebook() async {
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     // Create a credential from the access token
  //     final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //     // Once signed in, return the UserCredential
  //     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   }
  // }
}

class RegisteredUser {
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  RegisteredUser({required this.id, required this.fullName, required this.email, required this.userRole});
  RegisteredUser.fromData(Map<String, dynamic> data)
    : id = data['id'],
      fullName = data['fullName'],
      email = data['email'],
      userRole = data['userRole'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
    };
  }
}

class Validator {
  static String? validateName({required String name}) {
    if(name == null) {
      return null;
    }
    if(name.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  static String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? loginValidatePassword({required String password}) {
    if (password == null || password.isEmpty) {
      return 'Password can\'t be empty';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}
