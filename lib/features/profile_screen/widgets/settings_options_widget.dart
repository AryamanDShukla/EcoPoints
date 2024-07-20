import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';


class SettingsOptionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const SettingsOptionWidget({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 5.h,
              color: Colors.green[500],
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                title,
                style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
