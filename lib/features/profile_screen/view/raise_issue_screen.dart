// raise_issue_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';
import '../profile_cont/profile_cont.dart';
import '../widgets/my_custom_textfield.dart';

class RaiseIssueScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<RaiseIssueScreen> createState() => _RaiseIssueScreenState();
}

class _RaiseIssueScreenState extends ConsumerState<RaiseIssueScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var settingsData = ref.read(profileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Raise Issue', style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.green[500],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 3.h),
              MyCustomTextfield(
                controller: settingsData.nameController,
                labelText: 'Your name',
                maxLines: 1,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 2.3.h),
              MyCustomTextfield(
                controller: settingsData.emailController,
                labelText: 'Your email',
                maxLines: 1,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 2.3.h),
              MyCustomTextfield(
                controller: settingsData.issueController,
                labelText: 'Describe your issue',
                maxLines: 5,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 2.3.h),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  bool success = await settingsData.raiseIssue(context);
                  if (success) {
                    // Handle success, like clearing the fields or navigating to another screen
                    settingsData.nameController.clear();
                    settingsData.emailController.clear();
                    settingsData.issueController.clear();

                  }
                  else{
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: Container(
                  height: 5.5.h,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 23.w, vertical: 2.h),
                  child: Center(
                    child:
                    loading ? SizedBox(height: 3.h, width: 3.h, child: CircularProgressIndicator(color: Colors.white,),)
                        : Text('Submit', style: MyTextStyle.mediumText.copyWith(color: Colors.white, fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
