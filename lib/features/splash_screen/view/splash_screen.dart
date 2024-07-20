import 'dart:async';
import 'package:eco_points/features/authentication/views/auth_token_manager.dart';
import 'package:eco_points/features/my_bottom_nav_bar/view/my_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../on_boarding_screen/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  Future<void> changeScreen() async {

    Timer(const Duration(seconds: 3), () async {

      String? authToken = await AuthTokenManager.getAuthToken();
      authToken != null
          ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyBottomNavigationBar(),), (route) => false)
          : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnboardingScreen(),), (route) => false);

    });
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/eco.jpeg'),
              SizedBox(height: 4.h,),
              const CircularProgressIndicator(color: Colors.black,)
            ],
          ),
        ),
      ),
    );
  }
}
