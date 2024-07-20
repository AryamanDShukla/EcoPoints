
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/home_screen/cont/home_cont.dart';
import '../features/profile_screen/models/user_data_model.dart';

class ThisHomeScreen extends ConsumerStatefulWidget {
  const ThisHomeScreen({super.key});

  @override
  ConsumerState<ThisHomeScreen> createState() => _ThisHomeScreenState();
}

class _ThisHomeScreenState extends ConsumerState<ThisHomeScreen> {


  @override
  void initState() {
    super.initState();
    myFunc();

  }

  UserData? data;
  myFunc() async{
    var info = ref.read(homeControllerProvider);
    print(info.runtimeType); // ye wala home screen cont hai
    // info.Data(context);
    // var data = info.userData?.points;
    //  print('I am about to print the points and it is ${data}');
    // //UserData userInfo = userData.Data(context);
    var userData = await info.Data(context);
    setState(() {
      data = userData;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: Text(data?.points ?? '0'),),
    );
  }
}




