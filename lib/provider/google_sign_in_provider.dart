import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    final String? fullName = googleUser.displayName;
    List<String?> nameParts = fullName!.split(" ");
    final name = nameParts[0];
    final surname = nameParts[1];
    final data = {
      'email': googleUser.email,
      'name': name,
      'surname': surname,
    };
    FirebaseFirestore.instance.collection("User").doc(googleUser.id).set(data);
    notifyListeners();
  }
}
