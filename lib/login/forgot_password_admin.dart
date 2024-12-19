import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guestify/utils/simple_dialog/for_emoloyee_reset_password.dart';

import '../utils/employee_login_form/email_field.dart';
import 'employee_login.dart';

class EmployeeForgotPassword extends StatefulWidget {
  const EmployeeForgotPassword({super.key});

  @override
  State<EmployeeForgotPassword> createState() => _EmployeeForgotPasswordState();
}

class _EmployeeForgotPasswordState extends State<EmployeeForgotPassword> {
  final emailController = TextEditingController();
  final _empFormField = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Login help',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 34,
            fontWeight: FontWeight.w300,
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 200,
        leading: TextButton(
          onPressed: (() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployeeLogin(),
                ),
                (route) => false);
          }),
          child: const Text(
            '<',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Text(
                    'Find your account',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    'Enter your email address linked to your account',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Form(
                key: _empFormField,
                child: EmailField(emailController: emailController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Material(
                  color: Colors.amber.shade600,
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: (() async {
                      setState(() {
                        HapticFeedback.vibrate();
                      });
                      if (_empFormField.currentState!.validate()) {
                        _auth
                            .sendPasswordResetEmail(
                          email: emailController.text.toString(),
                        )
                            .then((value) {
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
                              'Reset Password sent Successfull',
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
                          showResetPasswordDialog(context);
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
                    }),
                    child: const Text(
                      'Submit',
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
  }

  void showResetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ResetPasswordDialog();
      },
    );
  }
}
