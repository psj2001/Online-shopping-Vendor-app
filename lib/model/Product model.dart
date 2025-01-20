class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> image;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.subCategory,
    required this.image,
  });

  // Factory constructor to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
      description: json['description'],
      category: json['category'],
      vendorId: json['vendorId'],
      fullName: json['fullName'],
      subCategory: json['subCategory'],
      image: List<String>.from(json['image']),
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'image': image,
    };
  }
}
