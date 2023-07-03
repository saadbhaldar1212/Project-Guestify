import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/employee_home.dart';

class ForEmailVerification extends StatefulWidget {
  const ForEmailVerification({super.key});

  @override
  State<ForEmailVerification> createState() => _ForEmailVerificationState();
}

class _ForEmailVerificationState extends State<ForEmailVerification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future verifyEmail() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  void autoRedirectAfterEmailVerification() {
    Timer? timer = Timer.periodic(const Duration(seconds: 3), (t) {
      setState(() {
        t.cancel();
      });
      User? user = _auth.currentUser;

      if (user!.emailVerified) {
        t.cancel();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeeModule(),
            ),
            (route) => false).then((value) {
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
              'Email Verified Successfully',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            backgroundColor: Colors.green,
            icon: const Icon(
              Icons.check_box,
            ),
          ).show();
        }).onError((error, stackTrace) {
          Get.snackbar(
            '',
            instantInit: true,
            '',
            titleText: const Text(
              'Error',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            messageText: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.error,
            ),
          ).show();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    autoRedirectAfterEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 150,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                  size: 140,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Verify your email Address',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
              ),
              child: Text(
                'We have just sent email verification link on your emial. Please check email and click on that link to verify your Email Address',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 35,
              ),
              child: Text(
                'If not auto redirected after verification, click on the Continue Button',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            15,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmployeeModule(),
                              ),
                              (route) => false).then((value) {
                            if (user!.emailVerified == true) {
                              Get.snackbar(
                                '',
                                instantInit: true,
                                '',
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
                                  'Email Verified Successfully',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                icon: const Icon(
                                  Icons.check_box,
                                ),
                              ).show();
                            } else {
                              Get.snackbar(
                                '',
                                instantInit: true,
                                '',
                                titleText: const Text(
                                  'Error',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                messageText: const Text(
                                  'Something went wrong',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                icon: const Icon(
                                  Icons.error,
                                ),
                              ).show();
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20,
              ),
              child: TextButton(
                onPressed: (() {
                  verifyEmail().then((value) {
                    Get.snackbar(
                      '',
                      '',
                      instantInit: true,
                      titleText: const Text(
                        'Email Verification link sent',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      messageText: const Text(
                        'Please check email and click on that link to verify your Email Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      backgroundColor: Colors.green,
                      icon: const Icon(
                        Icons.mail,
                      ),
                    ).show();
                  }).onError((error, stackTrace) {
                    Get.snackbar(
                      '',
                      '',
                      instantInit: true,
                      titleText: const Text(
                        'Error',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      messageText: Text(
                        error.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      icon: const Icon(
                        Icons.error,
                      ),
                    ).show();
                  });
                }),
                child: const Text(
                  'Resend Email Link',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
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
