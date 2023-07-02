import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../welcome/welcome.dart';
import '../toast/motion_toast.dart';
import '../toast/resources/arrays.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut().then((value) {
      MotionToast.success(
        title: const Text(
          'Success',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        description: const Text('Signed Out SuccessFully',
            style: TextStyle(color: Colors.green)),
        iconType: IconType.cupertino,
        enableAnimation: false,
        animationDuration: const Duration(milliseconds: 100),
        animationType: AnimationType.fromBottom,
        dismissable: true,
      ).show(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeSplash(),
        ),
        (route) => false,
      );
    }).onError((error, stackTrace) {
      MotionToast.error(
        title: const Text(
          'Error',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        description: Text(error.toString()),
        iconType: IconType.cupertino,
        enableAnimation: false,
        animationDuration: const Duration(milliseconds: 100),
        animationType: AnimationType.fromBottom,
        dismissable: true,
      ).show(context);
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
