import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';




class MyCustomTextfield extends ConsumerStatefulWidget {
  TextEditingController controller;
  String labelText;
  int maxLines;
  TextInputType keyboardType;
   MyCustomTextfield({super.key,
     required this.controller,
     required this.labelText,
     required this.maxLines,
     required this.keyboardType
   });

  @override
  ConsumerState<MyCustomTextfield> createState() => _MyCustomTextfieldState();
}

class _MyCustomTextfieldState extends ConsumerState<MyCustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 3 )
            )
          ]
      ),
      child: TextFormField(
        controller: widget.
        controller,
        style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500, color:  Colors.black),
        decoration: InputDecoration(
          labelText: widget.labelText,
          contentPadding: EdgeInsets.all( 2.h ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade300,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        cursorColor: Colors.black,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
