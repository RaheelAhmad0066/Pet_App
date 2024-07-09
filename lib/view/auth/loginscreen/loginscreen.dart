import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../appassets/colors/colors.dart';
import '../../../appassets/sizedbox_height.dart';
import '../../../appassets/textstyle/customstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../controller/authcontroller.dart';
import '../registerscreen/registerscreen.dart';

class LoginScreen extends StatelessWidget {
  final String role; // Add this line to accept a role parameter
  final AuthController authController = Get.put(AuthController());
  LoginScreen(
      {required this.role}); // Update the constructor to accept the role parameter

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                padding: const EdgeInsets.only(top: 360),
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20),
                          topStart: Radius.circular(20)),
                      color: bgcolor // Adjust opacity as needed
                      ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        children: [
                          AppSizedBoxes.largeSizedBox,
                          Text('Sign In as a ${role.capitalizeFirst}',
                              style: AppTextStyles.heading1),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                'Welcome! Please enter your information below and get started.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.medium),
                          ),
                          AppSizedBoxes.largeSizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: CustomTextField(
                              hintText: 'User Email',
                              onchange: (value) =>
                                  authController.email.value = value!,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          AppSizedBoxes.normalSizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: CustomTextField(
                              hintText: 'Password',
                              onchange: (value) =>
                                  authController.password.value = value!,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          AppSizedBoxes.smallSizedBox,
                          Row(
                            children: [
                              Checkbox(
                                  value: false,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onChanged: (onChanged) {
                                    onChanged = false;
                                  }),
                              Text(
                                'Accept Terms and Conditions',
                                style:
                                    AppTextStyles.medium.copyWith(fontSize: 11),
                              )
                            ],
                          ),
                          Obx(
                            () => authController.isLoading.value
                                ? CircularProgressIndicator(
                                    color: blue,
                                  )
                                : CustomButton(
                                    ontap: () {
                                      if (key.currentState!.validate()) {
                                        authController.login();
                                      }
                                    },
                                    title: 'Sign In Account'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Do you not have an account?',
                                style:
                                    AppTextStyles.medium.copyWith(color: grey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (role == 'vet') {
                                      Get.to(() => Registerscreen(
                                            isVet: true,
                                          ));
                                    } else {
                                      Get.to(() => Registerscreen(
                                            isVet: false,
                                          ));
                                    }
                                  },
                                  child: Text('Register here!',
                                      style: AppTextStyles.medium))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 330,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: bgcolor,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: blue)),
                      child: Icon(
                        Iconsax.user,
                        color: blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
