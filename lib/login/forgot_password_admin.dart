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
        backgroundColor: const Color.fromRGBO(19, 159, 219, 10),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),
          child: Form(
            key: _empFormField,
            child: TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: 13,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 17, 150, 207),
                    width: 1.6,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 17, 150, 207),
                    width: 1.6,
                  ),
                ),
                helperText: 'e.g: - abc@<>.com',
                helperStyle: const TextStyle(
                  fontSize: 10,
                ),
                labelText: 'Username',
                hintText: 'Enter email address',
                hintStyle: const TextStyle(
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter email';
                } else if (!value.contains('@')) {
                  return 'Enter valid email address';
                }
                // else if (!value.startsWith('employee.')) {
                //   return 'Enter email using given instructions';
                // }
                else if (!value.endsWith('.com')) {
                  return 'Username should end with .com';
                }
                return null;
              },
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                description: const Text(
                  'Reset Password link sent successfully',
                  style: TextStyle(color: Colors.green),
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
                animationDuration: const Duration(milliseconds: 100),
                animationType: AnimationType.fromBottom,
              ).show(context);
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
              ).show(context);
            });
          }
        }),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
.then((value) {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      elevation: 0,
                      backgroundColor: Colors.green,
                      builder: (context) {
                        return Card(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.done,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Success',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Success',
                                    style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).onError((error, stackTrace) {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      elevation: 0,
                      backgroundColor: Colors.red,
                      builder: (context) {
                        return Card(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Error',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    error.toString(),
                                    style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
*/
