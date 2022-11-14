// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:app_waste_report/Models/report.dart';


class ReportDetailsView extends StatelessWidget {
    
  final Report report;

  ReportDetailsView({Key? key, required this.report}) : super(key: key);




  static HexColor kBgColor = HexColor('e7ded7');
  static HexColor kGreyColor = HexColor('dcdde2');
  static HexColor kSmProductBgColor = HexColor('f9f9f9');

  // final List<SmProduct> smProducts = [
  //   SmProduct(image: 'assets/images/product-1.png'),
  //   SmProduct(image: 'assets/images/product-2.png'),
  //   SmProduct(image: 'assets/images/product-3.png'),
  //   SmProduct(image: 'assets/images/product-4.png'),
  // ];

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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Ionicons.bag_outline,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('report')
                  .doc()
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
                return Text((document as DocumentSnapshot)['kategori'].toString());
              }),
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            // child: Image.asset('assets/images/main_image.png'),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
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
                          "${report.addres}",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alamat',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Kategori',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Text(
                        //   'Similar This',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        // SizedBox(
                        //   height: 110,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     // itemCount: smProducts.length,
                        //     itemBuilder: (context, index) => Container(
                        //       margin: const EdgeInsets.only(right: 6),
                        //       width: 110,
                        //       height: 110,
                        //       decoration: BoxDecoration(
                        //         color: kSmProductBgColor,
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: Center(
                        //         // child: Image(
                        //         //   height: 70,
                        //         //   image: AssetImage(smProducts[index].image),
                        //         // ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
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
              child: Text(
                'Tanggapi',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
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

                  child: Text(
                    'Tolak',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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
