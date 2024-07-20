import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/home_screen/repo/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../authentication/views/auth_token_manager.dart';
import '../../profile_screen/models/user_data_model.dart';
import '../models/items_model.dart';
import 'package:dio/dio.dart';

final homeControllerProvider = Provider((ref) {
  final homeRepo = ref.watch(homeScreenRepoProvider);
  return HomeScreenController(homeRepo: homeRepo, ref: ref);
});

class HomeScreenController {
  final HomescreenRepo homeRepo;
  final ProviderRef ref;

  HomeScreenController({required this.homeRepo, required this.ref});

  ////////// getting the data /////
  late UserData userData;
  Future<UserData?> Data(BuildContext context) async {
    var data = await homeRepo.getUserData(context);
    if (data!.status == '1') {
      userData = data.details;
      return data.details;
    } else {
      CustomSnackbar.show(context, '${data.message}');
    }
  }

  /////getting items and list ////
  late List<ItemDetail?> itemsList;
  Future<List<ItemDetail?>?> getItemData(BuildContext context) async {
    var data = await homeRepo.getItems(context);
    if (data!.status == '1') {
      itemsList = data.details;
      return itemsList;
    } else {
      CustomSnackbar.show(context, '${data.message}');
    }
  }

  /// Submit Disposal
  Future<bool> submitDisposal(BuildContext context,
      {required String itemId,
        required String disposalMethod,
        required double weight,
        required String description,
        required XFile image}) async {

    final authToken = await AuthTokenManager.getAuthToken();
    if (authToken == null) {
      CustomSnackbar.show(context, 'Authentication token not found.');
      return false;
    }

    final uri = 'https://mimidating.com/eco-points/disposal-submission';
    final dio = Dio();
    final formData = FormData.fromMap({
      'item_id': itemId,
      'disposal_method': disposalMethod,
      'weight': weight.toString(),
      'description': description,
      'image': await MultipartFile.fromFile(image.path, filename: 'disposal_image.jpg'),
    });
    print(formData.toString());
    print('this is form data');

    try {
      final response = await dio.post(uri,
          data: formData,
          options: Options(headers: {'auth_token': authToken}));

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.show(context, 'Failed to submit disposal.');
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(context, 'An error occurred.');
      return false;
    }
  }
}








