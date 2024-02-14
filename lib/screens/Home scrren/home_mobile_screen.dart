import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:originproject/screens/LienHe/LienHe.dart';

import 'package:originproject/screens/Login/login_mobile_screen.dart';
import 'package:originproject/screens/NhatKiKhaiThac/NhatKiKhaiThac.dart';
import 'package:originproject/screens/TheoDoiHaiTrinh/TheoDoiHaiTrinh.dart';

import '../../components/PoliMap.dart';
import '../QuanLiTau/QuanLiTau.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Set<Polyline> _polylines = Set<Polyline>();
  static List<Widget> _widgetOptions = <Widget>[
    PolylineMap(), // Thay thế GoogleMap bằng PolylineMap
    PolylineMap(),
    PolylineMap(),
    PolylineMap(),
    PolylineMap(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Bản đồ", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/images/avatar.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Triệu Thanh Tùng",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/bg.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Tàu quản lí',style: TextStyle(color: Colors.black),),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
                // Navigate to the QuanLiTau page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuanLiTau()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/book.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Theo dõi hải trình',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TheoDoiHaiTrinh(tenTau: 'tau1')),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/writing.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Nhật kí khai thác',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NhatKi()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/contact.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Liên hệ',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LienHe()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/assets/images/logout.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Đăng xuất',style: TextStyle(color: Colors.black)),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MobileLoginLayout()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
