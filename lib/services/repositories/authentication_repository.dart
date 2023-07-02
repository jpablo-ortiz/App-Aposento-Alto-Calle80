// When an error occurs when registering
import 'dart:async';

import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//----------------------------------------------------------
//----------------------- EXCEPTIONS -----------------------
//----------------------------------------------------------

class SignUpFailure implements Exception {}

// when an error occurs when logging in
class LogInWithEmailAndPasswordFailure implements Exception {}

// when an error occurs when logging in with google
class LogInWithGoogleFailure implements Exception {}

// when an error occurs when loggout
class LogOutFailure implements Exception {}

//----------------------------------------------------------
//----------------------- REPOSITORY -----------------------
//----------------------------------------------------------

abstract class AuthenticationRepository {
  //----------------------------------------------------------
  //------------------------- STREAMS ------------------------
  //----------------------------------------------------------

  // Stream user -> actual user when the state of autehntication changes
  Stream<UserApp?> get user;

  //----------------------------------------------------------
  //----------------- FUNCIONES PRINCIPALES ------------------
  //----------------------------------------------------------

  // Register user with email and password
  Future<void> signUp(String email, String password);

  // Login with google
  Future<void> loginWithGoogle();

  // Login with email and password
  Future<void> loginWithEmailAndPassword(String email, String password);

  // Logout
  Future<void> logOut();

  // Update the user image
  void updateUserImage(String imageUrl) {}

  Future<bool> isSignedIn();

  Future<UserApp> getUser();

  Future<void> createUpdateAllUserInfo(UserApp userApp);

  Future<void> updateUserInfo(String id, String names, String lastNames);

  Future<bool> userExistsOnDataBase(String id);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  //----------------------------------------------------------
  //--------------- VARIABLES Y CONSTRUCTOR ------------------
  //----------------------------------------------------------

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final StreamController<UserApp?> _user;

  AuthenticationRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _user = new StreamController<UserApp?>() {
    _user.addStream(
      // userChanges is a superset of both [authStateChanges] and [idTokenChanges]
      _firebaseAuth.userChanges().map(
        (User? firebaseUser) {
          if (firebaseUser == null) {
            return null;
          } else {
            return UserApp.fromFirebaseUser(firebaseUser);
          }
        },
      ),
    );
  }

  //----------------------------------------------------------
  //------------------------- STREAMS ------------------------
  //----------------------------------------------------------

  // Stream user -> actual user when the state of autehntication changes
  Stream<UserApp?> get user {
    return _user.stream;
  }

  //----------------------------------------------------------
  //----------------- FUNCIONES PRINCIPALES ------------------
  //----------------------------------------------------------

  // Obtener usuario
  Future<UserApp> getUser() async {
    return UserApp.fromFirebaseUser(_firebaseAuth.currentUser);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // Register user with email and password
  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  // Login with google
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw LogInWithGoogleFailure();
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  // Login with email and password
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  // Logout
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  //----------------------------------------------------------
  //------------------ FUNCIONES AUXILIARES ------------------
  //----------------------------------------------------------

  // Update the user image
  void updateUserImage(String imageUrl) {
    User? user = _firebaseAuth.currentUser!;
    user.updatePhotoURL(imageUrl);
    //user.reload();
    _user.sink.add(UserApp.fromFirebaseUser(user));
  }

  Future<void> createUpdateAllUserInfo(UserApp userApp) async {
    return await _firestore.collection("users").doc(userApp.id).set(userApp.toMap());
  }

  Future<void> updateUserInfo(String id, String names, String lastNames) async {
    return await _firestore.doc(id).update({
      "names": names,
      "last_names": lastNames,
    });
  }

  // A function that returns a boolean if the doc of the user exists
  Future<bool> userExistsOnDataBase(String id) async {
    final QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    bool res = querySnapshot.docs.any((doc) => doc.id == id);
    return res;
  }

  void dispose() {
    _user.close();
  }
}
