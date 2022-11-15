import 'package:app_waste_report/Models/report.dart';
import 'package:app_waste_report/Screen/detail_laporan.dart';
import 'package:app_waste_report/Screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'addpost.dart';
// import 'editpost.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  final CollectionReference<Map<String, dynamic>> _usersStream =
      FirebaseFirestore.instance.collection('report');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()))),
        backgroundColor: Colors.black54,
        title: Text('History'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _usersStream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                final DocumentSnapshot<Object?> documentSnapshot =
                    snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) =>
                    //         editReport(docid: snapshot.data!.docs[index]),
                    //   ),
                    // );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportDetailsView(
                                documentSnapshot: documentSnapshot)));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),

                      Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              // width: 40,
                              // height: 160,
                              padding: EdgeInsets.only(top: 20.0),
                              // child: Icon(Icons.recycling_outlined,
                              //     color: Color.fromARGB(255, 255, 255, 255)),
                              child: Image(
                                image: NetworkImage(
                                    documentSnapshot["image"].toString()),
                              ),
                            ),
                            title: Text(
                              // snapshot.data!.docChanges[index].doc['kategori'],
                              documentSnapshot.get('kategori'),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      // tag: 'hero',
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 0.0),
                                          child: Text(
                                              documentSnapshot.get('status'),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    )),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    // child: TextButton(
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               // ReportDetailsView(
                                    //               //     report: Report.fromSnapshot(docId)
                                    //               //     )
                                    //                   ),
                                    //     );
                                    //   },
                                    child: Text(
                                        documentSnapshot["addres"].toString(),
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 246, 246, 246))),
                                    // )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      // Card(),
                      // Text(
                      //       snapshot.data!.docChanges[index].doc['status'],
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //       ),
                      //     ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: 3,
                      //     right: 3,
                      //   ),
                      //   child: ListTile(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       side: BorderSide(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       snapshot.data!.docChanges[index].doc['status'],
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //       ),
                      //     ),
                      //     contentPadding: EdgeInsets.symmetric(
                      //       vertical: 12,
                      //       horizontal: 16,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),

// StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//   stream: FirebaseFirestore.instance.collection('users').doc('uid').snapshots(),
//   builder: (_, snapshot) {
//     if (snapshot.hasError) return Text('Error = ${snapshot.error}');

//     if (snapshot.hasData) {
//       var output = snapshot.data!.data();
//       var value = output?['email' 'name' 'uid' 'wroll'];
//       return Text('Value = $value');
//     }

//     return Center(child: CircularProgressIndicator());
//   },
// )
    );
  }
}
