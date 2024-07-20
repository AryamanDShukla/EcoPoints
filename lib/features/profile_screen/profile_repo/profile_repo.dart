
import 'package:dio/dio.dart';
import 'package:eco_points/features/profile_screen/models/contact_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../common/custom_snackbar.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../models/faq_model.dart';
import '../models/privacy_model.dart';


final profileRepositoryProvider = Provider((ref) => ProfileRepository());

class ProfileRepository {

  Future<FAQResponse?> fetchFAQData(BuildContext context) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/get-faqs';
    final headers = {'auth_token': authToken};

    try {
      final response = await http.get(Uri.parse(uri), headers:  headers);
      if (response.statusCode == 200) {
        return FAQResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load FAQ data');
      }
    } catch (e) {
      print('Error fetching FAQ data: $e');
      return null;
    }
  }

  Future<PrivacyPolicyResponse?> fetchPrivacyPolicy(BuildContext context) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/get-privacy-policy';
    final headers = {'auth_token': authToken};

    try {
      final response = await http.get(Uri.parse(uri), headers: headers);
      if (response.statusCode == 200) {
        return PrivacyPolicyResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load privacy policy data');
      }
    } catch (e) {
      print('Error fetching privacy policy data: $e');
      return null;
    }
  }

  final Dio _dio = Dio();
  Future<Map<String, dynamic>?> raiseIssue(BuildContext context, String name, String email, String issue) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/raise-issue';
    final headers = {'auth_token': authToken};
    final formData = FormData.fromMap({'name': name, 'email': email, 'issue': issue});

    try {
      final response = await _dio.post(uri, options: Options(headers: headers), data: formData);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to raise issue');
      }
    } catch (e) {
      print('Error raising issue: $e');
      return null;
    }
  }



  Future<ContactInfo?> getContactInfo(BuildContext context) async {
    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return null;
    }

    final uri = 'https://mimidating.com/eco-points/get-admin-contact-info';
    final headers = {'auth_token': authToken};

    try {
      final response = await http.get(Uri.parse(uri), headers: headers);
      if (response.statusCode == 200) {
        return ContactInfo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load privacy policy data');
      }
    } catch (e) {
      print('Error fetching privacy policy data: $e');
      return null;
    }
  }

}
