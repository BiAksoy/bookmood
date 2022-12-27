import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'log_in_page.dart';
import 'package:book_app/service/auth.dart';
import 'package:book_app/widgets/sign_up_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SignUpForm(
                    obscureText: false,
                    controller: nameController,
                    text: "Name",
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SignUpForm(
                    obscureText: false,
                    controller: surnameController,
                    text: "Surname",
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SignUpForm(
                    obscureText: false,
                    controller: emailController,
                    text: "Email",
                    icon: Icon(
                      Icons.email,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: SignUpForm(
                    obscureText: true,
                    controller: passwordController,
                    text: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.only(top: 20),
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await authService
                              .createUser(
                                  nameController.text,
                                  surnameController.text,
                                  emailController.text,
                                  passwordController.text)
                              .then((value) {
                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LogIn(),
                              ),
                            );
                          });
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                        }
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade800,
                      shape: const StadiumBorder(),
                      elevation: 8,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.amber.shade200),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      errorMessage,
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade200,
                      side: BorderSide(
                        color: Colors.blueGrey.shade900,
                        width: 1.5,
                      ),
                      shape: const StadiumBorder(),
                      elevation: 8,
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
