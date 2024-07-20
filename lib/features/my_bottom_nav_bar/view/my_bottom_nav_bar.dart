import 'package:eco_points/common/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/my_text_style.dart';
import '../controller/bottom_nav_controller.dart';


class MyBottomNavigationBar extends ConsumerStatefulWidget {
  MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  ConsumerState<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends ConsumerState<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var navData = ref.watch(navigationBarProvider);
    return Scaffold(
      body: navData.widgetOptions.elementAt(navData.selectedIndex),
      bottomNavigationBar: Container(
        color: lightGreen,
        child: BottomNavigationBar(
          currentIndex: navData.selectedIndex,
          onTap: (index) {
            setState(() {
              navData.onItemTapped(index);
            });
          },
          backgroundColor: lightGreen,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          unselectedLabelStyle: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              backgroundColor: lightGreen,
              icon: Icon(Icons.home_rounded, size: 2.7.h),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: lightGreen,
              icon: Icon(Icons.work_history, size: 2.7.h),
              label: 'Past',
            ),
            BottomNavigationBarItem(
                backgroundColor: lightGreen,
                icon: Icon(Icons.scoreboard_rounded, size: 2.7.h,),
                label: 'Leadership'
            ),
            BottomNavigationBarItem(
              backgroundColor: lightGreen,
              icon: Icon(Icons.settings, size: 2.7.h),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
