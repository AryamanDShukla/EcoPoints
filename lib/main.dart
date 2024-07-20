import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/splash_screen/view/splash_screen.dart';


void main() {
  runApp( ProviderScope(child: const MyApp ()) ) ;

  // runApp(
  //    DevicePreview(
  //     enabled: true,
  //     builder: (context){
  //       return MyApp();
  //     },
  //   ),
  // );

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    super.initState();
    // Listen for internet connection status changes




  }



  @override
  Widget build(BuildContext context) {

    return ResponsiveSizer(
      maxMobileWidth: double.infinity,
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white
              ),
              title: 'Fix My Giz User App',
              home:
              SplashScreen(),

            ),


        );
      },
    );
  }
}

