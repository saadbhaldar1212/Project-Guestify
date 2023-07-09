import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guestify/utils/employee_login_form/email_field.dart';
import 'package:guestify/utils/employee_login_form/password_field.dart';

import '../../login/employee_login.dart';
import '../../utils/simple_dialog/for_employee_dashboard.dart';
import '../../utils/signout_button/signout_button.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key, required this.title});

  final String title;

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  final _formKey = GlobalKey<FormState>();

  final empName = TextEditingController();
  final empPass = TextEditingController();

  final database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    empName.clear();
    empPass.clear();
  }

  Future empSignIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await _auth.createUserWithEmailAndPassword(
      email: empName.text.trim(),
      password: empPass.text.trim(),
    );

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    empName.dispose();
    empPass.dispose();
  }

  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final empRef = database.child('employee/');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (() {
              showDialog(
                  context: context,
                  builder: (context) =>
                      const SimpleDialogForEmployeeDashboard());
            }),
            icon: const Icon(Icons.info_outline),
          )
        ],
        leading: const SignOutButton(),
        title: const Text(
          'Add an Employee',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(0, 77, 120, 1.000),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28.0, bottom: 12.0),
                    child: EmailField(
                      emailController: empName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28.0, top: 8.0),
                    child: PasswordField(
                      passwordController: empPass,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 28, bottom: 8.0, left: 8.0, right: 8.0),
                    child: TransformHelper.translate(
                      x: -0.50,
                      y: -0.50,
                      z: 0,
                      child: Container(
                        width: 120.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            width: 1.3,
                            color: const Color.fromRGBO(0, 77, 120, 1.000),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.transparent,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            color: const Color.fromARGB(0, 17, 150, 207),
                            child: MaterialButton(
                              onPressed: (() {
                                setState(() {
                                  HapticFeedback.vibrate();
                                });
                                if (_formKey.currentState!.validate()) {
                                  empSignIn().then((value) {
                                    empRef.push().set({
                                      "Employee Name": empName.text,
                                      "Employee Password": empPass.text
                                    });

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
                                        'Data Inserted',
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

                                    empName.clear();
                                    empPass.clear();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
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

                                    empName.clear();
                                    empPass.clear();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  });
                                }
                              }),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color.fromRGBO(0, 77, 120, 1.000),
                                ),
                              ),
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
        ),
      ),
    );
  }
}
