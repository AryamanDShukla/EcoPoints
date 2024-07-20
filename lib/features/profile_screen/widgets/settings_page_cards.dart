import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';

class SettingsPageCard extends StatefulWidget {
  String title;
  Function() function;
   SettingsPageCard({super.key,
    required this.title,
    required this.function,
  });

  @override
  State<SettingsPageCard> createState() => _SettingsPageCardState();
}

class _SettingsPageCardState extends State<SettingsPageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        height: 6.h,
        margin:  EdgeInsets.symmetric(horizontal: 4.w ,vertical: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 2.6.w ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white
        ),

        child: Row(
          children: [

            Expanded(child: Text(widget.title,style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),)),
            Icon(Icons.arrow_right_rounded,size: 3.4.h,color: Colors.black,),


          ],
        ),
      ),
    );
  }
}


