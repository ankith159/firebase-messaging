import 'package:notifications/services/auth.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  String error = '';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              color: Colors.black,
              child: Stack(
                children: [
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
                                    hintText: 'email',
                                    hintStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.white54,
                                  ),
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white),
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
                                      top: 2, bottom: 2, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate())
                                        await AuthService().registerEmailPass(
                                          email.text,
                                          password.text,
                                        );
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Already a User?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 1),
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
            ),
          );
  }
}
