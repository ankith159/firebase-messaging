import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:notifications/models/user.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  _saveDeviceToken(String uid) async {
    print('got in');
    String fcmToken = '';
    try {
      fcmToken = await _fcm.getToken();
      print(fcmToken);
    } catch (e) {}
    print(fcmToken);

    if (fcmToken != null) {
      var tokens = FirebaseFirestore.instance
          .collection('waterusers')
          .doc(uid)
          .collection('tokens')
          .doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);

    if (user == null)
      return Center(
        child: CircularProgressIndicator(),
      );

    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                _saveDeviceToken(user.uid);
              },
              child: Text('${user.uid}'))),
    );
  }
}
