import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String? kategori;
  String? image;
  String? addres;
  String? status;
  String? docId;

//Reciving data
  Report({this.kategori, this.image, this.addres, this.status, this.docId});
  factory Report.fromMap(reportMap) {
    return Report(
      kategori: reportMap['kategori'],
      image: reportMap['image'],
      addres: reportMap['addres'],
      status: reportMap['status'],
    );
  }




//sending Data
  Map<String, dynamic> toMap() {
    return {
      'kategory': kategori,
      'image': image,
      'addres': addres,
      'status': status
    };
  }

      Report.fromSnapshot(DocumentSnapshot snapshot) :
      kategori = snapshot['kategori'],
      image = snapshot['image'],
      addres = snapshot['addres'],
      status = snapshot['status'],
      docId = snapshot.id;
}


