import 'dart:developer';

import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/models/chat_model.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../models/message_model.dart';
import '../../widgets/home_widgets/circular_image.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  Map<String, dynamic>? args;
  ChatModel? chatModel;
  TextEditingController messageController = TextEditingController();

  List<MessageModel> messageModel = [
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("Hello", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel("Hii My name is prathvik", "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, false),
    MessageModel("what are you doing?", "8.10 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
    MessageModel(AppStrings.descriptionStr, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true),
  ];

  @override
  void initState() {
    super.initState();
    messageModel.addAll([...messageModel.reversed]);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timestamp) {
      args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (args?["modelData"] != null) {
        chatModel = args?["modelData"] ?? null;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.10,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.keyboard_backspace_rounded,
                        color: AppColors.kDarkBlue,
                        size: 25,
                      ),
                    ),
                    CircularImage(
                      imageWidget: (chatModel?.image.isNotEmpty ?? false) // if(args != null && args["image"] != null)
                          ? Image.network(
                              chatModel!.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppStrings.imgProfile,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.55,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chatModel?.personName ?? "David Smith",
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.kPoppinsMedium.copyWith(fontSize: 18, color: Colors.black),
                          ),
                          Text(
                            "Online",
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.kPoppinsRegular.copyWith(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                      child: Align(
                        alignment: (messageModel[index].isSender) ? Alignment.centerRight : Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: (messageModel[index].isSender) ? TextDirection.rtl : TextDirection.ltr,
                          children: [
                            CircularImage(
                              imageWidget: (chatModel?.image.isNotEmpty ?? false) // if(args != null && args["image"] != null)
                                  ? Image.network(
                                      chatModel!.image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AppStrings.imgProfile,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: width * 0.60),
                              child: Column(
                                crossAxisAlignment: (messageModel[index].isSender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (messageModel[index].isSender) ? AppColors.kLiteBlue : Colors.white),
                                    child: Text(
                                      messageModel[index].message,
                                      style: AppFonts.kPoppinsRegular
                                          .copyWith(fontSize: 12, color: (messageModel[index].isSender) ? Colors.white : Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: (messageModel[index].isSender) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8, left: 4),
                                        child: Text(
                                          "8:10 pm",
                                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: AppColors.kGray),
                                        ),
                                      ),
                                      if (messageModel[index].isSender) ...[
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
                itemCount: messageModel.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      focusBorderSide: BorderSide(color: Colors.transparent),
                      maxLines: 3,
                      minLines: 1,
                      bgColor: Colors.white,
                      controller: messageController,
                      hintText: AppStrings.typeMessageStr,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          width: 20,
                          height: 20,
                          AppStrings.svgAttachment,
                          color: Colors.black.withOpacity(0.15),
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
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.kDarkBlue),
                    child: Center(
                      child: SvgPicture.asset(
                        AppStrings.svgSend,
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
