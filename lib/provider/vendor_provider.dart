import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/vendor model.dart'; // Add this import to use jsonDecode

class VendorProvider extends StateNotifier<Vendor?> {
  VendorProvider()
      : super(Vendor(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            role: '',
            password: ''));

  //Getter Method to start value from an object
  Vendor? get vendor => state;

  //Method to set vendor user state from json
  void setVendor(String vendorJson) {
    // Convert the JSON string to a Map<String, dynamic>
    Map<String, dynamic> vendorMap = jsonDecode(vendorJson);
    // Set the state by parsing the JSON map
    state = Vendor.fromJson(vendorMap);
  }
  void signOut(){
    state=null;
  }

}

  //Make the data accisible within the application
  final vendorProvider = StateNotifierProvider<VendorProvider , Vendor?>((ref){
    return VendorProvider();
  });