import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

class Seats extends StatefulWidget {
  const Seats({super.key});

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  final textFormField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: const Text(
          'Seats booking',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Material(
            //   shape: const CircleBorder(
            //     side: BorderSide(
            //       color: Color.fromARGB(255, 17, 150, 207),
            //     ),
            //   ),
            //   color: Colors.transparent,
            //   child: MaterialButton(
            //     onPressed: (() {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) => EventInfo(),
            //       );
            //     }),
            //     height: 65,
            //     minWidth: 65,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 17, 150, 207),
          onPressed: (() {
            showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: false,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      actions: [
                        IconButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 15, right: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'No. of Tables',
                                    ),
                                    controller: textFormField,
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    persistentFooterButtons: [
                      ElevatedButton(
                        onPressed: (() {
                          setState(() {
                            String inputData = textFormField.text;
                            print(inputData.runtimeType);
                            int numData = int.parse(inputData);
                            print(numData.runtimeType);
                            // Center(
                            //   child: Wrap(
                            //     direction: Axis.vertical,
                            //     children: List.generate(
                            //       numData,
                            //       (index) => Material(
                            //         shape: const CircleBorder(
                            //           side: BorderSide(
                            //             color: Color.fromARGB(255, 17, 150, 207),
                            //           ),
                            //         ),
                            //         color: Colors.transparent,
                            //         child: MaterialButton(
                            //           onPressed: (() {
                            //             showModalBottomSheet(
                            //               context: context,
                            //               builder: (context) => EventInfo(),
                            //             );
                            //           }),
                            //           height: 20,
                            //           minWidth: 20,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // );
                            Center(
                              child: Text('$numData'),
                            );
                          });
                        }),
                        child: const Text('Submit'),
                      ),
                    ],
                    persistentFooterAlignment: AlignmentDirectional.center,
                  );
                });
          }),
          child: const Icon(Icons.add)),
    );
  }
}
