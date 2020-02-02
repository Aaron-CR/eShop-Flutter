import 'package:flutter/foundation.dart';
import 'package:eshop/core/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eshop/core/models/user_models.dart';
import 'package:eshop/core/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final String photoUrl =
      'https://eshop-bbd48.firebaseapp.com/assets/images/user/user-thumb.jpg';

  User _currentUser;

  User get currentUser => _currentUser;

  // Sign In with email & password
  Future signInWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  // Sign Up with email & password
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
    @required String userRole,
  }) async {
    try {
      AuthResult authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = User(
        uid: authResult.user.uid,
        email: email,
        displayName: displayName,
        photoURL: photoUrl,
        userRole: userRole,
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
