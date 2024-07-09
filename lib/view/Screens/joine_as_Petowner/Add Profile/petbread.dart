import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'controller/controller.dart';

class PetBread extends StatelessWidget {
  PetBread({super.key});
  final PetProfileController controller = Get.find<PetProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: controller.dogBreeds.length,
              itemBuilder: (context, index) {
                final breed = controller.dogBreeds[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () => controller.selectBreed(breed.name),
                    child: Obx(() {
                      final isSelected =
                          controller.selectedBreed.value == breed.name;
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2331),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Color.fromARGB(255, 117, 115, 115),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSizedBoxes.largeSizedBox,
                            Center(
                              child: Text(
                                breed.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AppSizedBoxes.largeSizedBox,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(breed.imagePath,
                                  height: 80, width: 80, fit: BoxFit.cover),
                            ),
                           
                          ],
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            AppSizedBoxes.normalSizedBox,
          ],
        ),
      ),
    );
  }
}
