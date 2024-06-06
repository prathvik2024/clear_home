import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../constants/data_provider.dart';
import '../../constants/fonts.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_dialog.dart';

class TravelListScreen extends StatelessWidget {
  final void Function(String)? backScreen;

  const TravelListScreen({super.key, this.backScreen});

  void showDeleteAlertDialog(BuildContext context) {
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
        screenName: AppStrings.travelListStr,
        backClick: () => backScreen?.call(AppStrings.homeStr),
        actionWidgets: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.search_rounded,
              color: AppColors.kDarkBlue,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      DataProvider.travelList[index],
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
                          Navigator.pushNamed(context, AppRoutes.addTravelList, arguments: {"isEdit": true});
                        } else {
                          showDeleteAlertDialog(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: DataProvider.travelList.length,
        ),
      ),
    );
  }
}
