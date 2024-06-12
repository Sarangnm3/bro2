import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/signup_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var email, password;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = 'temp@gmail.com';
    _passwordController.text = 'shivashyam';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: SpinKitFadingCircle(
                color: Orange,
                size: 75.0,
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 200.0),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: White,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          onSaved: (val) {
                            email = val;
                          },
                          style: const TextStyle(color: White),
                          cursorColor: White,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Orange,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Orange),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: White),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Orange),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!value.endsWith("@gmail.com")) {
                              return 'Please enter a valid Gmail address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          onSaved: (val) {
                            password = val;
                          },
                          style: const TextStyle(color: White),
                          cursorColor: White,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Orange,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Orange),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: White),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Orange),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Orange),
                          ),
                          onPressed: () async {
                            isLoading = true;
                            setState(() {});
                            var formdata = _formKey.currentState;
                            if (formdata!.validate()) {
                              formdata.save();
                              // UserCredential loggedInUser = await _login();

                              Future.delayed(
                                Duration(seconds: 2),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                              );
                            }
                            isLoading = false;
                            setState(() {});
                          },
                          child: const Text('Login',
                              style: TextStyle(color: White)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(
                            "Don't Have an Account ?",
                            style: TextStyle(color: White),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});
      String errorMessage = 'Wrong Email or Password';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        // Add more cases to handle other Firebase authentication exceptions
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: White,
            title: const Text('Login Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Orange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      isLoading = false;
      setState(() {});
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: White,
            title: const Text('Login Error'),
            content: const Text('An unexpected error occurred.'),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Orange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
