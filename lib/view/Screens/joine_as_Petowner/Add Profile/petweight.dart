import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';

import 'controller/controller.dart';

class Petweight extends StatelessWidget {
  const Petweight({super.key});

  @override
  Widget build(BuildContext context) {
    final PetProfileController controller = Get.find<PetProfileController>();

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
            'What’s your pet’s weight?',
            style: AppTextStyles.small,
          ),
          AppSizedBoxes.normalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Automatic selection based on your pets breed.Adjust according to reality',
              style: AppTextStyles.small,
              textAlign: TextAlign.center,
            ),
          ),
          AppSizedBoxes.largeSizedBox,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(
                  () => Text(
                    controller.currentWeight.value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent
                      ],
                      stops: [
                        0.0,
                        0.3,
                        0.7,
                        1.0
                      ], // Adjust stops for more gradual transparency
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          200, // Arbitrary large number for demonstration
                      itemBuilder: (context, index) {
                        double weightValue = index * 0.1;
                        return GestureDetector(
                          onTap: () {
                            controller.setWeight(weightValue);
                          },
                          child: Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Obx(
                              () => Text(
                                weightValue.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 22,
                                  color: weightValue ==
                                          controller.currentWeight.value
                                      ? Colors.blue
                                      : grey1,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: bgcolor1,
                          border: Border.all(
                              color: Color.fromARGB(255, 117, 115, 115))),
                      child: Row(
                        children: [
                          Obx(
                            () => Radio<String>(
                              value: 'kg',
                              fillColor: MaterialStateProperty.all(blue),
                              groupValue: controller.currentUnit.value,
                              onChanged: (String? value) {
                                controller.setUnit(value!);
                              },
                            ),
                          ),
                          Text(
                            'kg',
                            style: AppTextStyles.medium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: bgcolor1,
                          border: Border.all(
                              color: Color.fromARGB(255, 117, 115, 115))),
                      child: Row(
                        children: [
                          Obx(
                            () => Radio<String>(
                              value: 'lb',
                              fillColor: MaterialStateProperty.all(blue),
                              groupValue: controller.currentUnit.value,
                              onChanged: (String? value) {
                                controller.setUnit(value!);
                              },
                            ),
                          ),
                          Text(
                            'lb',
                            style: AppTextStyles.medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
