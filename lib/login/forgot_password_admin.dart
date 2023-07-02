import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/toast/motion_toast.dart';
import '../utils/toast/resources/arrays.dart';
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
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                    ),
                    helperText: 'e.g: - abc@<>.com',
                    helperStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                    ),
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email';
                    } else if (!value.contains('@')) {
                      return 'Enter valid email address';
                    } else if (!value.startsWith('employee.')) {
                      return 'Enter email using given instructions';
                    } else if (!value.endsWith('.com')) {
                      return 'Username should end with .com';
                    }
                    return null;
                  },
                ),
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
                    onPressed: (() {
                      if (_empFormField.currentState!.validate()) {
                        _auth
                            .sendPasswordResetEmail(
                          email: emailController.text.toString(),
                        )
                            .then((value) {
                          MotionToast.success(
                            title: const Text(
                              'Success',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            description: const Text(
                              'Reset Password link sent successfully',
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onClose: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmployeeLogin(),
                                ),
                                (route) => false,
                              );
                            },
                            iconType: IconType.cupertino,
                            enableAnimation: false,
                            animationDuration:
                                const Duration(milliseconds: 100),
                            animationType: AnimationType.fromBottom,
                          ).show(context);
                        }).onError((error, stackTrace) {
                          MotionToast.error(
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            description: Text(error.toString()),
                            iconType: IconType.cupertino,
                            enableAnimation: false,
                            animationDuration:
                                const Duration(milliseconds: 100),
                            animationType: AnimationType.fromBottom,
                          ).show(context);
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:
    );
  }
}
