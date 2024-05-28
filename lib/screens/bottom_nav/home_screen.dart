import 'dart:ui';

import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/widgets/home_widgets/family_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/strings.dart';
import '../../models/family_card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FamilyCardModel> familyCardList = [];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 21, right: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
        Row(
          children: [
            Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 2)]),
                child: ClipRRect(
                    child: Image.asset(
                      AppStrings.imgProfile,
                    ),
                    borderRadius: BorderRadius.circular(25))),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.search, color: AppColors.kDarkBlue,size: 28,)),
            IconButton(onPressed: (){}, icon: SvgPicture.asset(AppStrings.svgNotification, width: 28,height: 28,)),
          ],
        ),
            SizedBox(height: 30),
            Text(AppStrings.familyMembersStr, style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18),),
            SizedBox(height: 10),
            SizedBox(height: 210, child: FamilyCardView(familyCardList: familyCardList,))

      ]),
    );
  }
}
