import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/common/my_text_style.dart';
import 'package:eco_points/features/home_screen/cont/home_cont.dart';
import 'package:eco_points/features/home_screen/models/items_model.dart';
import 'package:eco_points/features/home_screen/models/submitted_model.dart';
import 'package:eco_points/features/profile_screen/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

import '../../../common/colors.dart';
import '../../authentication/views/auth_token_manager.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? selectedItem;
  double? itemWeight;
  String description = '';
  String disposalMethod = 'recycled';
  XFile? imageFile;
  bool isLoading = false;

  final disposalMethods = ['recycled', 'reused', 'carbon_footprint'];

  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFunc();
  }

  List<ItemDetail?>? itemsList;
  UserData? data;

  fetchFunc() async {
    var info = ref.read(homeControllerProvider);

    var userData = await info.Data(context);
    var list = await info.getItemData(context);

    setState(() {
      data = userData;
      itemsList = list;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = pickedImage;
    });
  }

  submitDisposal() async {
    if (selectedItem == null || itemWeight == null || description.isEmpty || imageFile == null) {
      CustomSnackbar.show(context, 'Please fill in all fields and upload an image.');
      return;
    }
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return;
    }

    var item = itemsList!.firstWhere((item) => item!.itemName == selectedItem);
    final uri = 'https://mimidating.com/eco-points/disposal-submission';
    final dio = Dio();


    final formData = FormData.fromMap({
      'item_id': item!.id,
      'disposal_method': disposalMethod,
      'weight': itemWeight.toString(),
      'description': description,
      'disposal_image': await MultipartFile.fromFile(imageFile!.path),
    });

    Future.delayed(Duration(seconds: 2), () {
      CustomSnackbar.show(context, 'Please wait, this might take a while.');
    }, );

    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.post(uri,
          data: formData,
          options: Options(headers: {'auth_token': authToken}));

      if (response.statusCode == 200) {
          var submit = SubmittedModel.fromJson(response.data);
          if(submit.status == '1'){
            CustomSnackbar.show(context, '${submit.message}');
          }
          else{
            CustomSnackbar.show(context, '${submit.message}');
          }
      } else {
        CustomSnackbar.show(context, 'Failed to submit disposal.');

      }
    } catch (e) {
      print('this is the error ${e.toString()}');
      CustomSnackbar.show(context, 'An error occurred.');
    }
    finally{
      setState(() {
        isLoading = false;
        // selectedItem = null;
        // itemWeight = null;
        // description = '';
        // disposalMethod = 'recycled';
        // imageFile = null;
        // weightController.clear();
        // descriptionController.clear();
      });
      fetchFunc();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Current Points: ',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            '${data?.points}',
            style: MyTextStyle.smallMedium.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Eco Points Tracker ',
          style: MyTextStyle.mediumLarge.copyWith(
              fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.green[500],
        actions: [
          Icon(
            Icons.control_point_duplicate_rounded,
            color: Colors.white,
            size: 2.3.h,
          ),
          Text(
            ' ${data?.points}   ',
            style: MyTextStyle.mediumText
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h),
            DropdownButtonFormField<String>(
              value: selectedItem,
              hint: const Text('Select item to recycle'),
              items: itemsList?.map((item) {
                return DropdownMenuItem<String>(
                  value: item!.itemName,
                  child: Text(item.itemName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                )
            ),
            SizedBox(height: 1.8.h),
            DropdownButtonFormField<String>(
              value: disposalMethod,
              items: disposalMethods.map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  disposalMethod = value!;
                });
              },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                )
            ),
            SizedBox(height: 1.8.h),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                labelText: 'Weight of item (in grams)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.green[50],
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                itemWeight = double.tryParse(value);
              },
            ),
            SizedBox(height: 1.8.h),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                labelText: 'Description of disposal method.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.green[50],
              ),
              maxLines: 4,
              onChanged: (value) {
                description = value;
              },
            ),
            SizedBox(height: 1.8.h),
            Container(
              height: 15.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green.shade100)),
              child: imageFile == null
                  ? Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline_rounded,size: 2.5.h,color: Colors.black,),
                      Text(' Please upload an image.',style: MyTextStyle.smallMedium,)
                    ],
                  ),
                ),
              )
                  : Row(
                children: [
                  Container(
                    width: 55.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.h),
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        border: Border.all(color: Colors.black),
                        color: Colors.grey.shade200, // Light grey background for subtlety
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera,
                            size: 2.5.h,
                            color: darkGreen, // Blue icon for visibility
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Update',
                            style: MyTextStyle.smallMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: darkGreen, // Matching text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Center(
              child: ElevatedButton(
                onPressed: submitDisposal,
                child: isLoading
                    ? SizedBox(height: 2.h,width: 2.h,child: CircularProgressIndicator(color: Colors.white,),)
                    : Text('Submit', style: MyTextStyle.smallMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric( horizontal: 8.w, vertical: 0.8.h ), backgroundColor: darkGreen,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(1.h) ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
