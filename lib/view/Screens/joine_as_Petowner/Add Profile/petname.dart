import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';

import '../../../../widgets/custom_textfield.dart';
import 'controller/controller.dart';

class PteName extends StatelessWidget {
  const PteName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PetProfileController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Center(
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
                              backgroundImage:
                                  AssetImage('assets/images/dog.png'))
                          : CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(
                                File(controller.selectedImagePath.value),
                              ),
                            );
                    }),

                    // Small icon overlay
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.image,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSizedBoxes.largeSizedBox,
            Text(
              'What’s your pet’s name?',
              style: AppTextStyles.small,
            ),
            AppSizedBoxes.largeSizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomTextField(
                hintText: 'your pet’s name',
                onchange: (value) => controller.petname.value = value!,
                obscureText: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
