import 'dart:convert';
import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/profile_screen/models/delete_model.dart';
import 'package:eco_points/features/profile_screen/models/logout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio/dio.dart';
import '../../../common/my_text_style.dart';
import '../../authentication/views/auth_screen.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../../home_screen/cont/home_cont.dart';
import '../models/user_data_model.dart';
import '../widgets/my_contact_us_widget.dart';
import '../widgets/settings_page_cards.dart';
import 'change_password_screen.dart';
import 'faq_screen.dart';
import 'privacy_policy_screen.dart';
import 'raise_issue_screen.dart';
import 'package:http/http.dart' as http;


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  UserData? data;


  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var userinfo = ref.read(homeControllerProvider);

    var userData = await userinfo.Data(context);

    setState(() {
      data = userData;
    });
  }

  LogoutModel? logout;
  Future<void> _logout() async {
    final authToken = await AuthTokenManager.getAuthToken();

    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return;
    }

    final uri = 'https://mimidating.com/eco-points/logout';

    try {
      final response = await Dio().delete(uri, options: Options(headers: {'auth_token': authToken}));

      if (response.statusCode == 200) {
        logout = LogoutModel.fromJson(response.data);
        if (logout?.status == '1') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
          AuthTokenManager.clearAuthToken();
          CustomSnackbar.show(context, '${logout?.message}');
        } else {
          CustomSnackbar.show(context, '${logout?.message}');
        }
      } else {
        CustomSnackbar.show(context, 'Failed to logout.');
      }
    } catch (e) {
      CustomSnackbar.show(context, 'An error occurred.');
    }
  }


  DeleteModel? delete;
  Future<void> _deleteAccount() async {
    final authToken = await AuthTokenManager.getAuthToken();

    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return;
    }

    final uri = 'https://mimidating.com/eco-points/delete-account';

    try {
      final response = await Dio().delete(uri, options: Options(headers: {'auth_token': authToken}));

      if (response.statusCode == 200) {
        delete = DeleteModel.fromJson(response.data);
        if (delete?.status == '1') {
          CustomSnackbar.show(context, '${delete?.message}');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
          AuthTokenManager.clearAuthToken();
        } else {
          CustomSnackbar.show(context, '${delete?.message}');
        }
      } else {
        CustomSnackbar.show(context, 'Failed to delete account.');
      }
    } catch (e) {
      CustomSnackbar.show(context, 'An error occurred.');
    }
  }


  void _showConfirmationDialog(String action) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)),
          title: Text(action == 'logout' ? 'Logout' : 'Delete Account', style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),),
          content: Text('Are you sure you want to $action?', style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),),
          actions: [
            Container(
              height: 3.9.h,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: Colors.red
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              height: 3.9.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.h),
                color: Colors.green
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (action == 'logout') {
                    _logout();
                  } else {
                    _deleteAccount();
                  }
                },
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ),
          ]
,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Settings', style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.green[500],
      ),
      body:
      data != null
      ? SingleChildScrollView(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(4, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 2.h, bottom: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: data!.image.isNotEmpty ? NetworkImage(data!.image) : null,
                        backgroundColor: Colors.green,
                        child: data!.image.isEmpty ? Text('${data!.name.substring(0, 1).toUpperCase()}', style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500, color: Colors.white)) : null,
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.name,
                            style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Coins: ${data!.points}',
                            style: MyTextStyle.smallText.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            SettingsPageCard(title: 'Change Password', function: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
            }),
            SettingsPageCard(title: 'Raise Issue', function: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RaiseIssueScreen()));
            }),
            SettingsPageCard(title: 'Contact Us', function: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MyContactUsWidget();
                },
              );
            }),
            // SettingsPageCard(title: 'Rate Us', function: () {}),
            SettingsPageCard(title: 'FAQ', function: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FAQScreen()));
            }),
            SettingsPageCard(title: 'Privacy Policy', function: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
            }),
            SettingsPageCard(title: 'Logout', function: () {
              _showConfirmationDialog('logout');
            }),
            SettingsPageCard(title: 'Delete Account', function: () {
              _showConfirmationDialog('delete account');
            }),
          ],
        ),
      )
      : Center(child: SizedBox(height: 3.h, width: 3.h, child: CircularProgressIndicator(color: Colors.black,),),),
    );
  }
}
