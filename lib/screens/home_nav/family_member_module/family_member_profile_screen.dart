import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/data_provider.dart';
import '../../../constants/fonts.dart';
import '../../../constants/strings.dart';
import '../../../widgets/home_widgets/circular_image.dart';

class FamilyMemberProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? args;

  const FamilyMemberProfileScreen({super.key, this.args});

  @override
  Widget build(BuildContext context) {
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
                        imageWidget: (args?["image"] != null) // if(args != null && args["image"] != null)
                            ? Image.network(
                                args!["image"]!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppStrings.imgProfile,
                                fit: BoxFit.cover,
                              ),
                        width: 80,
                        height: 80,
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AppStrings.svgChat,
                        width: 34,
                        height: 34,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(
                      DataProvider.columnList.length,
                      (index) {
                        return Column(children: [
                          if (index != 0) ...[
                            const SizedBox(
                              height: 8,
                            )
                          ],
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  DataProvider.columnList[index],
                                  style: AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black.withOpacity(0.60)),
                                ),
                              ),
                              Expanded(
                                child: Text(DataProvider.userInfo[index],
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: AppFonts.kPoppinsRegular.copyWith(fontSize: 16, color: Colors.black)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (index != DataProvider.columnList.length - 1) ...[
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
