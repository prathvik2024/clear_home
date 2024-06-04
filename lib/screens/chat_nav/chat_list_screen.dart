import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/chat_model.dart';

class ChatListScreen extends StatefulWidget {
  Function(int index)? backScreen;

  ChatListScreen({super.key, this.backScreen});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel> chatList = [
    ChatModel(
        image: "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg",
        personName: "John Snow",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 10,
        time: "2 hr"),
    ChatModel(
        image:
            "https://img.freepik.com/free-photo/horizontal-portrait-smiling-happy-young-pleasant-looking-female-wears-denim-shirt-stylish-glasses-with-straight-blonde-hair-expresses-positiveness-poses_176420-13176.jpg",
        personName: "Vidhi Patel"),
    ChatModel(
        image:
            "https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg",
        personName: "Petter Miller",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 3,
        time: "5 hr"),
    ChatModel(
        image: "https://img.freepik.com/free-photo/front-view-smiley-girl-looking-away_23-2148244695.jpg",
        personName: "Arya Snow",
        lastMessage: AppStrings.descriptionStr,
        pendingMessageCount: 1,
        time: "3 hr ")
  ];

  @override
  void initState() {
    super.initState();
    chatList.addAll([...chatList.reversed]);
    chatList.addAll([...chatList.reversed]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.messagesStr,
        backClick: () {
          widget.backScreen?.call(0) ?? null;
        },
        actionWidgets: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(
              AppStrings.svgChatMenu,
              color: AppColors.kDarkBlue,
            ),
          )
        ],
      ),
      body: Container(
        height: height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.chatDetails, arguments: {"modelData": chatList[index]});
                },
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularImage(
                            imageWidget: Image.network(
                          chatList[index].image,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: width * 0.55,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chatList[index].personName,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                              ),
                              if (chatList[index].lastMessage?.isNotEmpty ?? false) ...[
                                Text(
                                  chatList[index].lastMessage!,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: width * 0.1,
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                chatList[index].time ?? "3 hr",
                                style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: Checkbox.width,
                                width: Checkbox.width,
                                decoration: BoxDecoration(color: AppColors.kDarkBlue, borderRadius: BorderRadius.circular(Checkbox.width / 2)),
                                child: Center(
                                  child: Text(
                                    chatList[index].pendingMessageCount?.toString() ?? "12",
                                    style: AppFonts.kPoppinsMedium.copyWith(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: chatList.length,
        ),
      ),
    );
  }
}
