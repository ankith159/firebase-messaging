import 'package:notifications/services/auth.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              AuthService().signOut();
            },
            child: Text('Sign Out')),
      ),
    );
  }
}
