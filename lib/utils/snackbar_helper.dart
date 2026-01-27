import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showSuccess(String message) {
    Get.snackbar(
      'SUCCESS',
      message,
      backgroundColor: const Color(0xFFFCDCB3),
      colorText: Colors.black,
      borderWidth: 3,
      borderColor: Colors.black,
      borderRadius: 0,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      titleText: const Text(
        'SUCCESS',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  static void showError(String message) {
    Get.snackbar(
      'ERROR',
      message,
      backgroundColor: const Color(0xFFEB8D9F),
      colorText: Colors.black,
      borderWidth: 3,
      borderColor: Colors.black,
      borderRadius: 0,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      titleText: const Text(
        'ERROR',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  static void showInfo(String message) {
    Get.snackbar(
      'INFO',
      message,
      backgroundColor: const Color(0xFFBDDAF0),
      colorText: Colors.black,
      borderWidth: 3,
      borderColor: Colors.black,
      borderRadius: 0,
      margin: const EdgeInsets.all(16),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      titleText: const Text(
        'INFO',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
