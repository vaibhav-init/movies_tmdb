import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'textField.dart';
import 'login_screen.dart';
import 'movies/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign Up'),
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
            logInButton(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text)
                  .then((value) {
                print('Created Account SuccessFully');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                ).onError(
                    (error, stackTrace) => print('Error ${error.toString()}'));
              });
            }),
            signInOption(),
          ],
        ),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => loginScreen()));
          },
          child: const Text(
            ' Sign In',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
