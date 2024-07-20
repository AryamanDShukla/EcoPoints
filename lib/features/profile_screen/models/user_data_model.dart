
class UserModel {
  final String status;
  final String message;
  final dynamic details; // It can be UserDetails, List<String>, or null

  UserModel({
    required this.status,
    required this.message,
    this.details,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      details: json['details'] is List
          ? json['details'].cast<String>()
          : json['details'] != null
          ? UserData.fromJson(json['details'])
          : null,
    );
  }
}

class UserData {
  final String id;
  final String deleted;
  final String points;
  final String name;
  final String email;
  final String image;
  final String createdAt;
  final String updatedAt;


  UserData({
    required this.id,
    required this.deleted,
    required this.points,
    required this.name,
    required this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      deleted: json['deleted'],
      points: json['points'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}