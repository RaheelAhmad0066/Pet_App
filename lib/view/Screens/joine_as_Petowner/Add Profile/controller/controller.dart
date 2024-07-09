import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../Homescreen/home_screen.dart';
import '../model/model.dart';
import 'package:image_picker/image_picker.dart';

class PetProfileController extends GetxController {
  var currentStep = 0.obs;
  final int totalSteps = 6;
  var selectedBreed = ''.obs;
  var petname = ''.obs;
  var selectedImagePath = ''.obs;
  var imageUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();
  var currentWeight = 22.2.obs;
  var selectedIndex = 1.obs;
  var selectedBirthDate = DateTime.now().obs;
  var selectedAppointmentDate = DateTime.now().obs;
  var currentUnit = 'kg'.obs;
  RxBool isLoading = false.obs;
  var selectedSize = ''.obs;

  final List<DogBreed> dogBreeds = [
    DogBreed('Akita', 'assets/images/Photo (1).png'),
    DogBreed('Beagle', 'assets/images/Photo (2).png'),
    DogBreed('Persian', 'assets/images/cat3.png'),
    DogBreed('Stray', 'assets/images/cat1.png'),
    DogBreed('British Shorthair', 'assets/images/cat2.png'),
    DogBreed('Boxer', 'assets/images/Photo (3).png'),
    DogBreed('Boxer', 'assets/images/Photo (1).png'),
    DogBreed('Boxer', 'assets/images/Photo (3).png'),
  ];

  final List<Map<String, String>> petSize = [
    {
      'label': 'under 14kg',
      'range': 'under 14kg',
      'icon': 'assets/images/Icon.png'
    },
    {'label': 'Medium', 'range': '14-25kg', 'icon': 'assets/images/Vector.png'},
    {
      'label': 'over 25kg',
      'range': 'over 25kg',
      'icon': 'assets/images/Vector (1).png'
    },
  ];

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedSize.value = petSize[index]['label']!;
  }

  void updateBirthDate(DateTime date) {
    selectedBirthDate.value = date;
  }

  void updateAppointmentDate(DateTime date) {
    selectedAppointmentDate.value = date;
  }

  void setWeight(double weight) {
    currentWeight.value = weight;
  }

  void setUnit(String unit) {
    currentUnit.value = unit;
  }

  void selectBreed(String breed) {
    selectedBreed.value = breed;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      //  uploadImageToFirebase(File(pickedFile.path));
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> uploadAddUser(File imageFile) async {
    isLoading.value = true;
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      saveDataToFirestore(downloadUrl);
      Get.snackbar('Success', 'Data saved successfully');
      Get.offAll(HomeScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveDataToFirestore(String imageUrl) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;

      if (userId != null) {
        await FirebaseFirestore.instance.collection('usersAddProfile').add({
          'userId': userId, // Save the user ID
          'Bread': selectedBreed.value,
          'Name': petname.value,
          'birthdate': selectedBirthDate.value,
          'adoptiondate': selectedAppointmentDate.value,
          'size': selectedSize.value,
          'weight': '${currentWeight.value}${currentUnit.value}',
          'image_url': imageUrl,
        });
      } else {
        Get.snackbar('Error', 'User not logged in');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Stream<List<Map<String, dynamic>>> getPetProfiles() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      return FirebaseFirestore.instance
          .collection('usersAddProfile')
          .where('userId', isEqualTo: userId) // Filter by user ID
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
    } else {
      return Stream.value(
          []); // Return an empty stream if the user is not logged in
    }
  }
}
