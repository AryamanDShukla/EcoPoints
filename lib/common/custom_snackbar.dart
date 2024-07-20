import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'my_text_style.dart';


class CustomSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 3),

        content: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 4.w),
          child: Text(
            text,
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500, color: Colors.white ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
