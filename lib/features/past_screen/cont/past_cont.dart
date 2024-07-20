

import 'package:eco_points/common/custom_snackbar.dart';
import 'package:eco_points/features/past_screen/repo/past_repo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/past_model.dart';

//
// final pastControllerProvider = Provider((ref){
//    final pastRepo = ref.watch(pastScreenRepoProvider);
//    PastScreenController(pastRepo: pastRepo , ref: ref) ;
//  } );
//
// class PastScreenController{
//     final PastScreenRepo pastRepo;
//     final ProviderRef ref;
//     PastScreenController({required this.pastRepo, required this.ref});
//
//
//     ////// get the past list data ////
//      late List<DisposalDetail?>  pastList;
//
//      Future<List<DisposalDetail?>?> GetPastList(BuildContext context) async{
//
//        var data = await pastRepo.getPastData(context);
//        print(data.runtimeType);
//        print('ye run to ho rha hai disposal maeethod');
//        if(data!.status == '1'){
//           pastList = data.details;
//           print('this is the past list data ${pastList}');
//           CustomSnackbar.show(context, '${data.message}');
//           return pastList;
//        }
//        else{
//          CustomSnackbar.show(context, '${data.message}');
//        }
//
//      }
//
// }

final pastControllerProvider = Provider((ref) {
  final pastRepo = ref.watch(pastScreenRepoProvider);
  return PastScreenController(pastRepo: pastRepo, ref: ref);
});


// final pastControllerProvider = Provider((ref){
//    final pastRepo = ref.watch(pastScreenRepoProvider);
//    PastScreenController(pastRepo: pastRepo , ref: ref) ;
//  } );
//

class PastScreenController {
  final PastScreenRepo pastRepo;
  final ProviderRef ref;

  PastScreenController({required this.pastRepo, required this.ref});


  late List<DisposalDetail> pastList;
  Future<List<DisposalDetail>?> getPastList(BuildContext context) async {
    var data = await pastRepo.getPastData(context);
    if (data != null && data.status == '1') {
      pastList = data.details ?? [];
      return pastList;
    } else {
      CustomSnackbar.show(context, data?.message ?? 'Unknown error');
      return null;
    }
  }


//     ////// get the past list data ////
//      late List<DisposalDetail?>  pastList;
//
//      Future<List<DisposalDetail?>?> GetPastList(BuildContext context) async{
//
//        var data = await pastRepo.getPastData(context);
//        print(data.runtimeType);
//        print('ye run to ho rha hai disposal maeethod');
//        if(data!.status == '1'){
//           pastList = data.details;
//           print('this is the past list data ${pastList}');
//           CustomSnackbar.show(context, '${data.message}');
//           return pastList;
//        }
//        else{
//          CustomSnackbar.show(context, '${data.message}');
//        }
//
//      }
//
}