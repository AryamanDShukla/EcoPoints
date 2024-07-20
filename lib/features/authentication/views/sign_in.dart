import 'package:dio/dio.dart';
import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/authentication/views/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/colors.dart';
import '../../../common/my_text_style.dart';
import '../../my_bottom_nav_bar/view/my_bottom_nav_bar.dart';
import '../models/model_for_sign_in.dart';
import 'auth_token_manager.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  Login? login;
  UserDetails? userDetails;

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      CustomSnackbar.show(context, 'Please enter both fields.');
      return;
    }

    final uri = 'https://mimidating.com/eco-points/login';

    final formData = FormData.fromMap({
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().post(uri, data: formData);

      if (response.statusCode == 200) {
        login = Login.fromJson(response.data);

        if (login?.status == '1') {
          CustomSnackbar.show(context, 'Login successful.');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyBottomNavigationBar() ) );
          setState( () {
            userDetails = login?.details;
           });
          if (userDetails?.authToken != null) {
            print('this is the auth token         ');
            print(userDetails!.authToken);
            await AuthTokenManager.setAuthToken(userDetails!.authToken);
          }
        } else {
          CustomSnackbar.show(context, '${login?.message}');
        }
      } else {
        CustomSnackbar.show(context, 'Login failed.');
      }
    } catch (e) {
      CustomSnackbar.show(context, 'An error occurred.');
    } finally {
      setState(() {
        _emailController.clear();
        _passwordController.clear();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Remove focus when tapping anywhere on the screen
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFFCDDC39)], // Gradient colors from the logo
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.h,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(1.h),
                          child: Image.asset('images/eco.jpeg', height: 22.h)), // Logo image
                      SizedBox(height: 2.h),
                      Text(
                        'Sign In',
                        style: MyTextStyle.largeText.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.h),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.h),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.h),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        obscureText: !_passwordVisible,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h, top: 2.h),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green, // Button color from the logo
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.7.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.2.h),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(height: 2.7.h, width: 2.7.h, child: CircularProgressIndicator(color: Colors.white,))
                          : Text(
                        'Sign In',
                        style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 0.7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?  ', style: MyTextStyle.smallText),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen(),), (route) => false,);
                            },
                            child: Text('Sign Up', style: MyTextStyle.smallText.copyWith(fontWeight: FontWeight.w500),)
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
