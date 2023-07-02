import 'package:Guestify/login/employee_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteEmpFromAuth extends StatefulWidget {
  const DeleteEmpFromAuth({super.key});

  @override
  State<DeleteEmpFromAuth> createState() => _DeleteEmpFromAuthState();
}

class _DeleteEmpFromAuthState extends State<DeleteEmpFromAuth> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final db = FirebaseDatabase.instance.ref();
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
          'Delete an Account',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  child: Text(
                    'Delete your account',
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
              padding: const EdgeInsets.only(
                  top: 38, bottom: 8.0, left: 20.0, right: 20.0),
              child: TransformHelper.translate(
                x: -0.50,
                y: -0.50,
                z: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Material(
                      color: Colors.red,
                      child: MaterialButton(
                        onPressed: (() async {
                          User? user = _auth.currentUser;

                          await user!.delete().then(
                            (res) {
                              Get.offAll(() => const EmployeeLogin());
                              Get.snackbar(
                                '',
                                '',
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
                              );
                            },
                          ).catchError((onError) {
                            Get.snackbar(
                              'Error',
                              '$onError',
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
                            );
                          });
                        }),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              'Delete Forever',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
    );
  }
}
