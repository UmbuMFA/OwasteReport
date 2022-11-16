import 'package:app_waste_report/Screen/home.dart';
import 'package:app_waste_report/Screen/register.dart';
import 'package:app_waste_report/Screen/validate_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '/Screen/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'forgot.dart';
// import 'home.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure3,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure3
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure3 = !_isObscure3;
                            });
                          }),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return ("please enter valid password min. 6 character");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            visible = true;
                          });
                          signIn(emailController.text, passwordController.text);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xff4c505b),
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    // LocationPage(),
                                    HomePage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyRegister()));
                            ;
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Color(0xff4c505b),
                            ),
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        dialogSucces('Anda Berhasil Login', 'Lanjut ke Halaman Home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dialogError(
              'User tidak Ditemukan', 'Pastikan User anda telah terdaftar');
        } else if (e.code == 'wrong-password') {
          dialogError('Passwerd Salah', 'Masukkan Password yang sesuai');
        }
      }
    }
  }

  dialogSucces(String title, String desc) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ValidatePage(),
          ),
        );
      },
    ).show();
  }

  dialogError(String title, String desc) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    ).show();
  }
}
