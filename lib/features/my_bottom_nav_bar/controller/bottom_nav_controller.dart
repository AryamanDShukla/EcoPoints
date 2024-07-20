

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home_screen/view/home_screen.dart';
import '../../leadership_screen/view/leadership_screen.dart';
import '../../past_screen/view/past_screen.dart';
import '../../profile_screen/view/profile_screen.dart';




final navigationBarProvider = Provider((ref) {
  return BottomNavBarController(ref: ref);
} );


class BottomNavBarController {
  final ProviderRef ref;
  BottomNavBarController({required this.ref});

  //////change the current pages /////
  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const PastScreen(),
    const LeadershipScreen(),
    const ProfileScreen(),
  ];

   onItemTapped(int index) {
      selectedIndex = index;
    }

}













