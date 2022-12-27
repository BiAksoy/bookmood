import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category_page.dart';
import 'forget_password_page.dart';
import 'sign_up_page.dart';
import 'package:book_app/service/auth.dart';
import 'package:book_app/widgets/sign_up_form.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
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
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  child: SizedBox(
                    child: SizedBox(
                      width: 250,
                      height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Book App",
                          style: GoogleFonts.mogra(
                            textStyle: const TextStyle(
                                fontSize: 44, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: SignUpForm(
                      obscureText: false,
                      controller: emailController,
                      text: "Email",
                      icon: Icon(
                        Icons.email,
                        color: Colors.blueGrey.shade700,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  alignment: Alignment.topRight,
                  child: SignUpInkwell(
                    text: "Forgotten Password?",
                    onTap: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await authService
                              .signIn(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoryPage(),
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
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.blueGrey.shade700,
                      elevation: 8,
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.amber.shade200,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 250,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.amber.shade200,
                      side: BorderSide(
                        color: Colors.blueGrey.shade700,
                        width: 2.5,
                      ),
                      elevation: 8,
                    ),
                    icon: Icon(
                      Icons.login,
                      color: Colors.blueGrey.shade600,
                    ),
                    label: Text(
                      "Log In With Google",
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.blueGrey.shade800,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.blueGrey.shade800),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.blueGrey.shade800,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.blueGrey.shade700,
                      elevation: 8,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.amber.shade200,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
