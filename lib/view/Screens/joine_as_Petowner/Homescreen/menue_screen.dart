import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:healmypet/view/auth/onboard/onboardingscreen.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../appassets/colors/colors.dart';
import '../../../../appassets/sizedbox_height.dart';
import '../../../../appassets/textstyle/customstyles.dart';
import '../Add Profile/addprofile_screen.dart';
import '../Add Profile/controller/controller.dart';
import 'Appointment/appointment.dart';
import 'controller/homecontroller.dart';

class MenuScreenPage extends StatelessWidget {
  const MenuScreenPage({super.key});
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgcolor,
          title: Text(
            'Logout',
            style: AppTextStyles.heading1,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyles.medium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: AppTextStyles.medium.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: AppTextStyles.medium,
              ),
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut().then((value) => Get.offAll(Onboardingscreen()));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedindex = 0;
    final PetProfileController controller = Get.find<PetProfileController>();
    final controlle = Get.put(Homecontroller());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppSizedBoxes.largeSizedBox,
          AppSizedBoxes.normalSizedBox,
          GestureDetector(
            onTap: () => ZoomDrawer.of(context)!.close(),
            child: const Icon(
              Iconsax.close_circle,
              color: Colors.white,
              size: 30,
            ),
          ),
          AppSizedBoxes.normalSizedBox,
          Row(
            children: [
              Obx(
                () => CircleAvatar(
                  child: Icon(Iconsax.user),
                  backgroundImage: NetworkImage(controlle.imagepath.value),
                ),
              ),
              AppSizedBoxes.smallWidthSizedBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: AppTextStyles.small,
                  ),
                  Obx(() => Text(
                        controlle.userName.value,
                        style: AppTextStyles.small,
                      ))
                ],
              )
            ],
          ),
          AppSizedBoxes.smallSizedBox,
          Divider(
            color: grey1.withOpacity(0.2),
          ),
          AppSizedBoxes.largeSizedBox,
          Text(
            'Your Pet',
            style: AppTextStyles.medium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            child: Wrap(
              children: [
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: controller.getPetProfiles(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var pets = snapshot.data!;
                    return Wrap(
                        spacing: 10,
                        children: pets.map((pet) {
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor:
                                    selectedindex == pet ? blue : grey1,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(pet['image_url']),
                                  radius: 30,
                                ),
                              ),
                              Text(
                                pet['Name'],
                                style: AppTextStyles.small.copyWith(
                                  color:
                                      selectedindex == pet ? blue : whitecolor,
                                ),
                              ),
                            ],
                          );
                        }).toList());
                  },
                ),
                AppSizedBoxes.smallWidthSizedBox,
                GestureDetector(
                  onTap: () {
                    Get.to(AddprofileScreen());
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: bgcolor1,
                        radius: 26,
                        child: Icon(Iconsax.add, size: 30, color: Colors.white),
                      ),
                      Text(
                        'add new',
                        style: AppTextStyles.small.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSizedBoxes.smallSizedBox,
          Divider(
            color: grey1.withOpacity(0.6),
          ),
          AppSizedBoxes.largeSizedBox,
          Column(
            children: [
              ListTile(
                leading: Image.asset('assets/images/Vector (4).png'),
                title: Text('Dashboard', style: AppTextStyles.medium),
              ),
              ListTile(
                leading: Image.asset('assets/images/Vector (5).png'),
                title: Text('Book Appointment', style: AppTextStyles.medium),
              ),
              ListTile(
                onTap: () {
                  Get.to(Appointment());
                },
                leading: Image.asset('assets/images/Vector (6).png'),
                title: Text('Adoption Services', style: AppTextStyles.medium),
              ),
              ListTile(
                leading: Image.asset('assets/images/Vector (7).png'),
                title: Text('Track Pet', style: AppTextStyles.medium),
              ),
              ListTile(
                leading: Image.asset('assets/images/Vector (6).png'),
                title: Text('Breeding Services', style: AppTextStyles.medium),
              ),
              ListTile(
                leading: Image.asset('assets/images/Vector (6).png'),
                title: Text('Medical Record', style: AppTextStyles.medium),
              ),
            ],
          ),
          AppSizedBoxes.smallSizedBox,
          Divider(
            color: grey1.withOpacity(0.6),
          ),
          AppSizedBoxes.largeSizedBox,
          ListTile(
            onTap: () {
              _showLogoutDialog(context);
            },
            leading: Icon(
              Iconsax.logout,
              color: whitecolor,
            ),
            title: Text('Logout', style: AppTextStyles.medium),
          ),
        ]),
      ),
    );
  }
}
