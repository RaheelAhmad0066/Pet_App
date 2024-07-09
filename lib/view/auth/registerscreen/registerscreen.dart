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
import '../loginscreen/loginscreen.dart';

class Registerscreen extends StatelessWidget {
  final bool isVet;
  Registerscreen({required this.isVet});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Color(0xff282f3c),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 190),
              child: Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                        topStart: Radius.circular(20)),
                    color: bgcolor // Adjust opacity as needed
                    ),
                child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        AppSizedBoxes.largeSizedBox,
                        Text(isVet ? 'Join as Vet' : 'Join as Pet Owner',
                            style: AppTextStyles.heading1),
                        AppSizedBoxes.largeSizedBox,
                        isVet
                            ? Column(
                                children: [
                                  CustomTextField(
                                    onchange: (value) =>
                                        authController.userName.value = value!,
                                    hintText: 'Username',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your user name';
                                      }
                                      return null;
                                    },
                                  ),
                                  AppSizedBoxes.normalSizedBox,
                                  CustomTextField(
                                    onchange: (value) =>
                                        authController.fullName.value = value!,
                                    hintText: 'Full Name',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),
                                  AppSizedBoxes.normalSizedBox,
                                  CustomTextField(
                                    onchange: (value) => authController
                                        .clinicName.value = value!,
                                    hintText: 'Clinic Name',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your clinic name';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  CustomTextField(
                                    onchange: (value) =>
                                        authController.userName.value = value!,
                                    hintText: 'Username',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your user name';
                                      }
                                      return null;
                                    },
                                  ),
                                  AppSizedBoxes.normalSizedBox,
                                  CustomTextField(
                                    onchange: (value) =>
                                        authController.fullName.value = value!,
                                    hintText: 'Full Name',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                        AppSizedBoxes.normalSizedBox,
                        CustomTextField(
                          hintText: 'Phone',
                          onchange: (value) =>
                              authController.phone.value = value!,
                          obscureText: false,
                          maxlength: 11, // restrict input to 11 digits
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.length != 11) {
                              return 'Please enter a valid 11-digit phone number';
                            } else if (!GetUtils.isNumericOnly(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        AppSizedBoxes.normalSizedBox,
                        isVet
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      authController.pickDocument(context);
                                    },
                                    child: Container(
                                      height: 53,
                                      width: Get.width * 0.44,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 117, 115, 115),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Color(0xff313945)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Obx(
                                            () => Text(
                                              authController
                                                      .documentName.isEmpty
                                                  ? 'Upload \n Documents'
                                                  : authController
                                                      .documentName.value
                                                      .substring(0, 12),
                                              overflow: TextOverflow.fade,
                                              style: AppTextStyles.medium,
                                            ),
                                          ),
                                          Icon(
                                            Iconsax.document_upload,
                                            color: whitecolor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 53,
                                    width: Get.width * 0.44,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(
                                              255, 117, 115, 115),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xff313945)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(
                                        () => DropdownButton<String>(
                                          underline: SizedBox(),
                                          hint: Text('Select Gender'),
                                          value: authController
                                              .selectedGender.value,
                                          onChanged: (String? newValue) {
                                            authController.selectedGender
                                                .value = newValue!;
                                          },
                                          dropdownColor: bgcolor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          items: authController.genders
                                              .map((String gender) {
                                            return DropdownMenuItem<String>(
                                              value: gender,
                                              child: Text(
                                                gender,
                                                style: AppTextStyles.medium,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 53,
                                width: Get.width * 0.9,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 117, 115, 115),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xff313945)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => DropdownButton<String>(
                                      underline: SizedBox(),
                                      hint: Text('Select Gender'),
                                      value:
                                          authController.selectedGender.value,
                                      onChanged: (String? newValue) {
                                        authController.selectedGender.value =
                                            newValue!;
                                      },
                                      iconEnabledColor: Color(0xff313945),
                                      dropdownColor: bgcolor,
                                      borderRadius: BorderRadius.circular(12),
                                      items: authController.genders
                                          .map((String gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(
                                            gender,
                                            style: AppTextStyles.medium,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                        AppSizedBoxes.normalSizedBox,
                        CustomTextField(
                          hintText: 'Email',
                          obscureText: false,
                          onchange: (value) =>
                              authController.email.value = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid phone';
                            }
                            return null;
                          },
                        ),
                        AppSizedBoxes.normalSizedBox,
                        CustomTextField(
                          hintText: 'Password',
                          onchange: (value) =>
                              authController.password.value = value!,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
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
                          () => authController.isLoading1.value
                              ? CircularProgressIndicator(
                                  color: blue,
                                )
                              : CustomButton(
                                  ontap: () {
                                    if (key.currentState!.validate()) {
                                      authController.register(isVet);
                                    }
                                  },
                                  title: 'Create Account'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: AppTextStyles.medium.copyWith(color: grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (isVet == true) {
                                    Get.to(() => LoginScreen(role: 'vet'));
                                  } else {
                                    Get.to(
                                        () => LoginScreen(role: 'pet owner'));
                                  }
                                },
                                child: Text('Login here!',
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
              top: 160,
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
    );
  }
}
