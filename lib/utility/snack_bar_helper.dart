// lib/utility/snack_bar_helper.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  // Display an error snackbar with a custom message and title
  static void showErrorSnackBar(String message, {String title = "Error"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    // Adjust margin based on screen size
    final margin = screenWidth >= 300
        ? const EdgeInsets.symmetric(horizontal: 300)
        : EdgeInsets.zero;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  // Display a success snackbar with a custom message and title
  static void showSuccessSnackBar(String message, {String title = "Success"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    // Adjust margin based on screen size
    final margin = screenWidth >= 300
        ? const EdgeInsets.symmetric(horizontal: 300)
        : EdgeInsets.zero;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
