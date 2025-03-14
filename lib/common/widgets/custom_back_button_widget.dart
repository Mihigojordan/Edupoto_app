



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';
import 'package:hosomobile/util/dimensions.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

 
 @override
  Widget build(BuildContext context){
  return  CustomInkWellWidget(
                  onTap:  () {
                    Get.back();
                  } ,
                  radius: Dimensions.radiusSizeSmall,
                  child: Container(
                    height: 40,width: 40,
                    // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.7), width: 0.5),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios_new, size: Dimensions.paddingSizeSmall, color: Colors.black,
                      ),
                    ),
                  ),
                );
 }


 }