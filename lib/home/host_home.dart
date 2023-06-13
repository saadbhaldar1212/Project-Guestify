import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

// import '../utils/signout_button/signout_button.dart';

class GuestInfo {
  final String gName;
  final String gEmail;
  final String gContact;
  final String gSeatTable;

  GuestInfo(
      {required this.gName,
      required this.gEmail,
      required this.gContact,
      required this.gSeatTable});
}

class HostIndex extends StatefulWidget {
  const HostIndex({super.key});

  @override
  State<HostIndex> createState() => _HostIndexState();
}

class _HostIndexState extends State<HostIndex> {
  final db = FirebaseDatabase.instance.ref();

  List<GuestInfo> _filteredGuestInfoList = [];

  @override
  Widget build(BuildContext context) {
    final presentEventDay = db.child('guest/').child('guest_info/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Present Guests',
        ),
        // actions: [
        //   // IconButton(
        //   //   onPressed: (() {}),
        //   //   icon: const Icon(Icons.search),
        //   // ),
        //   const SignOutButton()
        // ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: presentEventDay,
          itemBuilder: (context, snapshot, animation, index) {
            Map guestData = snapshot.value as Map;
            String attendanceSummary = guestData['attendanceStatus'];

            // Filter the guest information based on the 'attendanceSummary' field
            if (attendanceSummary == 'Present') {
              _filteredGuestInfoList.add(
                GuestInfo(
                    gName: guestData['Guest Name'],
                    gEmail: guestData['Guest Email'],
                    gContact: guestData['Guest Phone Number'],
                    gSeatTable: '${guestData['Table Number']}'),
              );
            }

            return _buildGuestInfoItem(_filteredGuestInfoList[index]);

            // if (snapshot.child('attendanceSummary').value == 'Present') {
            //   return Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 10.0),
            //     child: Card(
            //       margin: const EdgeInsets.symmetric(
            //         horizontal: 20,
            //       ),
            //       color: Colors.red.shade100,
            //       child: Padding(
            //         padding: const EdgeInsets.all(18.0),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Guest Name: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15,
            //                   ),
            //                 ),
            //                 Text(
            //                   snapshot.child('Guest Name').value.toString(),
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Guest Email: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15,
            //                   ),
            //                 ),
            //                 Text(
            //                   snapshot.child('Guest Email').value.toString(),
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Table Number: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15,
            //                   ),
            //                 ),
            //                 Text(
            //                   snapshot.child('Table Number').value.toString(),
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Chair Number: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15,
            //                   ),
            //                 ),
            //                 Text(
            //                   snapshot.child('Chair Number').value.toString(),
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 const Text(
            //                   'Guest Phone Number: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 15,
            //                   ),
            //                 ),
            //                 Text(
            //                   snapshot
            //                       .child('Guest Phone Number')
            //                       .value
            //                       .toString(),
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 20,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
            // }
            // return const Text('No Data available');
          },
        ),
      ),
    );
  }
}

Widget _buildGuestInfoItem(GuestInfo guestInfo) {
  return ListTile(
    title: Text(
      'Name: ${guestInfo.gName}',
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    subtitle: Text(
      'Email: ${guestInfo.gEmail}',
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
