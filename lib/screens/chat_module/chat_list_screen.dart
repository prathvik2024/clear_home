import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/constants/fonts.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/models/message_model.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/screens/chat_module/chat_details_screen.dart';
import 'package:clear_home/utils/date_time_util.dart';
import 'package:clear_home/utils/firebase_provider.dart';
import 'package:clear_home/widgets/custom_appbar.dart';
import 'package:clear_home/widgets/home_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/chat_model.dart';

class ChatListScreen extends StatefulWidget {
  final Function(String)? backScreen;

  const ChatListScreen({super.key, this.backScreen});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel> chatList = [];
  MessageModel? _messageModel;
  int? unreadMessageCount;

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
      body: StreamBuilder(
        stream: FirebaseProvider.getChatAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator(color: AppColors.kDarkBlue));
            case ConnectionState.active:
            case ConnectionState.done:
              chatList = snapshot.data?.docs.map((e) => ChatModel.fromMap(e.data())).toList() ?? [];
              if (chatList.isEmpty) {
                return const Center(child: Text("No Chats Found!"));
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(chatModel: chatList[index])));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: StreamBuilder(
                                stream: FirebaseProvider.getLastMessages(chatList[index]),
                                builder: (context, snapshot) {
                                  final data = snapshot.data?.docs;
                                  if (data != null && data.isNotEmpty && data.first.exists) {
                                    _messageModel = MessageModel.fromMap(data.first.data());
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: CircularImage(
                                            imageWidget: Image.network(
                                          chatList[index].image,
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
                                                chatList[index].personName,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFonts.kPoppinsMedium.copyWith(fontSize: 16, color: Colors.black),
                                              ),
                                              if (_messageModel != null) ...[
                                                Text(
                                                  _messageModel?.msg ?? "",
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
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              if (_messageModel != null) ...[
                                                Text(
                                                  DateTimeUtil.getFormatedTime(context: context, time: _messageModel?.sent ?? ""),
                                                  style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                StreamBuilder(
                                                    stream: FirebaseProvider.getUnreadMessageCount(chatList[index]),
                                                    builder: (context, snapshot) {
                                                      final data = snapshot.data?.docs;
                                                      if (data != null) {
                                                        unreadMessageCount = data.length;
                                                      }
                                                      return (unreadMessageCount != null && unreadMessageCount != 0)
                                                          ? Container(
                                                              height: Checkbox.width,
                                                              width: Checkbox.width,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.kDarkBlue,
                                                                  borderRadius: BorderRadius.circular(Checkbox.width / 2)),
                                                              child: Center(
                                                                child: Text(
                                                                  (unreadMessageCount == 0) ? "" : unreadMessageCount?.toString() ?? "",
                                                                  style: AppFonts.kPoppinsMedium.copyWith(fontSize: 10, color: Colors.white),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox();
                                                    })
                                              ],
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: chatList.length,
                );
              }
          }
        },
      ),
    );
  }
}
