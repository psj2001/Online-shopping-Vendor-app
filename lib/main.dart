import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shopping_vendor_app/provider/vendor_provider.dart';
import 'package:online_shopping_vendor_app/view/screen/main%20vendor%20screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/screen/authentication.dart/Loginscreen.dart';
String? globalVendorId; // Declare a global variable
void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {

  Future<void> _checkTokenAnduser(WidgetRef ref) async {
  // Obtain an instance of SharedPreferences for local data storage
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Retrieve the authentication token and user data stored locally
  String? token = preferences.getString('auth_token');
  String? vendorJson = preferences.getString('vendor');

  // If both token and user data are available, update the user state
  if (token != null && vendorJson != null) {
    // Print vendorJson for debugging
    print("vendorJson====>>$vendorJson");

    // Parse the vendorJson string into a Map
    Map<String, dynamic> vendorData = jsonDecode(vendorJson);

    // Extract _id from vendorData
    String? vendorId = vendorData['_id'];

    // Save _id in SharedPreferences for later use
    await preferences.setString('vendor_id', vendorId ?? '');

    // You can print the vendorId to confirm
    globalVendorId=vendorId;
    print("Vendor ID: $globalVendorId");

    // Update the state with the vendor data
    ref.read(vendorProvider.notifier).setVendor(vendorJson);
  } else {
    ref.read(vendorProvider.notifier).signOut();
  }
}
    return MaterialApp( 
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: FutureBuilder(
          future: _checkTokenAnduser(ref),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
            }
         final vendor = ref.watch(vendorProvider);
         return vendor != null? MainVendorScreen():Loginsreen();
         }
          ),
    );

  }

}

