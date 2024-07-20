


import 'package:flutter/foundation.dart';

import '../../home_screen/models/items_model.dart';
//
// class PastDisposal {
//   final String status;
//   final String message;
//   final List<DisposalDetail> details;
//
//   PastDisposal({
//     required this.status,
//     required this.message,
//     required this.details,
//   });
//
//   factory PastDisposal.fromJson(Map<String, dynamic> json) {
//     var list =  json['details'] != null ?  json['details'] as List : null;
//     List<DisposalDetail> detailsList = list?.map((i) => DisposalDetail.fromJson(i)).toList();
//     return PastDisposal(
//       status: json['status'] as String,
//       message: json['message'] as String,
//       details: detailsList,
//     );
//   }
// }
// class DisposalDetail {
//   final String id;
//   final String itemId;
//   final String itemName;
//   final String status;
//   final String disposalMethod;
//   final String weight;
//   final String description;
//   final String points;
//   final String disposalImage;
//   final String createdAt;
//
//   DisposalDetail({
//     required this.id,
//     required this.itemId,
//     required this.itemName,
//     required this.status,
//     required this.disposalMethod,
//     required this.weight,
//     required this.description,
//     required this.points,
//     required this.disposalImage,
//     required this.createdAt,
//   });
//
//   factory DisposalDetail.fromJson(Map<String, dynamic> json) {
//     return DisposalDetail(
//       id: json['id'] as String,
//       itemId: json['item_id'] as String,
//       itemName: json['item_name'] as String,
//       status: json['status'] as String,
//       disposalMethod: json['disposal_method'] as String,
//       weight: json['weight'] as String,
//       description: json['description'] as String,
//       points: json['points'] as String,
//       disposalImage: json['disposal_image'] as String,
//       createdAt: json['created_at'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'item_id': itemId,
//       'item_name': itemName,
//       'status': status,
//       'disposal_method': disposalMethod,
//       'weight': weight,
//       'description': description,
//       'points': points,
//       'disposal_image': disposalImage,
//       'created_at': createdAt,
//     };
//   }
// }

import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../../home_screen/models/items_model.dart';

class PastDisposal {
  final String status;
  final String message;
  final List<DisposalDetail>? details;

  PastDisposal({
    required this.status,
    required this.message,
    this.details,
  });

  factory PastDisposal.fromJson(Map<String, dynamic> json) {
    var list = json['details'] != null ? json['details'] as List : [];
    List<DisposalDetail> detailsList = list.map((i) => DisposalDetail.fromJson(i)).toList();
    return PastDisposal(
      status: json['status'] as String,
      message: json['message'] as String,
      details: detailsList,
    );
  }
}

class DisposalDetail {
  final String id;
  final String itemId;
  final String itemName;
  final String status;
  final String disposalMethod;
  final String weight;
  final String description;
  final String points;
  final String disposalImage;
  final String createdAt;

  DisposalDetail({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.status,
    required this.disposalMethod,
    required this.weight,
    required this.description,
    required this.points,
    required this.disposalImage,
    required this.createdAt,
  });

  factory DisposalDetail.fromJson(Map<String, dynamic> json) {
    return DisposalDetail(
      id: json['id'] as String,
      itemId: json['item_id'] as String,
      itemName: json['item_name'] as String,
      status: json['status'] as String,
      disposalMethod: json['disposal_method'] as String,
      weight: json['weight'] as String,
      description: json['description'] as String,
      points: json['points'] as String,
      disposalImage: json['disposal_image'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_id': itemId,
      'item_name': itemName,
      'status': status,
      'disposal_method': disposalMethod,
      'weight': weight,
      'description': description,
      'points': points,
      'disposal_image': disposalImage,
      'created_at': createdAt,
    };
  }
}






