import 'package:clear_home/constants/data_provider.dart';
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
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timestamp) {
      if (controller.hasClients) {
        final position = controller.position.maxScrollExtent + 50;
        controller.animateTo(position, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
      }
      args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (args?["modelData"] != null) {
        chatModel = args?["modelData"];
      }
      setState(() {});
    });
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
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chatModel?.personName ?? AppStrings.demoNameStr,
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                      child: Align(
                        alignment: (DataProvider.messageModel[index].isSender) ? Alignment.centerRight : Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: (DataProvider.messageModel[index].isSender) ? TextDirection.rtl : TextDirection.ltr,
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
                            const SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: size.width * 0.60),
                              child: Column(
                                crossAxisAlignment: (DataProvider.messageModel[index].isSender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (DataProvider.messageModel[index].isSender) ? AppColors.kLiteBlue : Colors.white),
                                    child: Text(
                                      DataProvider.messageModel[index].message,
                                      style: AppFonts.kPoppinsRegular
                                          .copyWith(fontSize: 12, color: (DataProvider.messageModel[index].isSender) ? Colors.white : Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: (DataProvider.messageModel[index].isSender) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8, left: 4),
                                        child: Text(
                                          "8:10 pm",
                                          style: AppFonts.kPoppinsRegular.copyWith(fontSize: 12, color: AppColors.kGray),
                                        ),
                                      ),
                                      if (DataProvider.messageModel[index].isSender) ...[
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
                itemCount: DataProvider.messageModel.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (messageController.text.trim().isNotEmpty) {
                        final position = controller.position.maxScrollExtent + 80;
                        controller.animateTo(position, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                        DataProvider.messageModel
                            .add(MessageModel(messageController.text, "8.11 pm", AppStrings.svgCheckboxTik, AppStrings.imgProfile, true));
                        messageController.clear();
                      }
                      setState(() {});
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
