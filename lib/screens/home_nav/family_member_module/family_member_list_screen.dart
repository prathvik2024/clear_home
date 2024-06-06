import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/custom_dialog.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/data_provider.dart';
import '../../../constants/strings.dart';

class FamilyMemberListScreen extends StatefulWidget {
  const FamilyMemberListScreen({super.key});

  @override
  State<FamilyMemberListScreen> createState() => _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState extends State<FamilyMemberListScreen> {
  void showDeleteAlertDialog(BuildContext context) {
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
                Future.delayed(const Duration(seconds: 3), () => Navigator.pop(context));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        backClick: () => Navigator.pop(context, {"": null}),
        screenName: AppStrings.familyMemberListStr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.familyMemberDetails,
                    arguments: {"image": DataProvider.familyMemberList[index].image, "name": DataProvider.familyMemberList[index].name});
              },
              child: Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 13, bottom: 13),
                  child: Row(
                    children: [
                      CircularImage(
                          imageWidget: Image.network(
                        DataProvider.familyMemberList[index].image,
                        fit: BoxFit.cover,
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        DataProvider.familyMemberList[index].name,
                        textAlign: TextAlign.left,
                        style: AppFonts.kPoppinsMedium.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        color: Colors.white,
                        iconColor: AppColors.kDarkBlue,
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: AppStrings.editStr,
                              child: Text(AppStrings.editStr),
                            ),
                            PopupMenuItem(
                              value: AppStrings.deleteStr,
                              child: Text(AppStrings.deleteStr),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == AppStrings.editStr) {
                            Navigator.pop(context, {"isEdit": true});
                          } else {
                            showDeleteAlertDialog(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: DataProvider.familyMemberList.length,
        ),
      ),
    );
  }
}
