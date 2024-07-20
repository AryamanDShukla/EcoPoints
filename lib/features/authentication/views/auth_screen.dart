import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/authentication/models/model_for_auth.dart';
import 'package:eco_points/features/authentication/views/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio/dio.dart';
import '../../../common/my_text_style.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

 Registration? registration ;

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final uri = 'https://mimidating.com/eco-points/register';


    final formData = FormData.fromMap({
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      if (_image != null)
        'image': await MultipartFile.fromFile(_image!.path),
    });

    setState(() {
      _isLoading = true;
    });


    try {
      final response = await Dio().post(uri, data: formData);

      if (response.statusCode == 200) {

        registration = Registration.fromJson(response.data);
        if(registration?.status == '1'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
          CustomSnackbar.show(context, 'Registration successful' );

        }
        else{
          CustomSnackbar.show(context, '${registration?.message}' );
        }

      } else {
        CustomSnackbar.show(context, 'Registration failed' );
      }
    } catch (e) {
      print(e.toString());
      print('this above is the error');
      CustomSnackbar.show(context, 'An error occurred.' );
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFFCDDC39)],
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
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? Icon(Icons.camera_alt, color: Colors.grey, size: 50)
                              : null,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Create an Account',
                        style: MyTextStyle.largeText.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.h),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
                            onTap: (){
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: _passwordVisible ? Icon(Icons.visibility_rounded, color: Colors.white,) : Icon(Icons.visibility_off_rounded, color: Colors.white,),
                          )


                        ),
                        obscureText: !_passwordVisible,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.h),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.h),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                              child: _confirmPasswordVisible ? Icon(Icons.visibility_rounded, color: Colors.white,) : Icon(Icons.visibility_off_rounded, color: Colors.white,),
                            )

                        ),
                        obscureText: !_confirmPasswordVisible,
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
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.7.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.2.h),
                        ),
                      ),
                      child:
                      _isLoading
                          ? SizedBox(height: 2.7.h, width: 2.7.h,child: CircularProgressIndicator(color: Colors.white,),)
                          : Text(
                        'Register',
                        style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                       ),
                    ),
                    SizedBox(height: 0.7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?  ', style: MyTextStyle.smallText),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignIn(),), (route) => false);
                            },
                            child: Text('Sign In', style: MyTextStyle.smallText.copyWith(fontWeight: FontWeight.w500),))
                      ],
                    )
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
