import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  User({
    @required this.uid,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.joiningDate,
  });
  final String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String photoUrl;
  final Timestamp joiningDate;
}

class LoginUser {
  String uid;
  String displayName;
  String photoUrl;
  String email;
  String phoneNumber;
  Timestamp joiningDate;

  LoginUser({
    this.uid,
    this.photoUrl,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.joiningDate,
  });
}
