


class PasswordModel {
  final String status;
  final String message;

  PasswordModel({required this.status, required this.message});

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
}
