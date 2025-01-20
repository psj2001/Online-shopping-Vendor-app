import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_vendor_app/controller/product%20controller.dart';
import 'package:online_shopping_vendor_app/controller/sub%20category%20controller.dart';
import 'package:online_shopping_vendor_app/main.dart';
import 'package:online_shopping_vendor_app/model/category%20model.dart';
import 'package:online_shopping_vendor_app/model/subcategory%20model.dart';
import 'package:online_shopping_vendor_app/provider/vendor_provider.dart';

import '../../../controller/category controller.dart';
import '../../../service/Manage http response.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final ProductController _productController = ProductController();
  late String productName;
  late int productPrice;
  late int quantity;
  late String description;

  bool isLoading = false;

  late Future<List<Category>> futureCategories;
  Future<List<SubcategoryModel>>? futuresubcategories;
  Category? selectedCategory;
  SubcategoryModel? selectedSubCategory;

  File? _imageFile;
  Uint8List? _imageBytes;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String subcategoryname;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  // Create an instance of image picker to handle the Image selection
  final ImagePicker picker = ImagePicker();

//Initialize an empty List to store selected images
  List<File> images = [];

//Define a function ton choose image from the gallery

  ChooseImage() async {
// Use the picker to select an image from the gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//Check if no image was picked
    if (pickedFile == null) {
      print("no Image picked");
    } else {
      //if an image was picked, update the state and add  the image to the list
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  getSubcategoryByCategory(value) {
//  Fetch subcategories  base on the selected subcategory
    futuresubcategories =
        SubCategoryController().getSubcategoriesByCategoryName(value.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Screen")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200, 
                child: FutureBuilder<List<Category>>(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Subcategories'));
                    } else {
                      final categories = snapshot.data!;
                      return DropdownButton<Category>(
                        hint: const Text('Select Subcategory'),
                        items: categories.map((category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                            selectedSubCategory =
                                null; // Clear the selected subcategory
                          });
                          getSubcategoryByCategory(selectedCategory);
                          log("Selected Category: ${selectedCategory!.name}");
                        },
                      );
                    }
                  },
                ),
              ),
          
              //////////////////////////////////////////////////////////////////////////////////////////
          
              SizedBox(
                width: 200,
                child: FutureBuilder<List<SubcategoryModel>>(
                  future: futuresubcategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Subcategories'));
                    } else {
                      final subcategories = snapshot.data!;
                      return DropdownButton<SubcategoryModel>(
                        hint: const Text('Select Subcategory'),
                        items: subcategories.map((subcategory) {
                          return DropdownMenuItem<SubcategoryModel>(
                            value: subcategory,
                            child: Text(subcategory.subCategoryName),
                          );
                        }).toList(),
                        value: selectedSubCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedSubCategory = value;
                          });
                          log("Selected Subcategory: ${selectedSubCategory!.subCategoryName}");
                        },
                      );
                    }
                  },
                ),
              ),
          
              SizedBox(
                width: 200,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Name";
                    } else {
                      null;
                    }
                  },
                  onChanged: (value) {
                    productName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Product',
                    hintText: 'Enter Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Product Quantity";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    try {
                      quantity = int.parse(value);
                    } catch (e) {
                      log("Invalid input for quantity: $value");
                      quantity = 0; // Default or handle invalid value
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter quantity',
                    hintText: 'Enter Product quantity',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Product Price";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    try {
                      productPrice = int.parse(value);
                    } catch (e) {
                      log("Invalid input for product price: $value");
                      productPrice = 0; // Default or handle invalid value
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Price',
                    hintText: 'Enter Product Price',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
          
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Product Description";
                    } else {
                      null;
                    }
                  },
                  onChanged: (value) {
                    description = value;
                  },
                  maxLines: 3,
                  maxLength: 500,
                  decoration: InputDecoration(
                    labelText: 'Enter Description',
                    hintText: 'Enter Product Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: images.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    //if the index is 0, display an iconbutton to add a new image
                    return index == 0
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                ChooseImage();
                              },
                              icon: Icon(Icons.add),
                            ),
                          )
                        : SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.file(images[index - 1]),
                          );
                  },
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    final vendorId = ref.read(vendorProvider)!.id;
                    print("vendor id: $globalVendorId");
          
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      if (selectedCategory != null &&
                          selectedSubCategory != null) {
                        final fullName = ref.read(vendorProvider)!.fullName;
                        final vendorId = ref.read(vendorProvider)!.id;
          
                        await _productController
                            .uploadPrProduct(
                              context: context,
                              productName: productName,
                              productPrice: productPrice,
                              quantity: quantity,
                              description: description,
                              category: selectedCategory!.name,
                              vendorId:
                                  '$globalVendorId', //"678622ec494371c7ae050acc"
                              fullName: fullName,
                              subCategory:
                                  selectedSubCategory!.subCategoryName,
                              PickedImages: images,
                            )
                            .whenComplete(() {});
                        setState(() {
                          isLoading = false;
                          selectedCategory = null;
                          selectedSubCategory = null;
                          images.clear();
                        });
                      } else {
                        showSnackbar(context,
                            'Please select both category and subcategory');
                      }
                    } else {
                      showSnackbar(
                          context, 'Please fill out all required fields');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:isLoading?CircularProgressIndicator(
                        color: Colors.white,
                      ): Text(
                        "Upload",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 1.7),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
