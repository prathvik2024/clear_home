import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/data_provider.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_dialog.dart';

class MealListScreen extends StatelessWidget {
  final void Function(String)? backScreen;

  const MealListScreen({super.key, this.backScreen});

  void deleteAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: AppStrings.deleteTravelListStr,
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
        screenName: AppStrings.mealStr,
        backClick: () => backScreen?.call(AppStrings.homeStr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: (index == DataProvider.mealList.length - 1) ? 100 : 10),
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      DataProvider.mealList[index],
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
                          Navigator.pushNamed(context, AppRoutes.addMeal, arguments: {"isEdit": true});
                        } else {
                          deleteAlertDialog(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: DataProvider.mealList.length,
        ),
      ),
    );
  }
}
