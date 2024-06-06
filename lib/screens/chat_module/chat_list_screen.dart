import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatListScreen extends StatefulWidget {
  final Function(String)? backScreen;

  const ChatListScreen({super.key, this.backScreen});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: AppStrings.messagesStr,
        backClick: () {
          widget.backScreen?.call(AppStrings.homeStr);
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.chatDetails, arguments: {"modelData": DataProvider.chatList[index]});
              },
              child: Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: CircularImage(
                            imageWidget: Image.network(
                          DataProvider.chatList[index].image,
                          fit: BoxFit.cover,
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DataProvider.chatList[index].personName,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                              ),
                              if (DataProvider.chatList[index].lastMessage?.isNotEmpty ?? false) ...[
                                Text(
                                  DataProvider.chatList[index].lastMessage!,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DataProvider.chatList[index].time ?? "3 hr",
                                style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: Checkbox.width,
                                width: Checkbox.width,
                                decoration: BoxDecoration(color: AppColors.kDarkBlue, borderRadius: BorderRadius.circular(Checkbox.width / 2)),
                                child: Center(
                                  child: Text(
                                    DataProvider.chatList[index].pendingMessageCount?.toString() ?? "12",
                                    style: AppFonts.kPoppinsMedium.copyWith(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: DataProvider.chatList.length,
      ),
    );
  }
}
