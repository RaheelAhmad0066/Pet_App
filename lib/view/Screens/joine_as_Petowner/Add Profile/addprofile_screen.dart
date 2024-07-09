import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Add%20Profile/controller/controller.dart';

import '../../../../widgets/custom_button.dart';
import '../importantdate.dart';
import 'inilizestep.dart';
import 'petbread.dart';
import 'petname.dart';
import 'petsize.dart';
import 'petweight.dart';

class AddprofileScreen extends StatelessWidget {
  final controller = Get.find<PetProfileController>();

  final List<Widget> pages = [
    PetBread(),
    const PteName(),
    const PetSize(),
    const Petweight(),
    DatePickerPet(),
    const InitializeStep(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppSizedBoxes.largeSizedBox,
          Obx(() => StepProgressIndicator(
                currentStep: controller.currentStep.value,
                totalSteps: controller.totalSteps,
              )),
          Expanded(
            child: Obx(() => pages[controller.currentStep.value]),
          ),
          Obx(
            () => controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: blue,
                  )
                : CustomButton(
                    ontap: () {
                      switch (controller.currentStep.value) {
                        case 0:
                          if (controller.selectedBreed.value.isEmpty) {
                            Get.snackbar('Error', 'Please select a breed',
                                colorText: whitecolor);
                            return;
                          }
                          break;

                        case 1:
                          if (controller.selectedImagePath.value.isEmpty ||
                              controller.petname.value == '') {
                            Get.snackbar(
                                'Error', 'Please select an image and petname ',
                                colorText: whitecolor);
                            return;
                          }
                          break;

                        case 2:
                          if (controller.selectedSize.value == '') {
                            Get.snackbar('Error', 'Please selects a size',
                                colorText: whitecolor);
                            return;
                          }
                          break;

                        case 3:
                          if (controller.currentWeight.value.isLowerThan(0.3) ||
                              controller.currentUnit.value == '') {
                            Get.snackbar(
                                'Error', 'Please select weight and unit',
                                colorText: whitecolor);
                            return;
                          }
                          break;
                      }

                      if (controller.currentStep.value ==
                          controller.totalSteps - 1) {
                        controller.uploadAddUser(
                            File(controller.selectedImagePath.value));
                      } else {
                        controller.nextStep();
                      }
                    },
                    title: controller.currentStep.value ==
                            controller.totalSteps - 1
                        ? 'Get Started'
                        : 'Next'),
          ),
          AppSizedBoxes.normalSizedBox,
        ],
      ),
    );
  }
}

class StepPage extends StatelessWidget {
  final Widget content;

  const StepPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: content);
  }
}

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PetProfileController controller = Get.put(PetProfileController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whitecolor,
                ),
                onPressed: () {
                  controller.previousStep();
                },
              ),
              Column(
                children: [
                  Text(
                    'Add Pet Profile',
                    style: AppTextStyles.heading1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(getStepTitle(currentStep),
                        style: AppTextStyles.small),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Step',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Step ${currentStep + 1}/$totalSteps',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: (currentStep + 1) / totalSteps,
            backgroundColor: Colors.grey,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  String getStepTitle(int step) {
    // Customize this method to return the title based on the step
    switch (step) {
      case 0:
        return 'Breed';
      case 1:
        return 'Name';
      case 2:
        return 'Size';
      case 3:
        return 'Weight';
      case 4:
        return 'Important date';
      case 5:
        return 'Important date';
      // Add more cases as per your steps
      default:
        return 'Important date';
    }
  }
}
