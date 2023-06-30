import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../utils/simple_dialog/for_employee_dashboard.dart';
import '../../utils/signout_button/signout_button.dart';
import '../../utils/toast/motion_toast.dart';
import '../../utils/toast/resources/arrays.dart';

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
          'Manage Employee',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Card(
                  color: const Color.fromRGBO(0, 77, 120, 1.000),
                  child: SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 28.0, bottom: 38),
                            child: Text(
                              'Add an Employee',
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: TextFormField(
                                      focusNode: unitCodeCtrlFocusNode,
                                      cursorColor: Colors.white,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: empName,
                                      cursorHeight: 20,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(
                                          fontSize: 13,
                                        ),
                                        contentPadding: EdgeInsets.all(20),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        labelText: 'Employee Name',
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Employee Name';
                                        } else if (!value.contains('@')) {
                                          return 'Enter valid email address';
                                        } else if (!value
                                            .startsWith('employee.')) {
                                          return 'Create account using given instructions';
                                        } else if (!value.endsWith('.com')) {
                                          return 'Username should end with ".com"';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: empPass,
                                      cursorHeight: 20,
                                      textInputAction: TextInputAction.next,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(
                                          fontSize: 13,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        labelText: 'Employee Password',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Employee Password';
                                        } else if (value.length < 6) {
                                          return 'Minimum length of password should be 6';
                                        } else if (!value.contains(
                                          RegExp(r'[A-Z]'),
                                        )) {
                                          return 'Password should contain atleast one Capital letter';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 28.0),
                                    child: ElevatedButton(
                                      onPressed: (() {
                                        if (_formKey.currentState!.validate()) {
                                          empSignIn().then((value) {
                                            empRef.push().set({
                                              "Employee Name": empName.text,
                                              "Employee Password": empPass.text
                                            });

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
                                                  'Data Inserted SuccessFully',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                              iconType: IconType.cupertino,
                                              enableAnimation: false,
                                              animationDuration: const Duration(
                                                  milliseconds: 100),
                                              animationType:
                                                  AnimationType.fromBottom,
                                              dismissable: true,
                                            ).show(context);

                                            empName.clear();
                                            empPass.clear();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          }).onError((error, stackTrace) {
                                            MotionToast.error(
                                              title: const Text(
                                                'Error',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              description:
                                                  Text(error.toString()),
                                              iconType: IconType.cupertino,
                                              enableAnimation: false,
                                              animationDuration: const Duration(
                                                  milliseconds: 100),
                                              animationType:
                                                  AnimationType.fromBottom,
                                              dismissable: true,
                                            ).show(context);

                                            empName.clear();
                                            empPass.clear();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          });
                                        }
                                      }),
                                      child: const Text(
                                        'Create',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Card(
                      color: const Color.fromRGBO(204, 237, 255, 1),
                      child: SizedBox(
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            bottom: 15,
                            right: 15,
                            top: 75,
                          ),
                          child: FirebaseAnimatedList(
                            shrinkWrap: true,
                            query: empRef,
                            itemBuilder: (context, snapshot, animation, index) {
                              return SingleChildScrollView(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      color: Color.fromRGBO(0, 77, 120, 1.000),
                                      size: 50,
                                    ),
                                  ),
                                  title: Text(
                                    snapshot
                                        .child('Employee Name')
                                        .value
                                        .toString(),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 77, 120, 1.000),
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot
                                        .child('Employee Password')
                                        .value
                                        .toString(),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 77, 120, 1.000),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(23.0),
                        child: Text(
                          'Employee Data',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromRGBO(0, 77, 120, 1.000),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
