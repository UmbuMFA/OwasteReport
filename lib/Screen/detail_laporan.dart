// ignore_for_file: prefer_const_constructors

import 'package:app_waste_report/Screen/history.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:app_waste_report/Models/report.dart';

class ReportDetailsView extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  ReportDetailsView({Key? key, required this.documentSnapshot})
      : super(key: key);

  static HexColor kBgColor = HexColor('e7ded7');
  static HexColor kGreyColor = HexColor('dcdde2');
  static HexColor kSmProductBgColor = HexColor('f9f9f9');


  //Creating a reference to the collection 'users'
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('report');

  //This function will set the values to firstName, lastName and title from the data fetched from firestore
  // void getUsersData() {
  //   var widget;
  //   collectionReference.doc(widget.documentId).get().then((value)  {

  //     //'value' is the instance of 'DocumentSnapshot'
  //     //'value.data()' contains all the data inside a document in the form of 'dictionary'
  //     var fields = value.data();

  //     //Using 'setState' to update the user's data inside the app
  //     //firstName, lastName and title are 'initialised variables'
  //     setState(() {
  //       firstName = fields['firstName'];
  //       lastName = fields['lastName'];
  //       title = fields['title'];
  //     });
  //   });
  // }

  // TextEditingController title = TextEditingController(text: .docid.get('title'));

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // StreamBuilder<DocumentSnapshot>(
            //     stream: FirebaseFirestore.instance
            //         .collection('report')
            //         .doc()
            //         .snapshots(),
            //     builder: (context, snapshot) {
            //       var document = snapshot.data;
            //       if (snapshot.hasError) {
            //         return Text("something is wrong");
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       return Text((document as DocumentSnapshot)['kategori'].toString());
            //     }),
            Container(
              height: MediaQuery.of(context).size.height * .35,
              padding: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              child: Image(
                image: NetworkImage(documentSnapshot["image"].toString()),
                width: 300,
                height: 100,
                ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 40, right: 14, left: 14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Laporan',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                documentSnapshot["kategori"],
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                documentSnapshot["status"],
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            documentSnapshot["addres"],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          // const SizedBox(height: 15),
                          // const SizedBox(height: 10),
                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: kGreyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kGreyColor),
              ),
              child: TextButton(
                onPressed: () {
                  documentSnapshot.reference.update({
                    'status': 'Sudah Ditangani',
                  }).whenComplete(() {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => history()));
                  });
                },
                child: Text(
                  'Tanggapi',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  // productController.addToCart();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 0, 0),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: TextButton(
                    onPressed: () {
                      documentSnapshot.reference.delete().whenComplete(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => history()));
                      });
                    },
                    child: Text(
                      'Tolak',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // child: Obx(
                  //   () => productController.isAddLoading.value
                  //       ? SizedBox(
                  //           width: 20,
                  //           height: 20,
                  //           child: CircularProgressIndicator(
                  //             color: Colors.white,
                  //             strokeWidth: 3,
                  //           ),
                  //         )
                  //       : Text(
                  //           '+ Add to Cart',
                  //           style: GoogleFonts.poppins(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
