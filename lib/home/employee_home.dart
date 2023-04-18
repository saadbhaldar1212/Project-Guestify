// import 'package:flutter/material.dart';

// class EmployeeHome extends StatefulWidget {
//   const EmployeeHome({super.key});

//   @override
//   State<EmployeeHome> createState() => _EmployeeHomeState();
// }

// class _EmployeeHomeState extends State<EmployeeHome> {
//   static const int numItems = 10;
//   List<bool> selected = List<bool>.generate(numItems, (int index) => false);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       home: DataTable(
//         columns: const <DataColumn>[
//           DataColumn(
//             label: Text('Number'),
//           ),
//         ],
//         rows: List<DataRow>.generate(
//           numItems,
//           (int index) => DataRow(
//             color: MaterialStateProperty.resolveWith<Color?>(
//                 (Set<MaterialState> states) {
//               // All rows will have the same selected color.
//               if (states.contains(MaterialState.selected)) {
//                 return Theme.of(context).colorScheme.primary.withOpacity(0.08);
//               }
//               // Even rows will have a grey color.
//               if (index.isEven) {
//                 return Colors.grey.withOpacity(0.3);
//               }
//               return null; // Use default value for other states and odd rows.
//             }),
//             cells: <DataCell>[DataCell(Text('Row $index'))],
//             selected: selected[index],
//             onSelectChanged: (bool? value) {
//               setState(() {
//                 selected[index] = value!;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



// // import 'package:flutter/material.dart';

// // class EmployeeHome extends StatefulWidget {
// //   const EmployeeHome({super.key});

// //   @override
// //   State<EmployeeHome> createState() => _EmployeeHomeState();
// // }

// // class _EmployeeHomeState extends State<EmployeeHome> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }

// // For every employeee Drawer - delete this account
// // IconButton(
// //                             onPressed: (() {
// //                               database
// //                                   .child(FirebaseAuth.instance.currentUser!.uid)
// //                                   .remove()
// //                                   .then((value) {
// //                                 showDialog(
// //                                   context: context,
// //                                   builder: (context) => const SDialog(
// //                                       titleText:
// //                                           'Employee Deleted Successfully'),
// //                                 );
// //                               });
// //                             }),
// //                             icon: const Icon(
// //                               Icons.delete,
// //                               color: Colors.red,
// //                               size: 35,
// //                             ),
// //                           ),
