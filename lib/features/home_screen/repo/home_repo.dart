import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:eco_points/common/custom_snackbar.dart';
import 'package:flutter/material.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../../profile_screen/models/user_data_model.dart';
import '../models/items_model.dart';


final homeScreenRepoProvider = Provider((ref) => HomescreenRepo() );



class HomescreenRepo{

  ////to get user data to have name points /////
  Future<UserModel?> getUserData(BuildContext context) async{

    final authToken = await AuthTokenManager.getAuthToken();

    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }
     print(authToken);
    final uri = 'https://mimidating.com/eco-points/get-user-details';
    final Map<String, String> headers = {
      'auth_token': authToken!,
    };

    try{
      final response = await http.get(Uri.parse(uri), headers: headers);
      final userData = UserModel.fromJson(jsonDecode(response.body));

      return userData;
    }
    catch(e){
      print('this is the catch $e');
    }
  }


  ////to get items in the recycling list ////
  Future<Items?> getItems(BuildContext context) async{

    final authToken = await AuthTokenManager.getAuthToken();

    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/get-items';
    final Map<String, String> headers = {
      'auth_token': authToken!,
    };

    try{
      final response = await http.get(Uri.parse(uri), headers: headers);
      final items = Items.fromJson(jsonDecode(response.body));

      return items;
    }
    catch(e){
      print('this is the catch $e');
    }
  }

}