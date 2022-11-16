import 'package:app_waste_report/Screen/history.dart';
import 'package:app_waste_report/Screen/home.dart';
import 'package:app_waste_report/Screen/login.dart';
import 'package:app_waste_report/Screen/profil.dart';
import 'package:app_waste_report/Screen/validate_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:path/path.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _formkey = GlobalKey<FormState>();

  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  UploadTask? uploadTask;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  // final TextEditingController kategoriController = TextEditingController();
  // final TextEditingController StatusController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  // File? file;
  var options = [
    'Organik',
    'Anorganik',
  ];
  var _currentItemSelected = "Organik";
  var kategori = "Organik";

  var options2 = [
    'Belum Diproses',
    'Sudah Diproses',
  ];

  var _currentItemSelected2 = "Belum Diproses";
  var status = "Belum Diproses";

  String? _currentAddress;
  Position? _currentPosition;
  File? imageFile;
  String? _imgUrl;
  var urlDownload;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  dialogSucces(String title, String desc) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        uploadFile();
        ref.add({
          'kategori': _currentItemSelected,
          'image': _imgUrl,
          'addres': _currentAddress,
          'status': _currentItemSelected2,
        }).whenComplete(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LocationPage()));
          Text('Laporan Anda Telah dikirim');
        });
      },
    ).show();
  }

  Future<void> uploadFile() async {
    final fileName = p.basename(_photo!.path);
    var destination = 'files/$fileName';
    final ref = FirebaseStorage.instance.ref().child(destination);
    uploadTask = ref.putFile(_photo!);
    print(uploadTask);

    // ignore: unused_local_variable
    final snapshot = await uploadTask!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      _imgUrl = '$urlDownload';
    });
  }

  static HexColor kBgColor = HexColor('e7ded7');

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          // color: kBgColor,
          image: DecorationImage(
              image: AssetImage('images/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => 
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ValidatePage()))
                  // Navigator.pop(context)    
                      ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 30),
                child: Container(
                  decoration: (BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  )),
                  padding: const EdgeInsets.only(
                      left: 0, top: 8, right: 0, bottom: 8),
                  child: Text(
                    'Laporkan Penemuan Sampah!!!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Form(
                  key: _formkey,
                  child: Column(children: [
                    Text(
                      "Kategori Sampah : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButton<String>(
                      dropdownColor: Colors.blue[900],
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: Colors.white,
                      focusColor: Colors.white,
                      items: options.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          kategori = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('${_imgUrl ?? ""}'),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          imgFromCamera();
                          print('Foto Telah Dipilih');
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        child: Text(
                          'Tambahkan Gambar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Alamat ${_currentAddress ?? ""}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        onPressed: _getCurrentPosition,
                        child: const Text('Kirim lokasi terkini'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Status : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    DropdownButton<String>(
                      dropdownColor: Colors.blue[900],
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: Colors.white,
                      focusColor: Colors.white,
                      items: options2.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (a) {
                        setState(() {
                          status = _currentItemSelected2;
                        });
                      },
                      value: _currentItemSelected2,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              dialogSucces('Laporan Telah Terkirim', 'Terimakasih Telah Melaporkan sampah');
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            child: const Text(
                              'Laporkan',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.pushNamed(context, 'login');
                          //   },
                          //   child: const Text(
                          //     'Logout',
                          //     style: TextStyle(
                          //       decoration: TextDecoration.underline,
                          //       fontSize: 18,
                          //       color: Color(0xff4c505b),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ]),
                ),
              ))
            ])));
  }
}
