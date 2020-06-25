import 'package:cloudreader/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  User _fromFirebaseUser(FirebaseUser usr) {
    return User(uid: usr.uid, name: usr.displayName);
  }

  Future<User> signInWithGoogleSilently() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signInSilently();
    if(googleUser == null) { return null; }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _fromFirebaseUser(user);
  }

  Future<User> signInWithGoogle() async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if(googleUser == null) { return null; }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _fromFirebaseUser(user);
    } catch(_) {
     return null;
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _fromFirebaseUser(user);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}

