import 'dart:io';

import 'package:notifications/authenticate/register.dart';
import 'package:notifications/services/auth.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool loading = false;
  String error = '';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : StreamBuilder(
            stream: InternetAddress.lookup('google.com').asStream(),
            builder: (context, AsyncSnapshot<List<InternetAddress>> snapshot) {
              if (!snapshot.hasData) return Container();
              if (!snapshot.data.isNotEmpty)
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Please Turn On Data',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                );
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: GoogleSignInButton(
                        //         darkMode: true,
                        //         onPressed: () async {
                        //           setState(() => loading = true);

                        //           final dynamic result =
                        //               await AuthService().googleSignIn();

                        //           if (result == null) {
                        //             setState(() {
                        //               error =
                        //                   'Coud not sign in with those credentials';
                        //               loading = false;
                        //             });
                        //           }
                        //         }))
                        Align(
                          alignment: Alignment.center,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          hintText: 'Email',
                                          filled: true,
                                          fillColor: Colors.white54,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        controller: email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          hintText: 'Password',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          filled: true,
                                          fillColor: Colors.white54,
                                        ),
                                        controller: password,
                                        obscureText: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 15,
                                            right: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurpleAccent,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate())
                                              AuthService().emailPassSignIn(
                                                  email.text, password.text);
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                letterSpacing: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        },
                                        child: Text(
                                          'Not a User? Register now',
                                          style: TextStyle(
                                            color: Colors.white,
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
                        )
                      ],
                    ),
                  ));
            },
          );
  }
}
