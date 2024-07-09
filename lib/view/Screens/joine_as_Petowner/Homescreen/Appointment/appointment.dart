import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/widgets/custom_button.dart';
import 'package:healmypet/widgets/custom_textfield.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller/appointment_controller.dart';
import 'modal/appoint_modal.dart';

class Appointment extends StatelessWidget {
  final controller = Get.put(DateTimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Appointments',
          style: AppTextStyles.small.copyWith(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: bgcolor1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                      'assets/images/dog.png',
                    ),
                  ),
                  Text(
                    'Maxi',
                    style: AppTextStyles.small,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.8,
                ),
                items: controller.petWeights
                    .map((item) => Card(
                          color: blue,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                left: 10,
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['label']!,
                                          style: AppTextStyles.medium.copyWith(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        AppSizedBoxes.smallSizedBox,
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.location,
                                              color: whitecolor,
                                            ),
                                            Text(
                                              '70 Street,\n ${item['location']}',
                                              style: AppTextStyles.medium,
                                            ),
                                          ],
                                        ),
                                        AppSizedBoxes.smallWidthSizedBox,
                                        Row(
                                          children: [
                                            Text(
                                              '4,6',
                                              style: AppTextStyles.heading1,
                                            ),
                                            AppSizedBoxes.normalWidthSizedBox,
                                            Row(
                                                children: List.generate(
                                                    4,
                                                    (generator) => Icon(
                                                          Iconsax.star,
                                                          color: Colors.amber,
                                                          size: 16,
                                                        ))),
                                            AppSizedBoxes.largeWidthSizedBox,
                                            AppSizedBoxes.largeWidthSizedBox,
                                            Text(
                                              '230 reviews',
                                              style: AppTextStyles.small,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 200,
                                bottom: 60,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 210, 206, 206)
                                          .withOpacity(0.3),
                                  radius: 59,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 210, 206, 206)
                                            .withOpacity(0.4),
                                    radius: 54,
                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                              255, 210, 206, 206)
                                          .withOpacity(0.4),
                                      radius: 47,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage(item['icon']!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              AppSizedBoxes.normalSizedBox,
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.formattedSelectedDay,
                      style: AppTextStyles.heading1,
                    ),
                    AppSizedBoxes.normalSizedBox,
                    SizedBox(
                      height: Get.height * 0.1,
                      child: ListView.builder(
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.currentWeekDays.length,
                        itemBuilder: (context, index) {
                          final day = controller.currentWeekDays[index];
                          final isSelected =
                              isSameDay(day, controller.selectedDay.value);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => controller.selectDay(day),
                              child: Container(
                                width: Get.width * 0.11,
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? grey1 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: isSelected ? Colors.blue : grey1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('d').format(day),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('EEE').format(day),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
              AppSizedBoxes.normalSizedBox,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Availability',
                  style: AppTextStyles.heading1,
                ),
              ),
              AppSizedBoxes.normalSizedBox,
              GridView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 2, mainAxisExtent: 60),
                itemCount: controller.timeSlots.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.selectTimeSlot(controller.timeSlots[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: controller.selectedTimeSlot.value ==
                                    controller.timeSlots[index]
                                ? Colors.amber
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: controller.selectedTimeSlot.value ==
                                        controller.timeSlots[index]
                                    ? Colors.amber
                                    : grey1)),
                        alignment: Alignment.center,
                        child: Text(
                          controller.timeSlots[index],
                          style: TextStyle(color: whitecolor),
                        ),
                      ),
                    );
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Services',
                  style: AppTextStyles.heading1,
                ),
              ),
              SizedBox(height: 16.0),
              Obx(() {
                return Column(
                  children: [
                    for (var service in [
                      'Vaccination',
                      'Deworming',
                      'Grooming',
                      'Surgery'
                    ])
                      GestureDetector(
                        onTap: () => controller.toggleService(service),
                        child: Container(
                          height: 65,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: bgcolor1,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: controller.isSelected(service),
                                onChanged: (bool? value) {
                                  controller.toggleService(service);
                                },
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                              ),
                              Text(
                                service,
                                style: TextStyle(
                                  color: controller.isSelected(service)
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              }),
              AppSizedBoxes.smallSizedBox,
              Divider(
                color: grey1.withOpacity(0.6),
              ),
              AppSizedBoxes.normalSizedBox,
              Text(
                '*The payment will b add the location',
                style: AppTextStyles.medium.copyWith(color: grey),
              ),
              AppSizedBoxes.largeSizedBox,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Add Note',
                  style: AppTextStyles.heading1,
                ),
              ),
              AppSizedBoxes.normalSizedBox,
              CustomTextField(
                hintText: 'Suggested',
                obscureText: false,
                minlines: 3,
                maxlines: 6,
                onchange: (value) => controller.addNotes.value = value!,
              ),
              AppSizedBoxes.normalSizedBox,
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator(
                        color: blue,
                      )
                    : CustomButton(
                        ontap: () {
                          Booking booking = Booking(
                            date: controller.formattedSelectedDay,
                            time: controller.selectedTimeSlot.value,
                            services: controller.selectedServices,
                            text: controller.addNotes.value,
                          );
                          controller.addBooking(booking);
                        },
                        title: 'Confirm Booking'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
