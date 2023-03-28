import 'package:flutter/material.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// For every employeee Drawer - delete this account
// IconButton(
//                             onPressed: (() {
//                               database
//                                   .child(FirebaseAuth.instance.currentUser!.uid)
//                                   .remove()
//                                   .then((value) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => const SDialog(
//                                       titleText:
//                                           'Employee Deleted Successfully'),
//                                 );
//                               });
//                             }),
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                               size: 35,
//                             ),
//                           ),
