import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthService with ChangeNotifier {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Firestore _db = Firestore.instance;

  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;

  AuthService.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  User userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            photoURL: user.photoUrl)
        : null;
  }

  /// Sign Up
  // Sign Up with email & password
  Future<bool> signUpUser(
      String email, String password, String displayName) async {
    String photoUrl =
        'https://eshop-bbd48.firebaseapp.com/assets/images/user/user-thumb.jpg';
    try {
      _status = Status.Authenticating;
      notifyListeners();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = displayName;
      userUpdateInfo.photoUrl = photoUrl;
      user.updateProfile(userUpdateInfo).then((onValue) {
        Firestore.instance.collection('users').document().setData({
          'uid': user.uid,
          'email': user.email,
          'displayName': displayName,
          'photoUrl': photoUrl,
          'roles': {'editor': true}
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.message);
      return false;
    }
  }

  /// Sign In
  // Sign In with email & password
  Future<bool> signInUser(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Sign In with Google
  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Sign In with Facebook
  Future<bool> signInWithFacebook() async {
    return false;
  }

  /// Sign Out
  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
  /*
  isAuth() {
    return this.afAuth.authState.pipe(map(auth => auth));
  }

  isUserAdmin(userUid: UserInterface) {
    return this.afs.doc<UserInterface>(`users/${userUid}`).valueChanges();
  }
   */
}
