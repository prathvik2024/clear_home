import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../models/family_member_model.dart';

class FamilyMemberListScreen extends StatefulWidget {
  const FamilyMemberListScreen({super.key});

  @override
  State<FamilyMemberListScreen> createState() => _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState extends State<FamilyMemberListScreen> {
  List<FamilyMemberModel> familyMemberList = [];

  @override
  void initState() {
    super.initState();
    familyMemberList.add(FamilyMemberModel("https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg", "John Snow"));
    familyMemberList.add(FamilyMemberModel("https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg", "Vidhi Patel"));
    familyMemberList.add(FamilyMemberModel("https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg", "Petter Miller"));
    familyMemberList.add(FamilyMemberModel("https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg", "Arya Snow"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.familyMemberListStr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: ListTile(
                  visualDensity: VisualDensity(horizontal: -4,),
                  contentPadding: EdgeInsets.zero,
                  leading: CircularImage(
                      imageWidget: Image.asset(
                    AppStrings.imgProfile,
                    fit: BoxFit.cover,
                  )),
                  title: Text(
                    familyMemberList[index].name,
                    textAlign: TextAlign.center,
                    style: AppFonts.kPoppinsMedium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.ellipsis_vertical,
                      color: AppColors.kDarkBlue,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: familyMemberList.length,
        ),
      ),
    );
  }
}
