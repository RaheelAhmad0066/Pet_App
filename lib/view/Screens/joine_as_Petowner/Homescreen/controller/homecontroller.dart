import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Homecontroller extends GetxController {
  var currentIndex = 0.obs;
  RxString name = ''.obs;
  RxString userName = ''.obs;
  RxString imagepath = ''.obs;
  RxInt count = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getUserProfile();
    getPetProfile();
    super.onInit();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
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

  Future<void> getPetProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('usersAddProfile')
          .where('userId', isEqualTo: userId)
          .limit(1) // Limit to get only one document
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        name.value = data['Name'] ?? '';
        imagepath.value = data['image_url'] ?? '';
        count.value = data.length;
        // Now you have the name and imagepath variables populated
        print('Name: $name');
        print('Image Path: $imagepath');
      } else {
        print('No pet profile found for the user.');
      }
    } else {
      print('User not logged in.');
    }
  }

 Future<void> getUserProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('pet_owners')
          .where('userId', isEqualTo: userId)
          
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        userName.value = data['fullName'] ?? '';

      } else {
        print('No pet profile found for the user.');
      }
    } else {
      print('User not logged in.');
    }
  }
}
