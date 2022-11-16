import 'package:app_waste_report/Screen/home.dart';
import 'package:app_waste_report/Screen/homeUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/Models/users.dart';

class ValidatePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ValidatePage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var wrooll;
  var email;
  var uid;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        email = loggedInUser.email.toString();
        wrooll = loggedInUser.wrool.toString();
        uid = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    if (wrooll == 'Admin') {
      return HomePage(
      );
    } else {
      return HomePageUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}
