



class SubmittedModel {
  final String status;
  final String message;

  SubmittedModel({required this.status, required this.message});

  factory SubmittedModel.fromJson(Map<String, dynamic> json) {
    return SubmittedModel(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
}
