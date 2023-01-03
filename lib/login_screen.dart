import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'textField.dart';
import 'signup_screen.dart';
import 'movies/home.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            reusableTextField('Enter your Email', Icons.person_outline, false,
                _emailTextEditingController),
            SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            reusableTextField('Enter your Password', Icons.lock_outline, true,
                _passwordTextEditingController),
            SizedBox(
              height: 20,
            ),
            logInButton(
              context,
              true,
              () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextEditingController.text,
                        password: _passwordTextEditingController.text)
                    .then(
                  (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => home(),
                      ),
                    );
                  },
                );
              },
            ),
            signUpOption(),
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dont have an account?',
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            ' Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
