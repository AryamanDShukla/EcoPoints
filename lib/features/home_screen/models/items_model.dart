


class Items {
  final String status;
  final String message;
  final List<ItemDetail> details;

  Items({
    required this.status,
    required this.message,
    required this.details,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    var list = json['details'] as List;
    List<ItemDetail> detailsList = list.map((i) => ItemDetail.fromJson(i)).toList();

    return Items(
      status: json['status'],
      message: json['message'],
      details: detailsList,
    );
  }
}


class ItemDetail {
  final String id;
  final String itemName;
  final String pointsRecycled;
  final String pointsReused;
  final String pointsCarbon;

  ItemDetail({
    required this.id,
    required this.itemName,
    required this.pointsRecycled,
    required this.pointsReused,
    required this.pointsCarbon,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['id'],
      itemName: json['item_name'],
      pointsRecycled: json['points_recycled'],
      pointsReused: json['points_reused'],
      pointsCarbon: json['points_carbon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'points_recycled': pointsRecycled,
      'points_reused': pointsReused,
      'points_carbon': pointsCarbon,
    };
  }
}

