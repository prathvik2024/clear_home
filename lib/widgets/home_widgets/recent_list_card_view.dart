import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/recent_task_model.dart';

class RecentListCardView extends StatelessWidget {
  List<RecentTaskModel> recentTaskList = [];
  bool shrinkWrap;
  ScrollPhysics? physics;

  RecentListCardView({super.key, required this.recentTaskList, this.shrinkWrap = false, this.physics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics ?? BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.kHomeBg, borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      recentTaskList[index].icon
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recentTaskList[index].title,
                      style: AppFonts.kPoppinsMedium.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      recentTaskList[index].date,
                      style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  recentTaskList[index].personName,
                  style: AppFonts.kPoppinsRegular.copyWith(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        );
      },itemCount: recentTaskList.length,
    );
  }
}
