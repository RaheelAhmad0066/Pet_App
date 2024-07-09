import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';

import 'controller/controller.dart';

class PetSize extends StatelessWidget {
  const PetSize({super.key});

  @override
  Widget build(BuildContext context) {
    final PetProfileController controller = Get.find<PetProfileController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            backgroundImage:
                                AssetImage('assets/images/dog.png'))
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
              'What’s your pet’s Size?',
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
            Obx(() => CarouselSlider.builder(
                  itemCount: controller.petSize.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    bool isSelected = controller.selectedIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        controller.setSelectedIndex(index);
                      },
                      child: Container(
                        width: 130,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          color: bgcolor1,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected ? Colors.blue : grey1,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: isSelected ? Colors.blue : grey1,
                              child: Image.asset(
                                controller.petSize[index]['icon']!,
                                height: 50,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              controller.petSize[index]['label']!,
                              style: TextStyle(
                                color: isSelected ? blue : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              controller.petSize[index]['range']!,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 150,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.3,
                    initialPage: controller.selectedIndex.value,
                    enableInfiniteScroll: false,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
