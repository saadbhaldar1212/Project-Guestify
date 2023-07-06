import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../welcome/welcome.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut().then((value) {
      Get.snackbar(
        '',
        '',
        instantInit: true,
        titleText: const Text(
          'Success',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        messageText: const Text(
          'Logged Out',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.green,
        icon: const Icon(
          Icons.logout,
        ),
      ).show();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeSplash(),
        ),
        (route) => false,
      );
    }).onError((error, stackTrace) {
      Get.snackbar(
        'Error',
        error.toString(),
        instantInit: true,
        backgroundColor: Colors.red,
        titleText: const Text(
          'Error',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        padding: const EdgeInsets.all(20),
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        signOut();
      }),
      icon: const Icon(
        Icons.logout,
      ),
    );
  }
}
