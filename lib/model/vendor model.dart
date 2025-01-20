class Vendor {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String role;
  final String password;

  Vendor({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.role,
    required this.password,
  });

  // Convert a Vendor object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'role': role,
      'password': password,
    };
  }

  // Create a Vendor object from a JSON map
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String? ?? "",
      fullName: json['fullName'] as String ? ?? "",
      email: json['email'] as String ? ?? "",
      state: json['state'] as String ? ?? "",
      city: json['city'] as String ? ?? "",
      locality: json['locality'] as String ? ?? "",
      role: json['role'] as String ? ?? "",
      password: json['password'] as String ? ?? "",
    );
  }
  
}
