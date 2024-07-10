import 'dart:io';

import 'package:clear_home/constants/data_provider.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/models/chat_model.dart';
import 'package:clear_home/utils/date_time_util.dart';
import 'package:clear_home/utils/firebase_provider.dart';
import 'package:clear_home/utils/image_picker_util.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../models/message_model.dart';
import '../../widgets/home_widgets/circular_image.dart';

class ChatDetailsScreen extends StatefulWidget {
  final ChatModel chatModel;

  const ChatDetailsScreen({super.key, required this.chatModel});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  Map<String, dynamic>? args;
  List<MessageModel> messageList = [];
  TextEditingController messageController = TextEditingController();
  ScrollController controller = ScrollController();
  String? userStatus;

  Future<Size> getImageWidthHeight(String imgPath) async {
    File image = File(imgPath);
    final decodeImage = await decodeImageFromList(image.readAsBytesSync());
    return Size(decodeImage.width as double, decodeImage.height as double);
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler(
      (message) {
        if (message.toString().contains("pause")) FirebaseProvider.getMessagingToken(false);
        if (message.toString().contains("resume")) FirebaseProvider.getMessagingToken(true);

        return Future.value(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.10,
              child: Card(
                margin: EdgeInsets.zero,
                shape:
                    const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.keyboard_backspace_rounded,
                        color: AppColors.kDarkBlue,
                        size: 25,
                      ),
                    ),
                    CircularImage(
                      imageWidget: (widget.chatModel.image.isNotEmpty ?? false) // if(args != null && args["image"] != null)
                          ? Image.network(
                              widget.chatModel.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppStrings.imgProfile,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.chatModel.personName,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18, color: Colors.black),
                        ),
                        StreamBuilder(
                            stream: FirebaseProvider.getUserInfo(widget.chatModel),
                            builder: (context, snapshot) {
                              final data = snapshot.data?.docs;
                              if (data != null && data.isNotEmpty && data.first.exists) {
                                final chatUser = ChatModel.fromMap(data.first.data());
                                userStatus = (chatUser.isOnline ?? false)
                                    ? "Online"
                                    : DateTimeUtil.getFormatedTime(context: context, time: chatUser.lastActiveTime ?? "");
                              }

                              return Text(
                                userStatus ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.green),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseProvider.getAllMessages(widget.chatModel),
                builder: (context, snapshot) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      if (controller.hasClients) {
                        final position = controller.position.maxScrollExtent;
                        // controller.animateTo(position, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        controller.jumpTo(position);
                      }
                    },
                  );
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator(color: AppColors.kDarkBlue));
                    case ConnectionState.active:
                    case ConnectionState.done:
                      messageList = snapshot.data?.docs.map((e) => MessageModel.fromMap(e.data())).toList() ?? [];
                      return Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemBuilder: (context, index) {
                            bool isSender = FirebaseProvider.user.uid == messageList[index].fromId;
                            if (!isSender && messageList[index].read!.isEmpty) {
                              FirebaseProvider.updateMessageStatus(messageList[index]);
                            }
                            // if (messageList[index].messageType == "image") {
                            //   getImageWidthHeight(messageList[index].msg ?? "").then((value) {
                            //     if(value.height < 250){
                            //      boxFit = BoxFit.fitWidth;
                            //     }
                            //   });
                            // }

                            return Container(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                                child: Align(
                                  alignment: (isSender) ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    textDirection: (isSender) ? TextDirection.rtl : TextDirection.ltr,
                                    children: [
                                      CircularImage(
                                        imageWidget: (widget.chatModel.image.isNotEmpty)
                                            ? Image.network(
                                                isSender ? FirebaseProvider.user.photoURL.toString() : widget.chatModel.image.toString(),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                AppStrings.imgProfile,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(maxWidth: size.width * 0.60),
                                        child: Column(
                                          crossAxisAlignment: (isSender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all((messageList[index].messageType == "image") ? 0 : 16),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10), color: (isSender) ? AppColors.kLiteBlue : Colors.white),
                                              child: (messageList[index].messageType == "image")
                                                  ? Image.network(
                                                      messageList[index].msg ?? "",
                                                      width: 250,
                                                      height: 400,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Text(
                                                      messageList[index].msg ?? "",
                                                      style: AppFonts.kPoppinsRegular
                                                          .copyWith(fontSize: 12, color: (isSender) ? Colors.white : Colors.black),
                                                    ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              mainAxisAlignment: (isSender) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8, left: 4),
                                                  child: Text(
                                                    DateTimeUtil.getFormatedTime(context: context, time: messageList[index].sent ?? ""),
                                                    style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: AppColors.kGray),
                                                  ),
                                                ),
                                                if (isSender && messageList[index].read!.isNotEmpty) ...[
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: SvgPicture.asset(
                                                      AppStrings.svgChatCheck,
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                          itemCount: messageList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ),
                      );
                  }
                }),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      focusBorderSide: const BorderSide(color: Colors.transparent),
                      maxLines: 3,
                      minLines: 1,
                      bgColor: Colors.white,
                      controller: messageController,
                      hintText: AppStrings.typeMessageStr,
                      suffixIcon: InkWell(
                        overlayColor: WidgetStateColor.transparent,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.mediaAttachmentStr,
                                      style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      InkWell(
                                        overlayColor: WidgetStateColor.transparent,
                                        onTap: () async {
                                          File imageFile = File(await ImagePickerUtil.pickImage());
                                          await FirebaseProvider.sendChatImage(widget.chatModel, imageFile);
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              AppStrings.imgGallery,
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              AppStrings.galleryStr,
                                              style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        overlayColor: WidgetStateColor.transparent,
                                        onTap: () {},
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              AppStrings.imgCamera,
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              AppStrings.cameraStr,
                                              style: AppFonts.kPoppinsSemiBold.copyWith(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            width: 20,
                            height: 20,
                            AppStrings.svgAttachment,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          width: 20,
                          height: 20,
                          AppStrings.svgEmoji,
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (messageController.text.trim().isNotEmpty) {
                        final position = controller.position.maxScrollExtent + 80;
                        controller.animateTo(position, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        controller.jumpTo(position);
                        await FirebaseProvider.sendMessage(widget.chatModel, messageController.text.trim(), "text");
                        messageController.clear();
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.kDarkBlue),
                      child: Center(
                        child: SvgPicture.asset(
                          AppStrings.svgSend,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
