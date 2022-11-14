// import 'package:app_waste_report/Screen/history.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'Screen/login.dart';
import 'package:flutter/material.dart';
// import 'Screen/location.dart';
import 'Screen/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: MyRegister(),
    );
  }
}
