class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  // Factory constructor: Mengubah Map<String, dynamic> dari JSON ke Objek UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Method: Mengubah Objek UserModel kembali ke Map/JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}