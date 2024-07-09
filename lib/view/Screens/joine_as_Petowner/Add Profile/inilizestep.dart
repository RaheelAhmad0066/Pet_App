import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:intl/intl.dart';

import 'controller/controller.dart';

class InitializeStep extends StatelessWidget {
  const InitializeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PetProfileController>();

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer circle
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 117, 115, 115)
                          .withOpacity(0.2),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 117, 115, 115)
                          .withOpacity(0.2),
                    ),
                  ),
                ),
                // Inner circle with the image
                Obx(() {
                  return controller.selectedImagePath.value == ''
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/images/dog.png'))
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(
                            File(controller.selectedImagePath.value),
                          ),
                        );
                }),
              ],
            ),
          ),
          AppSizedBoxes.largeSizedBox,
          Text(
            'Time to celebrate',
            style: AppTextStyles.small,
          ),
          AppSizedBoxes.largeSizedBox,
          Container(
            height: Get.height * 0.09,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgcolor1),
            child: Row(
              children: [
                AppSizedBoxes.normalWidthSizedBox,
                Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), color: grey1),
                  child: Image.asset('assets/images/Vector (2).png'),
                ),
                AppSizedBoxes.normalWidthSizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Birthday',
                      style: AppTextStyles.medium,
                    ),
                    Obx(() => Text(
                          "${DateFormat('d MMMM yyyy').format(controller.selectedBirthDate.value)}",
                          style: AppTextStyles.small,
                        )),
                  ],
                )
              ],
            ),
          ),
          AppSizedBoxes.normalSizedBox,
        
        ],
      ),
    );
  }
}
