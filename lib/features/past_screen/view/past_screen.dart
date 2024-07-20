import 'dart:convert';
import 'dart:io';

import 'package:eco_points/common/colors.dart';
import 'package:eco_points/features/past_screen/cont/past_cont.dart';
import 'package:eco_points/features/past_screen/model/past_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/my_text_style.dart';
import '../../home_screen/cont/home_cont.dart';
import '../../profile_screen/models/user_data_model.dart';




class PastScreen extends ConsumerStatefulWidget {
  const PastScreen({super.key});

  @override
  ConsumerState<PastScreen> createState() => _PastScreenState();
}

class _PastScreenState extends ConsumerState<PastScreen> {
  List<DisposalDetail>? itemsList;
  UserData? data;

  @override
  void initState() {
    super.initState();
    fetchFunc();
  }

  fetchFunc() async {
    var info = ref.read(pastControllerProvider);
    var userinfo = ref.read(homeControllerProvider);

    var userData = await userinfo.Data(context);
    var list = await info.getPastList(context);

    setState(() {
      data = userData;
      itemsList = list?.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var info = ref.read(pastControllerProvider);
    return Scaffold(
      backgroundColor: (itemsList == null || itemsList!.isEmpty) ? Colors.white : Colors.green.shade100,

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Current Points: ',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            '${data?.points ?? 0}',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Past Recycles',
          style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.green[500],
      ),
      body: itemsList == null || itemsList!.isEmpty
          ? itemsList == null ? Center(child: SizedBox(height: 3.h, width: 3.h, child: CircularProgressIndicator(color: Colors.black,),)) :  Center(child: Text('Sorry no items recycled yet!', style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),),)
          : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            Expanded(
              child: ListView.builder(
                itemCount: itemsList?.length,
                itemBuilder: (context, index) {
                  final singleItem = itemsList?[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
                    margin: EdgeInsets.only(bottom: 2.h, left: 3.w, right: 3.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.2.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: singleItem?.disposalImage != ''
                              ? Image.network(singleItem!.disposalImage, height: 10.h, width: 25.w,fit: BoxFit.cover,)
                              : Container(height: 10.h, width: 25.w, color: Colors.grey.shade400,),
                        ),

                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                singleItem!.itemName,
                                style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
                              ),

                              Text(
                                'Weight: ${singleItem.weight}g',
                                style: MyTextStyle.smallText,
                              ),

                              Text(
                                'Points: ${singleItem.points}',
                                style:  MyTextStyle.smallText,
                              ),

                              Text(
                                'Description: ${singleItem.description}',
                                style:  MyTextStyle.smallText,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}










