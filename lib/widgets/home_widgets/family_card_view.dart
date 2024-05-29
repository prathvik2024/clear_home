import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/strings.dart';
import '../../models/family_card_model.dart';

class FamilyCardView extends StatelessWidget {
  List<FamilyCardModel> familyCardList = [];

  FamilyCardView({super.key, required this.familyCardList});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(right: 15, left: (index == familyCardList.indexOf(familyCardList.first)) ? 21 : 0),
          color: familyCardList[index].color,
          child: Container(
            width: width * 0.43,
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.12), spreadRadius: 2)]),
                    child: ClipRRect(child: Image.network(familyCardList[index].profileImage, fit: BoxFit.cover,), borderRadius: BorderRadius.circular(25))),
                SizedBox(
                  height: 10,
                ),
                Text(
                  familyCardList[index].personName,
                  style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppStrings.svgAccount),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      familyCardList[index].personType,
                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppStrings.svgFamily),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      familyCardList[index].familyCategory,
                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppStrings.svgTaskList,
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      familyCardList[index].taskList,
                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: familyCardList.length,
    );
  }
}
