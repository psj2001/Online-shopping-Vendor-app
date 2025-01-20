import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_vendor_app/model/Product%20model.dart';
import 'package:online_shopping_vendor_app/service/Manage%20http%20response.dart';

import '../utils/global variable.dart';

class ProductController {
  Future<void> uploadPrProduct({
  required BuildContext context,
  required String productName,
  required int productPrice,
  required int quantity,
  required String description,
  required String category,
  required String vendorId,
  required String fullName,
  required String subCategory,
  required List<File>? PickedImages,
}) async {
  if (PickedImages == null || PickedImages.isEmpty) {
    showSnackbar(context, 'Select Image');
    return;
  }

  final cloudinary = CloudinaryPublic("dzp3hv4fy", "geuhgz9u");
  List<String> images = [];

  for (var i = 0; i < PickedImages.length; i++) {
    CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(PickedImages[i].path, folder: productName),
    );
    images.add(cloudinaryResponse.secureUrl);
  }

  if (category.isEmpty || subCategory.isEmpty) {
    showSnackbar(context, 'Please select both category and subcategory');
    return;
  }

  final Product product = Product(
    id: '',
    productName: productName,
    productPrice: productPrice,
    quantity: quantity,
    description: description,
    category: category,
    vendorId: vendorId,
    fullName: fullName,
    subCategory: subCategory,
    image: images,
  );

  try {
    final response = await http.post(
      Uri.parse("$uri/api/add-product"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    manageHttpResponse(
      response: response,
      context: context,
      onSuccess: () {
        showSnackbar(context, 'Product Uploaded');
      },
    );
  } catch (e) {
    log('Error: $e');
    showSnackbar(context, 'Upload Failed');
  }
}
}
