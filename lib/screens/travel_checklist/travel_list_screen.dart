import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../constants/fonts.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/home_widgets/circular_image.dart';

class TravelListScreen extends StatelessWidget {
  void Function(int index)? backScreen;

  TravelListScreen({super.key, this.backScreen});

  List<String> travelList = [
    "Italy",
    "America",
    "Kerla",
    "Bali",
    "Maharashtra",
    "Mumbai",
    "Italy",
    "America",
    "Kerla",
    "Bali",
    "Maharashtra",
    "Mumbai"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.travelListStr,
        backClick: () => backScreen?.call(1),
        actionWidgets: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      travelList[index],
                      textAlign: TextAlign.left,
                      style: AppFonts.kPoppinsMedium.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      color: Colors.white,
                      iconColor: AppColors.kDarkBlue,
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: "0",
                          ),
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: "1",
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == "0") {
                          Navigator.pushNamed(context, AppRoutes.addTravelList, arguments: {"isEdit": true});
                        } else {
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
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: travelList.length,
        ),
      ),
    );
  }
}
