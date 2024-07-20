import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../common/custom_snackbar.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../model/leadership_model.dart';
import 'package:flutter/material.dart';


final leaderboardRepoProvider = Provider((ref) => LeaderboardRepo());

class LeaderboardRepo {
  Future<Leaderboard?> getLeaderboardData(BuildContext context) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/leaderboard';
    final headers = {'auth_token': authToken};

    try {
      final response = await http.get(Uri.parse(uri), headers: headers);
      return Leaderboard.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Error fetching leaderboard data: $e');
      return null;
    }
  }
}
