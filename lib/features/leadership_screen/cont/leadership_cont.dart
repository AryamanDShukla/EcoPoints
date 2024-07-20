import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/custom_snackbar.dart';
import '../model/leadership_model.dart';
import '../repo/leadership_repo.dart';




final leaderboardControllerProvider = Provider((ref) {
  final leaderboardRepo = ref.watch(leaderboardRepoProvider);
  return LeaderboardController(leaderboardRepo: leaderboardRepo, ref: ref);
});

class LeaderboardController {
  final LeaderboardRepo leaderboardRepo;
  final ProviderRef ref;

  LeaderboardController({required this.leaderboardRepo, required this.ref});

  Future<List<LeaderboardDetail>?> getLeaderboard(BuildContext context) async {
    var data = await leaderboardRepo.getLeaderboardData(context);
    if (data != null && data.status == '1') {
      return data.details;
    } else {
      CustomSnackbar.show(context, data?.message ?? 'Unknown error');
      return null;
    }
  }
}
