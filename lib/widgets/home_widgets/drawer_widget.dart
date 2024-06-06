import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/colors.dart';
import '../../constants/data_provider.dart';
import '../../constants/fonts.dart';
import '../../constants/strings.dart';

class DrawerWidget extends StatelessWidget {
  final void Function(String?) onChange;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerWidget({super.key, required this.onChange, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.25,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(left: 25, right: 10, bottom: 0, top: 30),
            color: AppColors.kDrawerTopBg,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.closeDrawer();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.white,
                      )),
                ),
                Row(
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 4)]),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  AppStrings.imgProfile,
                                  fit: BoxFit.cover,
                                )),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.kDarkBlue,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.demoNameStr,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          AppStrings.demoEmailStr,
                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.15),
            height: 0.3,
          ),
          Expanded(
            child: Container(
              color: AppColors.kLiteBlue,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                            onChange(DataProvider.drawerList[index].title);
                          },
                          child: ExpansionTile(
                            enabled: DataProvider.drawerList[index].child != null,
                            shape: const Border(),
                            onExpansionChanged: (value) {
                              DataProvider.drawerList[index].isExpanded = value;
                              onChange(null);
                            },
                            leading: SvgPicture.asset(
                              DataProvider.drawerList[index].icon,
                              color: Colors.white,
                            ),
                            title: Text(
                              DataProvider.drawerList[index].title,
                              style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.white),
                            ),
                            trailing: (DataProvider.drawerList[index].child != null)
                                ? SvgPicture.asset((DataProvider.drawerList[index].isExpanded ? AppStrings.svgUpArrow : AppStrings.svgDownArrow))
                                : const SizedBox(),
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 25),
                                child: Column(
                                  children: List.generate(
                                    DataProvider.drawerList[index].child?.length ?? 0,
                                    (i) {
                                      return ListTile(
                                        onTap: () {
                                          DataProvider.drawerList[index].isExpanded = false;
                                          scaffoldKey.currentState?.closeDrawer();
                                          onChange(DataProvider.drawerList[index].child![i].title);
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        visualDensity: const VisualDensity(vertical: -4),
                                        leading: SvgPicture.asset(DataProvider.drawerList[index].child?[i].icon ?? ""),
                                        title: Text(
                                          DataProvider.drawerList[index].child?[i].title ?? "",
                                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.white.withOpacity(0.15),
                      ),
                  itemCount: DataProvider.drawerList.length),
            ),
          )
        ],
      ),
    );
  }
}
