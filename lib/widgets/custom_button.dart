import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appassets/colors/colors.dart';
import '../appassets/textstyle/customstyles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const CustomButton({
    required this.ontap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: ontap,
          child: Text(
            title,
            style: AppTextStyles.medium,
          )),
    );
  }
}
