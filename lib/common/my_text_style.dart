
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class MyTextStyle{

  static TextStyle verySmall = TextStyle(
      fontSize: 15.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400
  ) ;

  static TextStyle smallText = TextStyle(
    fontSize: 15.4.sp,
    color: Colors.black,
    fontWeight: FontWeight.w400
  ) ;

  static TextStyle smallMedium = TextStyle(
      fontSize: 15.8.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400
  ) ;

  static TextStyle mediumText = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle mediumLarge = TextStyle(
    fontSize: 18.5.sp,
    color: Colors.black,
  );


  static TextStyle largeText = TextStyle(
    fontSize: 20.1.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static IconData backspace = Icons.keyboard_backspace_rounded;

}


class MyIcon{
  static const IconData backspace = Icons.keyboard_backspace_rounded;
}