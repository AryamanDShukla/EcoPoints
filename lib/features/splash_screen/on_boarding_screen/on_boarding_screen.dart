import 'package:eco_points/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/my_text_style.dart';
import '../../authentication/views/auth_screen.dart';





class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({int? index,}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        color: Color(0xFF000000),
      ),
      margin: EdgeInsets.only(right: 1.2.w),
      height: 1.h,
      curve: Curves.easeIn,
      width: _currentPage == index ? 4.w : 2.4.w,
    );
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Container(
                height: 67.h,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding:  EdgeInsets.only(left: 3.w, right: 3.w,top: 1.2.h),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            ClipRRect(
                              child: Image.asset(
                                contents[i].image,
                                height: 30.h,
                              ),
                              borderRadius: BorderRadius.circular(2.h),
                            ),

                            SizedBox( height: 3.h ),

                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: MyTextStyle.largeText,
                            ),
                             SizedBox(height: 1.7.h),
                             Text(
                              contents[i].desc,
                              style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                      (int index) => _buildDots(index: index),
                ),
              ),

              _currentPage + 1 == contents.length
                  ? Padding(
                    padding:  EdgeInsets.only(top:  7.h),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen(),), (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(  horizontal: 17.w, vertical: 1.4.h  ),

                      ),
                      child:  Text("START",style: MyTextStyle.smallMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500),),
                    ),
                  )
                  : Padding(
                   padding: EdgeInsets.only(top: 7.h, left: 7.w, right:  7.w),
                   child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    TextButton(
                      onPressed: () {
                        _controller.jumpToPage(2);
                      },

                      child:  Text( "SKIP",  style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500), ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.h),
                        ),

                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.4.h),

                      ),
                      child:  Text("NEXT",style: MyTextStyle.smallMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500 ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Recycle Plastics",
    image: 'images/eco.jpeg',
    desc: "Join the movement. Learn how to sort and recycle plastics correctly to reduce waste and protect the environment.",
  ),
  OnboardingContents(
    title: "Reduce Plastic Use",
    image: 'images/plastic1.jpg',
    desc: "Make a difference. Use reusable bags, bottles, and containers to minimize plastic consumption and waste.",
  ),
  OnboardingContents(
    title: "Support Sustainable Solutions",
    image: 'images/plastic2.jpg',
    desc: "Be part of the change. Support businesses and initiatives that promote plastic recycling and sustainable practices.",
  ),
];
