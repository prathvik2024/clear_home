import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_dialog.dart';
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
    familyMemberList.add(FamilyMemberModel(
        "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
        "Vidhi Patel"));
    familyMemberList.add(FamilyMemberModel(
        "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
        "Petter Miller"));
    familyMemberList.add(FamilyMemberModel("https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg", "Arya Snow"));
    familyMemberList.addAll([...familyMemberList]);
    familyMemberList.addAll([...familyMemberList]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.familyMemberListStr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.familyMemberDetails,
                    arguments: {"image": familyMemberList[index].image, "name": familyMemberList[index].name});
              },
              child: Card(
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: EdgeInsets.only(left: 20, right: 10, top: 13, bottom: 13),
                  child: Row(
                    children: [
                      CircularImage(
                          imageWidget: Image.network(
                            familyMemberList[index].image,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        familyMemberList[index].name,
                        textAlign: TextAlign.left,
                        style: AppFonts.kPoppinsMedium.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              title: AppStrings.deleteFamilyMemberStr,
                              negativeOnclick: () {
                                Navigator.pop(context);
                              },
                              positiveOnclick: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 3), () => Navigator.pop(context));
                                      return CustomDialog(
                                        lottie: AppStrings.lottieDelete,
                                        title: AppStrings.deleteSuccessfullyStr,
                                      );
                                    });
                              },
                              negativeButtonName: AppStrings.noButtonStr,
                              positiveButtonName: AppStrings.yesButtonStr,
                            ),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.ellipsis_vertical,
                          color: AppColors.kDarkBlue,
                        ),
                      ),
                    ],
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
