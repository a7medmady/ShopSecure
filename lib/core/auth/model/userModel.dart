class UserModel {
  final String username;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final int uId;

  UserModel({
    required this.username,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    username: json['username'] ?? '',
    fname: json['firstName'] ?? '',
    lname: json['lastName'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    uId: json['id'] ?? 0,
  );
}

  Map <String ,dynamic> toJson () {
    return {
      'username': username,
      'firstName': fname,
      'lastName': lname,
      'email': email,
      'phone': phone,
      'id': uId,
    };
  }
}