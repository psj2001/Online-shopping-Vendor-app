import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_vendor_app/view/Navigation%20screens/Account%20screen/Account%20screen.dart';
import 'package:online_shopping_vendor_app/view/Navigation%20screens/Earning%20Screen/Earnings%20Screen.dart';
import 'package:online_shopping_vendor_app/view/Navigation%20screens/Edit%20Screen/Edit%20Screen.dart';
import 'package:online_shopping_vendor_app/view/Navigation%20screens/Orders%20Screen/Orders%20screen.dart';
import 'package:online_shopping_vendor_app/view/Navigation%20screens/Upload/upload%20screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageindex = 0;

  // Define screens for each page
  final List<Widget> _pages = [
    const EarningsScreen(),
    const UploadScreen(),
    const EditScreen(),
    const OrdersScreen(),
     AccountScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _pageindex = value;
          });
        },
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
             icon:Icon(CupertinoIcons.shopping_cart),
            label: 'Orders',
          ),
    
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Account',
          ),
        ],
      ),
      body: _pages[_pageindex], // Display selected screen
    );
  }
}

// Placeholder screens






