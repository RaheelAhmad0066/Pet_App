import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Add%20Profile/addprofile_screen.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Homescreen/home_screen.dart';
import 'package:healmypet/view/Screens/joine_as_vet/homescreen/homescreen.dart';
import 'dart:io';
import '../../../appassets/errorhandling/errorhandling_firebaseauth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<String> genders = ['Male', 'Female', 'Other'].obs;
  RxString selectedGender = 'Male'.obs;

  var email = ''.obs;
  var password = ''.obs;
  var documentPath = ''.obs;

  var clinicName = ''.obs;
  var userName = ''.obs;
  var fullName = ''.obs;

  var phone = ''.obs;

  var documentName = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  Future<void> pickDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String fileName = result.files.single.name;
      String filePath = result.files.single.path!;
      documentName.value = fileName;

      FirebaseStorage storage = FirebaseStorage.instance;
      TaskSnapshot taskSnapshot =
          await storage.ref('vet_documents/$fileName').putFile(File(filePath));
      documentPath.value = await taskSnapshot.ref.getDownloadURL();
      Get.snackbar('Success', 'uploaded successfully', colorText: whitecolor);

      // Show a toast message
    }
  }

  Future<void> register(bool isVet) async {
    isLoading1.value = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      if (isVet) {
        await _firestore.collection('vets').doc(userCredential.user!.uid).set({
          'email': email.value,
          'username': userName.value,
          'fullName': fullName.value,
          'clinicName': clinicName.value,
          'phone': phone.value,
          'role': 'vets',
          'gender': selectedGender.value,
          'isApproved':false,
          'document': documentPath.value,
        });
        Get.snackbar('Success', 'Registration successful',
            colorText: whitecolor);
        Get.offAll(VetHomeScreen());
      } else {
        await _firestore
            .collection('pet_owners')
            .doc(userCredential.user!.uid)
            .set({
          'email': email.value,
          'role': 'pet_owners',
          'userId':_auth.currentUser!.uid,
          'userName': userName.value,
          'fullName': fullName.value,
          'phone': phone.value,
          'gender': selectedGender.value,
        });
        Get.snackbar('Success', 'Registration successful',
            colorText: whitecolor);
        Get.offAll(AddprofileScreen());
      }
    } catch (e) {
      FirebaseErrorHandler.getErrorMessage(e);
      Get.snackbar('Error', '$e', colorText: whitecolor);
    } finally {
      isLoading1.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      DocumentSnapshot vetDoc = await _firestore
          .collection('vets')
          .doc(userCredential.user!.uid)
          .get();

      if (vetDoc.exists == 'vets') {
        Get.offAll(VetHomeScreen());
        Get.snackbar('Message', 'Successful Login', colorText: whitecolor);
      } else {
        Get.offAll(HomeScreen());
        Get.snackbar('Message', 'Successful Login', colorText: whitecolor);
      }
    } catch (e) {
      Get.snackbar('Error', '$e', colorText: whitecolor);
    } finally {
      isLoading.value = false;
    }
  }
}
