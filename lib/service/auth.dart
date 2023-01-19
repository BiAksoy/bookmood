import 'package:book_app/screens/category_page.dart';
import 'package:book_app/screens/log_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await auth.signOut();
  }

  Future<User?> createUser(
      String name, String surname, String email, String password) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firestore.collection("User").doc(user.user!.uid).set({
      'name': name,
      'surname': surname,
      'email': email,
    });

    return user.user;
  }

  Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

class AuthStatus extends StatefulWidget {
  const AuthStatus({Key? key}) : super(key: key);

  @override
  State<AuthStatus> createState() => _AuthStatusState();
}

class _AuthStatusState extends State<AuthStatus> {
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? const CategoryPage() : const LogIn();
  }
}
