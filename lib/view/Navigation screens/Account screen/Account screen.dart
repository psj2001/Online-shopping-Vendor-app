

import 'package:flutter/material.dart';
import 'package:online_shopping_vendor_app/controller/vendor_auth_controller.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});

 final VendorAuthController _vendorAuthController = VendorAuthController();

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(onPressed: () async{

      await _vendorAuthController.signOutVendor(context: context);

    }, child: Text("Logout")));
  }
}
