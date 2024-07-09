import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static void showError(String errorMessage) {
    Get.snackbar(
      'Error',
      errorMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  static String getErrorMessage(dynamic error) {
    String errorMessage = 'Registration failed. Please try again later.';

    // Check if the error is FirebaseAuthException
    if (error is FirebaseAuthException) {
      FirebaseAuthException authError = error as FirebaseAuthException;
      switch (authError.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email & Password accounts are not enabled.';
          break;
        // Handle other FirebaseAuthException codes as needed
        default:
          errorMessage = 'Firebase Auth Error: ${authError.message}';
          break;
      }
    } else {
      errorMessage = 'Error: ${error.toString()}';
    }

    return errorMessage;
  }
}
