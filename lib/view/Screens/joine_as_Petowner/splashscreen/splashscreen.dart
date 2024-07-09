import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/splashscreen/controller/controller.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controlrer = Get.put(SplashController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ),
          AppSizedBoxes.largeSizedBox,
          Text(
            'HealMyPet Companion',
            style: AppTextStyles.heading1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Healing for each of your beloved pets. Share their name, breed, and age while connecting with a vibrant community.and age while connecting with a vibrant community. ',
              style: AppTextStyles.small,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
