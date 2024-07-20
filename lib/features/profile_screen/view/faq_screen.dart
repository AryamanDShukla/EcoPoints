import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/my_text_style.dart';
import '../models/faq_model.dart';
import '../profile_cont/profile_cont.dart';
import '../widgets/my_faq_container.dart';


class FAQScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends ConsumerState<FAQScreen> {
  List<FAQDetail>? faqList;

  @override
  void initState() {
    super.initState();
    fetchFAQData();
  }

  fetchFAQData() async {
    var faqData = await ref.read(profileControllerProvider).getFAQData(context);

    setState(() {
      faqList = faqData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('FAQ', style: MyTextStyle.mediumLarge.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.green[500],
      ),
      body: faqList == null || faqList!.isEmpty
          ? faqList == null
          ? Center(
        child: SizedBox(
          height: 3.h,
          width: 3.h,
          child: CircularProgressIndicator(color: Colors.black),
        ),
      )
          : Center(
        child: Text(
          'No FAQs available.',
          style: MyTextStyle.mediumText.copyWith(fontWeight: FontWeight.w500),
        ),
      )
          : Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          itemCount: faqList?.length,
          itemBuilder: (context, index) {
            final faq = faqList?[index];
            return My_Faq_Container(
              question: faq!.question,
              answer: faq.answer,
            );
          },
        ),
      ),
    );
  }
}
