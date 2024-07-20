
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/custom_snackbar.dart';
import '../models/contact_model.dart';
import '../models/faq_model.dart';
import '../models/privacy_model.dart';
import '../profile_repo/profile_repo.dart';

final profileControllerProvider = Provider((ref) {
  return ProfileController(profileRepo: ref.watch(profileRepositoryProvider));
});

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

class ProfileController {
  final ProfileRepository profileRepo;
  ProfileController({required this.profileRepo});


  Future<List<FAQDetail>> getFAQData(BuildContext context) async {
    var faqResponse = await profileRepo.fetchFAQData(context);
    if (faqResponse?.status == '1') {
      print(faqResponse?.status);
      print('this ist hhee datatus');
      return faqResponse?.details ?? [];
    } else {
      print('this is the issue');
    }
    return [];
  }


  Future<PrivacyPolicyDetail?> getPrivacyPolicyData(BuildContext context) async {
    var privacyPolicyResponse = await profileRepo.fetchPrivacyPolicy(context);
    if (privacyPolicyResponse?.status == '1') {
      return privacyPolicyResponse?.details;
    } else {
      print('Failed to load privacy policy');
    }
    return null;
  }


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController issueController = TextEditingController();
  Future<bool> raiseIssue(BuildContext context) async {
    final name = nameController.text;
    final email = emailController.text;
    final issue = issueController.text;

    if(name.isEmpty || email.isEmpty || issue.isEmpty){
      CustomSnackbar.show(context, 'Please enter every field.');
      return false;
    }

    var response = await profileRepo.raiseIssue(context, name, email, issue);
    if (response?['status'] == '1') {
      CustomSnackbar.show(context, response?['message']);
      return true;
    } else {
      CustomSnackbar.show(context, 'Failed to raise issue.');
      return false;
    }
  }



  Future<ContactDetail?> getContactInfo(BuildContext context) async {
    var contactInfo = await profileRepo.getContactInfo(context);
    if (contactInfo?.status == '1') {
      return contactInfo?.details;
    } else {
      print('Failed to load privacy policy');
    }
    return null;
  }

}
