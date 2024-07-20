import 'package:dio/dio.dart';
import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/profile_screen/models/password_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/my_text_style.dart';
import '../../authentication/views/auth_token_manager.dart';
  // Import the AuthTokenManager class

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController recheckPasswordController = TextEditingController();
  bool _isLoading = false;
  PasswordModel? password;


  Future<void> _changePassword() async {
    final String currentPassword = currentPasswordController.text;
    final String newPassword = newPasswordController.text;
    final String recheckPassword = recheckPasswordController.text;

    // Check if any field is empty
    if (currentPassword.isEmpty || newPassword.isEmpty || recheckPassword.isEmpty) {
      CustomSnackbar.show(context, 'Please fill in all fields.');
      return;
    }

    // Check if new password and recheck password match
    if (newPassword != recheckPassword) {
      CustomSnackbar.show(context, 'New passwords do not match.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String? authToken = await AuthTokenManager.getAuthToken();

      if (authToken == null) {
        CustomSnackbar.show(context, 'Authentication token not found.');
        return;
      }

      final uri = 'https://mimidating.com/eco-points/change-user-password';

      final formData = FormData.fromMap({
        'current_password': currentPassword,
        'new_password': newPassword,
      });

      final response = await Dio().post(
        uri,
        data: formData,
        options: Options(
          headers: {
            'auth_token': authToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          password = PasswordModel.fromJson(response.data);
        });

        if(password?.status == '1'){
          CustomSnackbar.show(context, '${password?.message}');
        }
        else{
          CustomSnackbar.show(context, '${password?.message}');
        }

      } else {
        CustomSnackbar.show(context, 'Failed to change password.');
      }
    } catch (e) {
      CustomSnackbar.show(context, 'An error occurred.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Change Password', style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.green[500],
      ),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To change your password, please fill in the fields below and click "Save".',
              style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                hintText: 'Current Password',
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.h),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                hintText: 'New Password',
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.h),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: recheckPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                hintText: 'Recheck Password',
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.h),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[500],
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.7.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.4.h),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(height: 2.7.h, width: 2.7.h, child: CircularProgressIndicator(color: Colors.white,))
                    : Text(
                  'Save',
                  style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
