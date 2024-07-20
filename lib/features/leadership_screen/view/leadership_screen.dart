import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/my_text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home_screen/cont/home_cont.dart';
import '../../profile_screen/models/user_data_model.dart';
import '../cont/leadership_cont.dart';
import '../model/leadership_model.dart';


class LeadershipScreen extends ConsumerStatefulWidget {
  const LeadershipScreen({super.key});

  @override
  ConsumerState<LeadershipScreen> createState() => _LeadershipScreenState();
}

class _LeadershipScreenState extends ConsumerState<LeadershipScreen> {
  List<LeaderboardDetail>? leaderboard;
  UserData? data;
  int points = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
    _fetchLeaderboard();
  }

  void _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points') ?? 0;
    });
  }

  void _fetchLeaderboard() async {
    var controller = ref.read(leaderboardControllerProvider);
    var userinfo = ref.read(homeControllerProvider);

    var userData = await userinfo.Data(context);
    var list = await controller.getLeaderboard(context);
    setState(() {
      data = userData;
      leaderboard = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Your points: ',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            '${data?.points ?? 0}',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Leadership Board',
          style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: leaderboard == null
            ? Center(child: SizedBox(height: 3.h, width: 3.h, child: CircularProgressIndicator(color: Colors.black,)))
            : ListView.builder(
          itemCount: leaderboard!.length,
          itemBuilder: (context, index) {
            final user = leaderboard![index];
            var toprank = (user.rank == 1 || user.rank == 2 || user.rank == 3) ? true : false;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:  toprank
                      ? [Colors.amber.shade600, Colors.amber.shade600, Colors.amber.shade300]
                      : [Colors.green.shade500, Colors.green.shade400, Colors.green.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(1.h),
              ),
              margin: EdgeInsets.only(bottom:  user.rank == 3 ? 2.5.h:  1.h),
              child: ListTile(
                leading:

                user.image.isNotEmpty
                    ? CircleAvatar(
                  radius: 3.4.h,
                  backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : AssetImage('images/default_avatar.png') as ImageProvider,
                )
                    : CircleAvatar(
                  radius: 3.4.h,
                  backgroundColor: Colors.white,
                ),
                title: Text(
                  user.name,
                  style: toprank ? MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500) : MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 16.8.sp),
                ),
                subtitle: Text(
                  '${user.points} points',
                  style: toprank ? MyTextStyle.smallText.copyWith(fontWeight: FontWeight.w500) : MyTextStyle.smallText.copyWith(fontWeight: FontWeight.w500, fontSize: 15.5.sp),
                ),
                trailing: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Text('#${user.rank} ',
                        style: toprank
                            ?   MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, fontSize: 17.6.sp)
                            :  MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500, )
                    ),
                    Icon(Icons.stars,
                        color: toprank ?   Colors.yellow : Colors.white,
                        size: toprank ? 3.h : 2.8.h
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
