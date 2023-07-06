import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/employee_login.dart';
import '../utils/email_verification/for_email_verification.dart';

class EmployeeSetting extends StatefulWidget {
  const EmployeeSetting({super.key});

  @override
  State<EmployeeSetting> createState() => _EmployeeSettingState();
}

class _EmployeeSettingState extends State<EmployeeSetting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formField = GlobalKey<FormState>();

  Future verifyEmail() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              _auth.currentUser!.reload();
            }),
            icon: const Icon(Icons.refresh),
          ),
        ],
        toolbarHeight: 150,
        foregroundColor: Colors.black,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber.shade100,
                    foregroundImage: const AssetImage('assets/images/user.png'),
                    radius: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      user!.email.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 0,
              color: user.emailVerified == false
                  ? Colors.red.shade100
                  : Colors.amber.shade100,
              margin: const EdgeInsets.all(20),
              child: user.emailVerified == true
                  ? const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Text(
                            'Email Verified',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Text(
                            user.emailVerified == false
                                ? 'Email Not Verified'
                                : 'Email Verified',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Poppins'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: Material(
                                color: Colors.amber.shade600,
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  onPressed: (() {
                                    verifyEmail().then((value) {
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
                                          'Email Verification Sent',
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

                                      Get.to(
                                        () => const ForEmailVerification(),
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
                                  }),
                                  child: const Text(
                                    'Verify this Email',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
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
                          color: user.emailVerified == false
                              ? Colors.grey
                              : Colors.black,
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
                        onTap: user.emailVerified == false
                            ? null
                            : () async {
                                User? user = _auth.currentUser;

                                await user!.delete().then(
                                  (res) {
                                    Get.offAll(() => const EmployeeLogin());
                                    Get.snackbar(
                                      '',
                                      '',
                                      instantInit: true,
                                      backgroundColor: Colors.red,
                                      titleText: const Text(
                                        'User Deleted Successfully',
                                        style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      messageText: const Text(
                                        'You are been redirected to Login Screen',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.white,
                                      padding: const EdgeInsets.all(20),
                                    ).show();
                                  },
                                ).catchError((onError) {
                                  Get.snackbar(
                                    'Error',
                                    '$onError',
                                    instantInit: true,
                                    backgroundColor: Colors.red,
                                    titleText: const Text(
                                      'Deleted',
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
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: user.emailVerified == false
                                  ? const Icon(
                                      Icons.delete_forever_sharp,
                                      size: 30,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.delete_forever_sharp,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Delete this Account',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: user.emailVerified == false
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 18, top: 5),
                      child: Text(
                        user.emailVerified == false
                            ? 'Note: Verify Email to delete your account'
                            : 'Note: Accounts once deleted will never be restored again',
                        style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              color: Colors.red.shade100,
              borderOnForeground: true,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red.shade100,
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
                    _auth.signOut().then((value) {
                      Get.snackbar(
                        '',
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
                          'Logged Out Successfully',
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
                        snackPosition: SnackPosition.BOTTOM,
                      ).show();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmployeeLogin(),
                          ),
                          (route) => false);
                    }).onError((error, stackTrace) {
                      Get.snackbar(
                        '',
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
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.logout,
                          size: 28,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Copyright © 2023',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
