class UserModel {
  final String? uId;
  final String? fullName;
  final String? email;
  final DateTime? createdAt;

  UserModel({
    required this.fullName,
    required this.email,
    required this.uId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'],
      fullName: map['fullName'],
      email: map['email'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }
}
