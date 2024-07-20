import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';



class My_Faq_Container extends StatelessWidget {
  final String question;
  final String answer;

  My_Faq_Container({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26,blurRadius: 2,offset: Offset(0,3))
            ]
        ),
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          collapsedBackgroundColor: Colors.white70,
          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          backgroundColor: Colors.green.shade500,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),

          title: Text(
            question,
            style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.5.h),
              child: Text(answer,style: MyTextStyle.smallMedium.copyWith(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
