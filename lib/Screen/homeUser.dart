import 'package:app_waste_report/Screen/detail_laporan.dart';
import 'package:app_waste_report/Screen/history.dart';
import 'package:app_waste_report/Screen/location.dart';
import 'package:app_waste_report/Screen/profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageUser> {
  int _selectedIndex = 0;
  void _navigateBattomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  final List<Widget> _pages = [
    Container(
      // decoration: BoxDecoration(
      //   //  image: DecorationImage(
      //   //       image: AssetImage('images/login.png'), fit: BoxFit.cover),
      // ),
      decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromARGB(255, 72, 245, 251), Color.fromARGB(255, 16, 108, 228)])
                    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 500,
          ),
          Image(image: 
          AssetImage('images/logo.png')
        ),
        SizedBox(
            height: 50,
          ),
        RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Welcome',
          style: GoogleFonts.portLligatSans(
            // textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          children: [
            TextSpan(
              text: ' Report ',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Waste',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            ),
          ]),
    )
        ],
      ),
    ),
    LocationPage(),
    Profil(),
    // ReportDetailsView(report: report,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _navigateBattomBar,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_outlined), label: 'Report'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: 'Profil'),
            // BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: 'Detail'),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil2'),
          ]),
      // body: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot){
      //     if(snapshot.hasData){
      //       return Maps();
      //     } else {
      //       return SignUpPage();
      //     }
      //   },
      // ),
    );
  }
}
