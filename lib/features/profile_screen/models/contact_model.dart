


class ContactInfo {
  String status;
  String message;
  ContactDetail details;

  ContactInfo({required this.status, required this.message, required this.details});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      status: json['status'],
      message: json['message'],
      details: ContactDetail.fromJson(json['details']),
    );
  }
}


class ContactDetail {
  final String email;
  final String phone;
  final String twitter;
  final String instagram;

  ContactDetail({
    required this.email,
    required this.phone,
    required this.twitter,
    required this.instagram,
  });

  factory ContactDetail.fromJson(Map<String, dynamic> json) {
    return ContactDetail(
      email: json['email'],
      phone: json['phone'],
      twitter: json['twitter'],
      instagram: json['instagram'],
    );
  }
}