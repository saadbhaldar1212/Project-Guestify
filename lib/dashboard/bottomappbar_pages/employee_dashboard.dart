import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/utils/simple_dialog.dart';
import 'package:guestify/utils/utility.dart';

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

  @override
  Widget build(BuildContext context) {
    final empRef = database.child('employee/');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(30),
              color: const Color.fromARGB(255, 17, 150, 207),
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
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  controller: empName,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  autofocus: false,
                                  decoration: const InputDecoration(
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
                                  style: const TextStyle(color: Colors.white),
                                  controller: empPass,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.next,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: false,
                                  decoration: const InputDecoration(
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
                                      //add those two fields into Firebase Authorisations or Realtime Database so that we can be able to fetch all the employee onto other cards
                                      //this value fetching will be done when CONTINUE WITH EMPLOYEE is clicked

                                      //for each primary key code is different I guess
                                      empRef.push().set({
                                        "Employee Name": empName.text,
                                        "Employee Password": empPass.text
                                      }).then((value) {
                                        Utils().toastMessage(
                                            'Data inserted successfully');
                                        empName.clear();
                                        empPass.clear();
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
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: empRef,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  color: const Color.fromARGB(255, 17, 150, 207),
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: SingleChildScrollView(
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person,
                                color: Colors.black, size: 40),
                          ),
                          title: Text(
                              snapshot.child('Employee Name').value.toString()),
                          subtitle: Text(snapshot
                              .child('Employee Password')
                              .value
                              .toString()),
                          trailing: IconButton(
                            onPressed: (() {
                              showDialog(
                                context: context,
                                builder: (context) => const SDialog(
                                    titleText: 'Employee Deleted Successfully'),
                              );
                            }),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
