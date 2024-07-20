class FAQResponse {
  final String status;
  final String message;
  final List<FAQDetail> details;

  FAQResponse({
    required this.status,
    required this.message,
    required this.details,
  });

  factory FAQResponse.fromJson(Map<String, dynamic> json) {
    var list = json['details'] != null ? json['details'] as List : [];
    List<FAQDetail> detailsList = list.map((i) => FAQDetail.fromJson(i)).toList();
    return FAQResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      details: detailsList,
    );
  }
}

class FAQDetail {
  final String id;
  final String question;
  final String answer;
  final String createdAt;

  FAQDetail({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory FAQDetail.fromJson(Map<String, dynamic> json) {
    return FAQDetail(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'created_at': createdAt,
    };
  }
}
