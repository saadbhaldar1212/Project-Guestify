import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guestify/home/employee_home.dart';
import 'package:guestify/settings/employee_setting_controller.dart';
import '../login/employee_login.dart';
import '../utils/email_verification/for_email_verification.dart';

class EmployeeSetting extends StatelessWidget {
  final EmployeeSettingController controller =
      Get.put(EmployeeSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployeeModule(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
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
            onPressed: controller.reloadUser,
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
                    foregroundImage: const AssetImage(
                      'assets/images/user.png',
                    ),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Obx(() {
                      return Text(
                        controller.user.value?.email ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Card(
                elevation: 0,
                color: controller.user.value?.emailVerified == false
                    ? Colors.red.shade100
                    : Colors.amber.shade100,
                margin: const EdgeInsets.all(20),
                child: controller.user.value?.emailVerified == true
                    ? const Padding(
                        padding: EdgeInsets.all(28.0),
                        child: Column(
                          children: [
                            Text(
                              'Email Verified',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
                              controller.user.value?.emailVerified == false
                                  ? 'Email Not Verified'
                                  : 'Email Verified',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
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
                                    onPressed: () {
                                      controller.verifyEmail().then((value) {
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

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForEmailVerification(),
                                            ),
                                            (route) => false);
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
                                    },
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
              );
            }),
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
                          color: controller.user.value?.emailVerified == false
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
                        onTap: controller.user.value?.emailVerified == false
                            ? null
                            : () async {
                                await controller.deleteUser().then(
                                  (res) {
                                    Get.snackbar(
                                      'Success',
                                      'User Deleted Successfully',
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
                                    Get.offAll(() => const EmployeeLogin());
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
                              child:
                                  controller.user.value?.emailVerified == false
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
                                  color: controller.user.value?.emailVerified ==
                                          false
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
                        controller.user.value?.emailVerified == false
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
                    controller.signOut().then((value) {
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
                'Copyright © 2025',
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
