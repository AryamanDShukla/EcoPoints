class Registration {
  final String status;
  final String message;
  final dynamic details; // It can be UserDetails, List<String>, or null

  Registration({
    required this.status,
    required this.message,
    this.details,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      status: json['status'],
      message: json['message'],
      details: json['details'] is List
          ? json['details'].cast<String>()
          : json['details'] != null
          ? UserDetails.fromJson(json['details'])
          : null,
    );
  }
}



class UserDetails {
  final String id;
  final String deleted;
  final String points;
  final String name;
  final String email;
  final String image;
  final String createdAt;
  final String updatedAt;
  final String authToken;

  UserDetails({
    required this.id,
    required this.deleted,
    required this.points,
    required this.name,
    required this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.authToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      deleted: json['deleted'],
      points: json['points'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      authToken: json['auth_token'],
    );
  }

}


