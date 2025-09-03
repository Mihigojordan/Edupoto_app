import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/custom_text_field_widget.dart';

class SignUpInputWidget extends StatefulWidget {
  final TextEditingController? occupationController, fNameController,lNameController,emailController;
   const SignUpInputWidget({
     super.key,
     this.occupationController,
     this.fNameController,
     this.lNameController,
     this.emailController,
   });

  @override
  State<SignUpInputWidget> createState() => _SignUpInputWidgetState();
}

class _SignUpInputWidgetState extends State<SignUpInputWidget> {
  final FocusNode occupationFocus = FocusNode();
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller){
      return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
          vertical: Dimensions.paddingSizeLarge),
      child: Column(
        children: [
          // CustomTextFieldWidget(
          //   fillColor: Theme.of(context).cardColor,
          //   hintText: 'occupation'.tr,
          //   isShowBorder: true,
          //   controller: widget.occupationController,
          //   focusNode: occupationFocus,
          //   nextFocus: firstNameFocus,
          //   inputType: TextInputType.name,
          //   capitalization: TextCapitalization.words,
          // ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),

          CustomTextFieldWidget(
            fillColor: Theme.of(context).cardColor,
            hintText: 'first_name'.tr,
            isShowBorder: true,
            controller: widget.fNameController,
            focusNode: firstNameFocus,
            nextFocus: lastNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),

          CustomTextFieldWidget(
            fillColor: Theme.of(context).cardColor,
            hintText: 'last_name'.tr,
            isShowBorder: true,
            controller: widget.lNameController,
            focusNode: lastNameFocus,
            nextFocus: emailNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraExtraLarge,
          ),

        // Column(
        //     children: [

              // Row(
              //   children: [
              //     Text('email_address'.tr, style: rubikMedium.copyWith(
              //         color: Theme.of(context).textTheme.bodyLarge!.color,
              //         fontSize: Dimensions.fontSizeDefault,
              //       ),
              //     ),

              //     Text('(${'optional'.tr})', style: rubikRegular.copyWith(
              //         color: Theme.of(context).textTheme.titleLarge!.color,
              //         fontSize: Dimensions.fontSizeDefault,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: Dimensions.paddingSizeExtraExtraLarge,
              // ),

              // CustomTextFieldWidget(
              //   fillColor: Theme.of(context).cardColor,
              //   hintText: 'type_email_address'.tr,
              //   isShowBorder: true,
              //   controller: widget.emailController,
              //   focusNode: emailNameFocus,
              //   inputType: TextInputType.emailAddress,
              // ),
          //   ],
          // ) ,

    // Column(
    //         children: [

    //           Row(
    //             children: [
    //               Text('Student Name'.tr, style: rubikMedium.copyWith(
    //                   color: Theme.of(context).textTheme.bodyLarge!.color,
    //                   fontSize: Dimensions.fontSizeDefault,
    //                 ),
    //               ),

    //               Text('(${'optional'.tr})', style: rubikRegular.copyWith(
    //                   color: Theme.of(context).textTheme.titleLarge!.color,
    //                   fontSize: Dimensions.fontSizeDefault,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: Dimensions.paddingSizeExtraExtraLarge,
    //           ),

              // CustomTextFieldWidget(
              //   fillColor: Theme.of(context).cardColor,
              //   hintText: 'Type Student Name'.tr,
              //   isShowBorder: true,
              //   controller: widget.emailController,
              //   focusNode: emailNameFocus,
              //   inputType: TextInputType.emailAddress,
              // ),
          //   ],
          // ) ,
            //   Column(
            // children: [

              // Row(
              //   children: [
              //     Text('Student Number'.tr, style: rubikMedium.copyWith(
              //         color: Theme.of(context).textTheme.bodyLarge!.color,
              //         fontSize: Dimensions.fontSizeDefault,
              //       ),
              //     ),

              //     Text('(${'optional'.tr})', style: rubikRegular.copyWith(
              //         color: Theme.of(context).textTheme.titleLarge!.color,
              //         fontSize: Dimensions.fontSizeDefault,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: Dimensions.paddingSizeExtraExtraLarge,
              // ),

              // CustomTextFieldWidget(
              //   fillColor: Theme.of(context).cardColor,
              //   hintText: 'Type Student Number'.tr,
              //   isShowBorder: true,
              //   controller: widget.emailController,
              //   focusNode: emailNameFocus,
              //   inputType: TextInputType.emailAddress,
              // ),
          //   ],
          // ) ,
          sizedBox10,
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      // BorderButton1(
      //                             borderColor: Colors.black,
      //                             vertical:5,
      //                             textColor: Colors.black,
      //                             horizontal: 5,
      //                             onPress: (){},
      //                             height: 50,
      //                             width: 148,
      //                             icon: 'Add Student',
      //                             title:'assets/icons/add_account.png',
      //                             clas: ''),
      //       ],
      //     ),
          //    Column(
          //   children: [

          //     Row(
          //       children: [
          //         Text('Register for Macyemacye'.tr, style: rubikMedium.copyWith(
          //             color: Theme.of(context).textTheme.bodyLarge!.color,
          //             fontSize: Dimensions.fontSizeDefault,
          //           ),
          //         ),

          //         Text('(${'optional'.tr})', style: rubikRegular.copyWith(
          //             color: Theme.of(context).textTheme.titleLarge!.color,
          //             fontSize: Dimensions.fontSizeDefault,
          //           ),
          //         ),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: Dimensions.paddingSizeExtraExtraLarge,
          //     ),

          //     CustomTextFieldWidget(
          //       fillColor: Theme.of(context).cardColor,
          //       hintText: 'Type Your Name'.tr,
          //       isShowBorder: true,
          //       controller: widget.emailController,
          //       focusNode: emailNameFocus,
          //       inputType: TextInputType.emailAddress,
          //     ),
          //   ],
          // ) ,
          // DropDown1(onChanged: (change){}, itemLists: const ['Daily','Weekly','Monthly'], title: 'Choose How Would you like to pay', isExpanded: true)
        ],
      ),
    );
    });
  }
}
