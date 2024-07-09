import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchange;
  int? maxlines;
  int? maxlength;
  int? minlines;
  CustomTextField(
      {required this.hintText,
      required this.obscureText,
      this.validator,
      this.maxlines = 1,
      this.minlines,
      this.maxlength,
      this.onchange,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomTextFieldController());
    return TextFormField(
      style: TextStyle(color: whitecolor),
      obscureText: obscureText ? controller.obscureText.value : false,
      keyboardType: textInputType,
      maxLines: maxlines,
      maxLength: maxlength,
      minLines: minlines,
      onChanged: onchange,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: AppTextStyles.small,
        filled: true,
        fillColor: Color(0xff313945),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 117, 115, 115),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 117, 115, 115),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 117, 115, 115),
          ),
        ),
        suffixIcon: obscureText
            ? Obx(
                () => IconButton(
                  icon: Icon(
                    controller.obscureText.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: controller.toggleObscureText,
                ),
              )
            : null,
      ),
      validator: validator,
    );
  }
}

class CustomTextFieldController extends GetxController {
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
