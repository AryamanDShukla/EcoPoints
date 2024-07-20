import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';
import '../models/contact_model.dart';
import '../profile_cont/profile_cont.dart';



class MyContactUsWidget extends ConsumerStatefulWidget {
  const MyContactUsWidget({super.key});

  @override
  ConsumerState<MyContactUsWidget> createState() => _MyContactUsWidgetState();
}

class _MyContactUsWidgetState extends ConsumerState<MyContactUsWidget> {
  Widget _buildContactInfo(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 1),
        Text(info,
            style: MyTextStyle.smallText),
        SizedBox( height: 2.h ),
      ],
    );
  }


  ContactDetail? contactInfo;

  @override
  void initState() {
    super.initState();
    fetchContactData();
  }

  fetchContactData() async {
    var contactData = await ref.read(profileControllerProvider).getContactInfo(context);

    setState(() {
      contactInfo = contactData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      child:
      contactInfo?.email != null ?
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          Divider(color: Colors.black38,thickness: 2,),
          SizedBox(height: 1.h),
          _buildContactInfo('Email', '${contactInfo?.email}'),
          _buildContactInfo('Phone Number', '${contactInfo?.phone}'),
          _buildContactInfo('Twitter', '${contactInfo?.twitter}'),
          _buildContactInfo('Instagram', '${contactInfo?.instagram}'),
          SizedBox(height: 1.h),
        ],
      )
          : Center(child: SizedBox(height: 3.h, width: 3.h, child: CircularProgressIndicator(color: Colors.black,),),)
    );
  }
}
