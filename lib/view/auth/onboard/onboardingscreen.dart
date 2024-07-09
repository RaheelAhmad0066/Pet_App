import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/view/auth/registerscreen/registerscreen.dart';

import '../../../widgets/custom_button.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cat.jpg'),
                fit: BoxFit.fitWidth)),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                        topStart: Radius.circular(20)),
                    color: bgcolor // Adjust opacity as needed
                    ),
                child: Column(
                  children: [
                    AppSizedBoxes.largeSizedBox,
                    AppSizedBoxes.normalSizedBox,
                    Image.asset('assets/images/progress.png'),
                    AppSizedBoxes.normalSizedBox,
                    Text('HealMyPet Companion', style: AppTextStyles.heading1),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          'Healing for each of your beloved pets. Share their name, breed, and age while connecting with a vibrant community. ',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.medium),
                    ),
                    AppSizedBoxes.largeSizedBox,
                    CustomButton(
                      ontap: () {
                        Get.to(() => Registerscreen(isVet: false));
                      },
                      title: 'Join as a Pet Owner',
                    ),
                    AppSizedBoxes.normalSizedBox,
                    CustomButton(
                      ontap: () {
                        Get.to(() => Registerscreen(isVet: true));
                      },
                      title: 'Join as a Vet',
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 370,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: bgcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
