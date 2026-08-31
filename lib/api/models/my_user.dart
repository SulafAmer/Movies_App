class MyUser {
  // collection name
  static const String collectionName = 'Users';

  String id;
  String email;
  String name;
  String phone;
  String avatar;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.avatar = '',
  });

  MyUser.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        avatar: json['avatar'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar': avatar,
    };
  }
}
