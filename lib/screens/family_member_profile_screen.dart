import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/fonts.dart';
import '../constants/strings.dart';
import '../widgets/home_widgets/circular_image.dart';

class FamilyMemberProfileScreen extends StatelessWidget {
  Map<String, String>? args;

  FamilyMemberProfileScreen({super.key, required this.args});

  List<String> columnList = [AppStrings.memberNameTagStr, AppStrings.relationTagStr, AppStrings.mobileTagStr, AppStrings.emailTagStr];

  List<String> userInfo = ["David Smith", "Family Owner", "1234567890", "davidsmith@gmail.com"];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularImage(
                        imageWidget: (args != null)
                            ? Image.network(
                                args!["image"]!,
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                AppStrings.svgImageNotFound,
                                fit: BoxFit.cover,
                              ),
                        width: 80,
                        height: 80,
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        AppStrings.svgChat,
                        width: 34,
                        height: 34,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(
                      columnList.length,
                      (index) {
                        return Column(children: [
                          if (index != 0) ...[
                            SizedBox(
                              height: 8,
                            )
                          ],
                          Row(
                            children: [
                              Container(
                                width: width * 0.35,
                                child: Text(
                                  columnList[index],
                                  style: AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black.withOpacity(0.60)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(userInfo[index],
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          if (index != columnList.length - 1) ...[
                            Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.05),
                            )
                          ]
                        ]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
