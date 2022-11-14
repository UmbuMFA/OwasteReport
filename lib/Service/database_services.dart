// import 'package:app_waste_report/Models/users.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseFirestore _db = FirebaseFirestore.instance;

// class DatabaseService {

//   addUsers(Users usersData) async {
//     await _db.collection("User").add(usersData.toMap());
//   }

//     updateUsers(Users usersData) async {
//     await _db.collection("User").doc(usersData.id).update(usersData.toMap());
//   }

//   Future<void> deleteUsers(String documentId) async {
//     await _db.collection("User").doc(documentId).delete();

//   }

//   Future<List<Users>> retrieveUser() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await _db.collection("User").get();
//     return snapshot.docs
//         .map((docSnapshot) => Users.fromDocumentSnapshot(docSnapshot))
//         .toList();
//   }
  
// }