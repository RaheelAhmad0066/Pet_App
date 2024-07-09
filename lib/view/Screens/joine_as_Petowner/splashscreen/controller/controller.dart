import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../auth/onboard/onboardingscreen.dart';
import '../../../joine_as_vet/homescreen/homescreen.dart';
import '../../Homescreen/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      checkLogin();
    });
  }

  void checkLogin() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If user is not logged in, navigate to onboarding screen
      Get.offAll(Onboardingscreen());
    } else {
      try {
        // If user is logged in, check their role
        DocumentSnapshot petOwnerDoc = await FirebaseFirestore.instance
            .collection('pet_owners')
            .doc(user.uid)
            .get();
        DocumentSnapshot vetDoc = await FirebaseFirestore.instance
            .collection('vets')
            .doc(user.uid)
            .get();


        if (petOwnerDoc.exists) {
          String role = petOwnerDoc['role'];
          if (role == 'pet_owners') {
            Get.offAll(HomeScreen());
          } else {
            Get.offAll(Onboardingscreen());
          }
        } else if (vetDoc.exists) {
          String role = vetDoc['role'];
          if (role == 'vets') {
            Get.offAll(VetHomeScreen());
          } else {
            Get.offAll(Onboardingscreen());
          }
        } else {
          // If user document doesn't exist in both collections, navigate to onboarding screen
          Get.offAll(Onboardingscreen());
        }
      } catch (e) {
        // Handle errors
        print("Error checking user role: $e");
        Get.offAll(Onboardingscreen());
      }
    }
  }
}
