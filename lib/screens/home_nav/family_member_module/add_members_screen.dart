import 'package:clear_home/constants/colors.dart';
import 'package:clear_home/constants/strings.dart';
import 'package:clear_home/constants/validator.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/widgets/custom_button.dart';
import 'package:clear_home/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_appbar.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  Map<String, dynamic>? args;

  TextEditingController memberNameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  void validateAddMembers() async {
    // if (_formKey.currentState!.validate()) {
    //   ShowToast(msg: "Add Member Successfully");

    args = await Navigator.pushNamed(context, AppRoutes.familyMemberList) as Map<String, dynamic>;
    setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHomeBg,
      appBar: CustomAppbar(
        screenName: (args?["isEdit"] ?? false) ? AppStrings.editMemberDetailsStr : AppStrings.addMembersStr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21, top: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: memberNameController,
                  textLabel: AppStrings.memberNameStr,
                  hintText: AppStrings.hintName,
                  validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isAlpha, errorMsg: AppStrings.nameError),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: relationController,
                  textLabel: AppStrings.relationStr,
                  hintText: AppStrings.hintRelation,
                  validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isAlpha, errorMsg: AppStrings.relationError),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  textLabel: AppStrings.mobileStr,
                  controller: mobileController,
                  hintText: AppStrings.hintPhone,
                  validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isPhone),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  textLabel: AppStrings.emailStr,
                  controller: emailController,
                  hintText: AppStrings.hintEmail,
                  validationCallback: (input) => Validator.validate(input: input, type: ValidationType.isEmail),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(label: (args?["isEdit"] ?? false) ? AppStrings.saveStr : AppStrings.addMemberBtnStr, onClick: validateAddMembers),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
