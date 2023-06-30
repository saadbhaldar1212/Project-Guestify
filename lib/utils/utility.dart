import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Utils {
  void successMessage(String desc) {
    MotionToast.success(
      title: const Text(
        'Success',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      description: Text(desc),
      iconType: IconType.cupertino,
      enableAnimation: false,
      animationDuration: const Duration(milliseconds: 100),
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
  }

  void errorMessage(String desc) {
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      description: Text(desc),
      iconType: IconType.cupertino,
      enableAnimation: false,
      animationDuration: const Duration(milliseconds: 100),
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
  }

  void deleteMessage(String desc) {
    MotionToast.delete(
      title: const Text(
        'Success',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      description: Text(desc),
      iconType: IconType.cupertino,
      enableAnimation: false,
      animationDuration: const Duration(milliseconds: 100),
      animationType: AnimationType.fromBottom,
      dismissable: true,
    );
  }
}
