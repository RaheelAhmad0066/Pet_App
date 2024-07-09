import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Homescreen/home_screen.dart';
import 'package:intl/intl.dart';

import '../modal/appoint_modal.dart';
import '../services/notifcation_services.dart';

class DateTimeController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var selectedTimeSlot = ''.obs;
  var addNotes = ''.obs;
  List<String> timeSlots = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '24:00',
  ];

  String get formattedSelectedDay =>
      DateFormat('EEEE, d MMMM').format(selectedDay.value);

  void selectDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  List<DateTime> get currentWeekDays {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(
        30, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  var selectedServices = <String>[].obs;

  void toggleService(String service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
  }

  var selectedWeight = ''.obs;
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedWeight.value = petWeights[index]['label']!;
  }

  var selectedIndex = 1.obs;
  bool isSelected(String service) {
    return selectedServices.contains(service);
  }

  final List<Map<String, String>> petWeights = [
    {
      'label': 'Pets Medical Center',
      'location': 'Rawalpindi,Pakistan',
      'icon': 'assets/images/cat1.png'
    },
    {
      'label': 'Pets Care Clinic',
      'location': 'Islamabad, Pakistan',
      'icon': 'assets/images/dog.png'
    },
    {
      'label': 'PetsPace Animal Hospital',
      'location': 'Lahore,Pakistan',
      'icon': 'assets/images/cat1.png'
    },
  ];

  final FirestoreService _firestoreService = Get.put(FirestoreService());
  final NotificationService _notificationService =
      Get.put(NotificationService());
  var isLoading = false.obs;

  Future<void> addBooking(Booking booking) async {
    isLoading.value = true;
    try {
      await _firestoreService.addBooking(booking);
      // await _notificationService.sendNotification(
      //     'Booking Confirmation', 'Your booking is uploaded');

      Get.snackbar('Success', 'Your booking is uploaded',
          colorText: whitecolor);
      Get.to(HomeScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload booking', colorText: whitecolor);
    } finally {
      isLoading.value = false;
    }
  }
}
