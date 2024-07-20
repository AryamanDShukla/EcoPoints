



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../common/custom_snackbar.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../model/past_model.dart';

// var pastScreenRepoProvider = Provider((ref) => PastScreenRepo());
//
// class PastScreenRepo{
//
//   //// get past data list/////
//   Future<PastDisposal?>  getPastData(BuildContext context) async{
//
//     final authToken = await AuthTokenManager.getAuthToken();
//     print(authToken);
//     if (authToken == null) {
//       CustomSnackbar.show(context, 'Authentication token not found.');
//       return null;
//     }
//
//     final uri = 'https://mimidating.com/eco-points/disposal-history';
//     final Map<String, String> headers = {
//       'auth_token': authToken!,
//     };
//
//     try{
//       final response = await http.get(Uri.parse(uri), headers: headers);
//       final pastData = PastDisposal.fromJson(jsonDecode(response.body));
//
//       return pastData;
//     }
//     catch(e){
//       print('this is the catch $e');
//     }
//   }
//
// }

var pastScreenRepoProvider = Provider((ref) => PastScreenRepo());

class PastScreenRepo {
  Future<PastDisposal?> getPastData(BuildContext context) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/disposal-history';
    final headers = {'auth_token': authToken};

    try {
      final response = await http.get(Uri.parse(uri), headers: headers);
      return PastDisposal.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('this is the catch $e');
      return null;
    }
  }
}