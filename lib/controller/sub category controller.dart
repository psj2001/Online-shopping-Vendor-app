import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:online_shopping_vendor_app/model/subcategory%20model.dart';
import 'package:online_shopping_vendor_app/utils/global%20variable.dart';

class SubCategoryController {
  // Load the uploaded category
  Future<List<SubcategoryModel>> getSubcategoriesByCategoryName(String categoryName) async {
    try {
      // Validate categoryName to ensure it's not empty or null
      if (categoryName.isEmpty) {
        log("Category name is empty.");
        return [];
      }

      // Make the HTTP GET request
      final response = await http.get(Uri.parse('$uri/api/category/$categoryName/subcategories'));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      // Check for successful response
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          return data.map((subcategory) => SubcategoryModel.fromJson(subcategory)).toList();
        } else {
          log("No subcategories found for category: $categoryName");
          return [];
        }
      } else if (response.statusCode == 400) {
        log("Bad request: Invalid category name - $categoryName");
        return [];
      } else {
        log("Failed to load subcategories: ${response.statusCode}");
        throw Exception("Failed to load subcategories");
      }
    } catch (e, stackTrace) {
      log("Error fetching subcategories: $e", stackTrace: stackTrace);
      return [];
    }
  }
}
