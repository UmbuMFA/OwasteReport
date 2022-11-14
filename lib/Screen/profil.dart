import 'package:app_waste_report/Screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

// import 'addpost.dart';
// import 'editpost.dart';

class Profil extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}
 // how to use QuerySnapshot

class _profilState extends State<Profil> {

    var firebaseUser =  FirebaseAuth.instance.currentUser;
    static HexColor kBgColor = HexColor('e7ded7');


     // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: 
                             Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            )),
                  ]))
            ],
          ));

  Future logout() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyLogin()),
            (route) => false));
  }

   // ignore: prefer_final_fields
  //  Future<QuerySnapshot<Map<String, dynamic>>> _usersStream =
  //     FirebaseFirestore.instance.collection('users').get() .;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => addnote()));
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
         backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
      body: Column(
        children: [
                    Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(firebaseUser?.uid) //ID OF DOCUMENT
                  .snapshots(),
            builder: (context, snapshot) {
              var document = snapshot.data;
              if (snapshot.hasError) {
                return Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

                    return 
                      Column(
                        children: [
                          buildUserInfoDisplay((snapshot.data as DocumentSnapshot)['name'], 'Nama'),
                          buildUserInfoDisplay((snapshot.data as DocumentSnapshot)['email'], 'Email'),
                          buildUserInfoDisplay((snapshot.data as DocumentSnapshot)['wrool'], 'Rool'),
                                                    TextButton(
                            onPressed: () {
                              logout();
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 4,
                          // ),

                          // Card(
                          //   elevation: 8.0,
                          //   margin: new EdgeInsets.symmetric(
                          //       horizontal: 10.0, vertical: 10.0),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: Color.fromRGBO(64, 75, 96, .9)),
                          //     child: ListTile(
                          //       contentPadding: EdgeInsets.symmetric(
                          //           horizontal: 20.0, vertical: 10.0),
                          //       leading: Container(
                          //         // width: 40,
                          //         // height: 160,
                          //         padding: EdgeInsets.only(top: 20.0),
                          //         child: Icon(Icons.recycling_outlined,
                          //             color: Color.fromARGB(255, 255, 255, 255)),
                          //       ),
                          //       title: Text(
                          //         'Name' +
                          //         (snapshot.data as DocumentSnapshot)['name'],
                          //         style: TextStyle(
                          //             color: Color.fromARGB(255, 255, 255, 255),
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //       subtitle: Row(
                          //         children: <Widget>[
                          //           Expanded(
                          //               flex: 2,
                          //               child: Container(
                          //                 // tag: 'hero',
                          //                 child: Padding(
                          //                     padding: EdgeInsets.only(right:0.0),
                          //                     child: Text(
                          //                       'Email' + 
                          //                         (snapshot.data as DocumentSnapshot)['email'],
                          //                         style: TextStyle(
                          //                             color: Color.fromARGB(255, 255, 255, 255)))),
                          //               )),
                          //           Expanded(
                          //             flex: 6,
                          //             child: Padding(
                          //                 padding: EdgeInsets.only(left: 10.0),
                          //                 child: Text(
                          //                     'Rool' + (snapshot.data as DocumentSnapshot)['wrool']
                          //                     ,
                          //                     style: TextStyle(
                          //                         color: Color.fromARGB(255, 246, 246, 246)))),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                    );
                  },
          ),
        ],
      )
    );


  }
}
