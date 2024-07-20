


class Leaderboard {
  final String status;
  final String message;
  final List<LeaderboardDetail> details;

  Leaderboard({
    required this.status,
    required this.message,
    required this.details,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    var list = json['details'] != null ? json['details'] as List : [];
    List<LeaderboardDetail> detailsList = list.map((i) => LeaderboardDetail.fromJson(i)).toList();
    return Leaderboard(
      status: json['status'] as String,
      message: json['message'] as String,
      details: detailsList,
    );
  }
}

class LeaderboardDetail {
  final String id;
  final String points;
  final String name;
  final String image;
  final String createdAt;
  final int rank;

  LeaderboardDetail({
    required this.id,
    required this.points,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.rank,
  });

  factory LeaderboardDetail.fromJson(Map<String, dynamic> json) {
    return LeaderboardDetail(
      id: json['id'] as String,
      points: json['points'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      createdAt: json['created_at'] as String,
      rank: json['rank'] as int,
    );
  }

}
