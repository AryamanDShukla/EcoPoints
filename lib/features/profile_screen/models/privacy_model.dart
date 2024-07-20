// privacy_policy_model.dart

class PrivacyPolicyResponse {
  String status;
  String message;
  PrivacyPolicyDetail details;

  PrivacyPolicyResponse({required this.status, required this.message, required this.details});

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyResponse(
      status: json['status'],
      message: json['message'],
      details: PrivacyPolicyDetail.fromJson(json['details']),
    );
  }
}

class PrivacyPolicyDetail {
  String id;
  String name;
  String content;

  PrivacyPolicyDetail({required this.id, required this.name, required this.content});

  factory PrivacyPolicyDetail.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyDetail(
      id: json['id'],
      name: json['name'],
      content: json['content'],
    );
  }
}
