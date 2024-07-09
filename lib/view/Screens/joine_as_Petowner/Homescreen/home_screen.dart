import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/sizedbox_height.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/Homescreen/Appointment/appointment.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../../appassets/colors/colors.dart';
import 'controller/homecontroller.dart';
import 'menue_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      angle: 0,
      mainScreenScale: 0.2,
      slideHeight: 80,
      borderRadius: 40,
      menuScreen: MenuScreenPage(),
      mainScreen: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Homecontroller());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBoxes.largeSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          child: Icon(Iconsax.user),
                          backgroundImage:
                              NetworkImage(controller.imagepath.value),
                        ),
                      ),
                      AppSizedBoxes.smallWidthSizedBox,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello,', style: AppTextStyles.small),
                          Obx(() => Text(
                                controller.userName.value,
                                style: AppTextStyles.small,
                              ))
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => ZoomDrawer.of(context)!.toggle(),
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                ],
              ),
              AppSizedBoxes.smallSizedBox,
              Divider(color: grey1.withOpacity(0.6)),
              AppSizedBoxes.largeSizedBox,
              Row(
                children: [
                  Text(
                    'Active Pet profiles',
                    style: AppTextStyles.heading1,
                  ),
                  AppSizedBoxes.smallWidthSizedBox,
                  Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: bgcolor1),
                    child: Obx(() => Center(
                            child: Text(
                          controller.count.value.toString(),
                          style: AppTextStyles.medium,
                        ))),
                  )
                ],
              ),
              AppSizedBoxes.normalSizedBox,
              SizedBox(
                height: Get.height * 0.2,
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: controller.getPetProfiles(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: blue,
                      ));
                    }

                    var petProfiles = snapshot.data!;

                    return Swiper(
                      itemCount: petProfiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        var profile = petProfiles[index];
                        return buildCarouselCard(
                          profile['Name'] ?? '',
                          profile['adoptiondate'],
                          profile['image_url'] ?? 'assets/images/dog.png',
                        );
                      },
                      pagination: SwiperPagination(),
                      layout: SwiperLayout.STACK,
                      itemWidth: MediaQuery.of(context).size.width * 0.8,
                      onIndexChanged: (index) {
                        controller.setCurrentIndex(index);
                      },
                    );
                  },
                ),
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(controller.currentIndex.value, (index) {
                    return GestureDetector(
                      onTap: () => controller.setCurrentIndex(index),
                      child: Container(
                        width: 17.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.currentIndex.value == index
                              ? grey1
                              : Colors.amber,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              AppSizedBoxes.largeSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgcolor1,
                        border: Border.all(color: grey1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Share Profile',
                            style:
                                AppTextStyles.heading1.copyWith(fontSize: 19),
                          ),
                          Text(
                            'Easily share your pet’s profile or add a new one',
                            style: AppTextStyles.small.copyWith(color: grey),
                          ),
                          AppSizedBoxes.largeSizedBox,
                          AppSizedBoxes.smallSizedBox,
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: blue,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgcolor1,
                        border: Border.all(color: grey1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/eating.png'),
                          AppSizedBoxes.normalSizedBox,
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Adoption \n Services',
                              style:
                                  AppTextStyles.heading1.copyWith(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AppSizedBoxes.normalSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(Appointment());
                    },
                    child: Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: bgcolor1,
                          border: Border.all(color: grey1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Image.asset('assets/images/doctor.png'),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Book \n Appointements',
                                style: AppTextStyles.heading1
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bgcolor1,
                        border: Border.all(color: grey1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Image.asset('assets/images/dogloc.png'),
                          AppSizedBoxes.normalSizedBox,
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Breading Services',
                              style:
                                  AppTextStyles.heading1.copyWith(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarouselCard(
      String name, dynamic adoptiondate, String imagePath) {
    String formattedDate = '';
    if (adoptiondate != null && adoptiondate is Timestamp) {
      DateTime date = adoptiondate.toDate();
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
    }

    return Card(
      color: blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.medium
                    .copyWith(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                'Dog | $name',
                style: AppTextStyles.medium,
              ),
              Text(
                'Date | $formattedDate',
                style: AppTextStyles.medium,
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor:
                const Color.fromARGB(255, 210, 206, 206).withOpacity(0.3),
            radius: 59,
            child: CircleAvatar(
              backgroundColor:
                  const Color.fromARGB(255, 210, 206, 206).withOpacity(0.4),
              radius: 54,
              child: CircleAvatar(
                backgroundColor:
                    const Color.fromARGB(255, 210, 206, 206).withOpacity(0.4),
                radius: 47,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imagePath),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
