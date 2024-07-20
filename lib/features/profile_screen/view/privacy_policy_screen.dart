// privacy_policy_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../common/my_text_style.dart';

import '../models/privacy_model.dart';
import '../profile_cont/profile_cont.dart';

class PrivacyPolicyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends ConsumerState<PrivacyPolicyScreen> {
  PrivacyPolicyDetail? privacyPolicyDetail;

  @override
  void initState() {
    super.initState();
    fetchPrivacyPolicyData();
  }

  fetchPrivacyPolicyData() async {
    var privacyPolicyData = await ref.read(profileControllerProvider).getPrivacyPolicyData(context);

    setState(() {
      privacyPolicyDetail = privacyPolicyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Privacy Policy', style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.green[500],
      ),
      body: privacyPolicyDetail == null
          ? Center(
        child: SizedBox(
          height: 3.h,
          width: 3.h,
          child: CircularProgressIndicator(color: Colors.black),
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            HtmlWidget(privacyPolicyDetail!.content),

          ],
        ),
      ),
    );
  }
}
