import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String emailUser;
String imageUrl;
String errorMessage;
String nameGoogle;
String emailGoogle;
Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    nameGoogle = user.displayName;
    emailGoogle = user.email;
    imageUrl = user.photoURL;
    // Only taking the first part of the name, i.e., First Name
    if (nameGoogle.contains(" ")) {
      nameGoogle = nameGoogle.substring(0, nameGoogle.indexOf(" "));
    }
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  nameGoogle= "";
  emailGoogle= "";
  print("User Signed Out");
}

Future<User> signUp(String email, String password) async {
  await Firebase.initializeApp();
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    assert(user != null);
    assert(await user.getIdToken() != null);
    return user;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<User> signIn(String email, String password) async {
  await Firebase.initializeApp();
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    assert(user != null);
    assert(await user.getIdToken() != null);
    emailUser = email;
    return user;
  } catch (e) {
    if(e.code == 'wrong-password'){
      errorMessage = "Wrong Password";
    }
    else if(e.code == 'user-not-found'){
      errorMessage = "User not found";
    }
    else if(e.code == 'weak-password'){
      errorMessage = "Weak password";
    }
    else if(e.code == 'unknown'){
      errorMessage = "Empty input not allowed";
    }
    print(e.toString());
    return null;
  }
}
