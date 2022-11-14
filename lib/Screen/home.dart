import 'package:app_waste_report/Screen/detail_laporan.dart';
import 'package:app_waste_report/Screen/history.dart';
import 'package:app_waste_report/Screen/location.dart';
import 'package:app_waste_report/Screen/profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBattomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  final List<Widget> _pages = [
    Center(
      child: Text(
        'Sedang Dalam perbaikan'
      ),
    ),
    LocationPage(),
    history(),
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
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
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
