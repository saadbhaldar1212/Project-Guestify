import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';
import 'package:intl/intl.dart';

import '../login/adminLogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final eventInfo = database.child("events/");
    const _primaryKey = "eventInfo";

    final _formKey = GlobalKey<FormState>();
    final _eName = TextEditingController();
    final _eTopic = TextEditingController();
    final _eChiefGuest = TextEditingController();
    final _eSpecialGuest = TextEditingController();
    final _eHost = TextEditingController();
    final _eVenue = TextEditingController();
    final _eDate = TextEditingController();
    final _eTime = TextEditingController();
    final _eDesc = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        title: TextButton(
          onPressed: (() {}),
          child: const Text(
            'Event Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.live_help_outlined),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
        query: eventInfo,
        itemBuilder: (context, snapshot, animation, index) {
          Map events = snapshot.value as Map;
          events['key'] = snapshot.key;

          return snapshot.hasChild('events/')
              ? const Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                events['Event Name'],
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              events['Event Topic'],
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0, left: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Host name - ',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(events["Event Host"])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Chief Guest: - ',
                                  style: TextStyle(fontSize: 18)),
                              Text(events["Event Chief Guest"])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Event Special Guest: - ',
                                  style: TextStyle(fontSize: 18)),
                              Text(events["Event Special Guest"])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 45.0, left: 15.0, right: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Event Date & Time: - ',
                                  style: TextStyle(fontSize: 18)),
                              Text(
                                  '${events["Event Date"]}, ${events["Event Time"]}.')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0, bottom: 35.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Event Venue: - ',
                                  style: TextStyle(fontSize: 18)),
                              Text(events["Event Venue"])
                            ],
                          ),
                        ),
                        const Divider(
                          indent: 100,
                          endIndent: 100,
                          color: Color.fromARGB(255, 17, 150, 207),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 40.0, right: 40.0, bottom: 15.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 280,
                                child: Text(events["Event Description"]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: ElevatedButton(
                            onPressed: (() {}),
                            child: const Text('Continue'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                onPressed: (() {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      title: const Text(
                                        'Edit Event Details',
                                        textAlign: TextAlign.center,
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                      elevation: 10,
                                      alignment: Alignment.center,
                                      children: [
                                        TextFormField(
                                          controller: _eTopic,
                                          cursorHeight: 20,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.multiline,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Topic',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _eChiefGuest,
                                          cursorHeight: 20,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.multiline,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Chief Guest',
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Enter email';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                        TextFormField(
                                          controller: _eSpecialGuest,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.multiline,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Special Guest',
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Enter email';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                        TextFormField(
                                          controller: _eHost,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.multiline,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Host',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _eVenue,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.multiline,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Venue',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _eDate,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.datetime,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Date',
                                            constraints: BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            suffixIcon: Icon(
                                                Icons.calendar_month_outlined),
                                          ),
                                          validator: (value) {},
                                          onTap: () async {
                                            DateTime? datePicked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime.now());

                                            if (datePicked != null) {
                                              setState(() {
                                                _eDate.text = DateFormat()
                                                    .add_yMMMMd()
                                                    .format(datePicked);
                                              });
                                            }
                                          },
                                        ),
                                        TextFormField(
                                          controller: _eTime,
                                          cursorHeight: 20,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.datetime,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Time',
                                            constraints: BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            suffixIcon:
                                                Icon(Icons.access_time_sharp),
                                          ),
                                          validator: (value) {},
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                              initialEntryMode:
                                                  TimePickerEntryMode.dial,
                                            );
                                            if (pickedTime != null) {
                                              _eTime.text = TimeOfDay.now()
                                                  .format(context);
                                            }
                                          },
                                        ),
                                        TextFormField(
                                          controller: _eDesc,
                                          cursorHeight: 20,
                                          textInputAction:
                                              TextInputAction.newline,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 3,
                                          maxLines: 5,
                                          autofocus: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Event Description',
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Enter email';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ElevatedButton(
                                          onPressed: (() {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              eventInfo.child(_primaryKey).set({
                                                "Event Name": _eName.text,
                                                "Event Topic": _eTopic.text,
                                                "Event Chief Guest":
                                                    _eChiefGuest.text,
                                                "Event Special Guest":
                                                    _eSpecialGuest.text,
                                                "Event Host": _eHost.text,
                                                "Event Venue": _eVenue.text,
                                                "Event Date": _eDate.text,
                                                "Event Time": _eTime.text,
                                                "Event Description":
                                                    _eDesc.text,
                                              });
                                            }
                                            Navigator.pop(context);
                                          }),
                                          child: const Text('Edit data'),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                child: const Text(
                                  'Edit this Event',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: (() {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      elevation: 5,
                                      alignment: Alignment.center,
                                      title: const Text(
                                        'Are you sure?',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Material(
                                                color: Colors.red,
                                                child: MaterialButton(
                                                  onPressed: (() {}),
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Material(
                                                color: Colors.green.shade400,
                                                child: MaterialButton(
                                                  onPressed: (() {
                                                    Navigator.pop(context);
                                                  }),
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                child: const Text(
                                  'Delete this Event',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        onPressed: (() {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.9,
                child: EventInfo(),
              );
            },
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
