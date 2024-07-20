



class DeleteModel {
  final String status;
  final String message;

  DeleteModel({required this.status, required this.message});

  factory DeleteModel.fromJson(Map<String, dynamic> json) {
    return DeleteModel(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
}
