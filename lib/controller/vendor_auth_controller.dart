import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_vendor_app/provider/vendor_provider.dart';
import 'package:online_shopping_vendor_app/service/Manage%20http%20response.dart';
import 'package:online_shopping_vendor_app/view/screen/main%20vendor%20screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/vendor model.dart';
import '../utils/global variable.dart';
import '../view/screen/authentication.dart/Loginscreen.dart';
final providerContainer = ProviderContainer();

class VendorAuthController {
  Future<void> signUpVendor({
    required String fullName,
    required String email,
    required String password,
    required context,
  }) async {
    try {
      // Create a Vendor object
      Vendor vendor = Vendor(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        role: '',
        password: password,
      );

      // Convert Vendor object to JSON
      String vendorJson = jsonEncode(vendor.toJson());

      // Send POST request with JSON body
      http.Response response = await http.post(
        Uri.parse("$uri/api/vendor/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: vendorJson,
      );

      // Handle the HTTP response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Account was created');
        },
      );
    } catch (e) {
      // Catch any errors during the request
      print("Error: $e");
      showSnackbar(context, 'An error occurred. Please try again.');
    }
  }

  Future<void> signInVendor({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      // Send POST request with JSON body
      http.Response response = await http.post(
        Uri.parse("$uri/api/vendor/signin"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      // Handle the HTTP response
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async{

          SharedPreferences preferences = await SharedPreferences.getInstance();

          //Extract the authentication token from the response body
          String token =jsonDecode(response.body)['token'];

          //Store the authentication token securely in shared_preferences
        await  preferences.setString('auth_token', token);

          //Encode the user data recived from the backend as  json
          final  vendorJson = jsonEncode(jsonDecode(response.body)['vendor']);

         providerContainer.read(vendorProvider.notifier).setVendor(vendorJson);
         await preferences.setString('vendor', vendorJson);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return MainVendorScreen();
          }), (route) => false);
          showSnackbar(context, 'Login successfully');
        },
      ); 
    } catch (e) {
      // Catch any errors during the request
      print("Error: $e");
      showSnackbar(context, 'An error occurred. Please try again.');
    }
  }

    //signOut
Future<void> signOutVendor({required context}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Clear token and user data
    await preferences.remove("auth_token");
    await preferences.remove("vendor");

    // Clear application state
    providerContainer.read(vendorProvider.notifier).signOut();

    // Log state
    log('User signed out successfully');

    // Navigate to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Loginsreen()),
      (route) => false,
    );

    // Show snackbar confirmation
    showSnackbar(context, 'Signed out successfully');
  } catch (e) {
    log('Sign-out error: $e');
    showSnackbar(context, 'An error occurred. Please try again.');
  }
}
}
  