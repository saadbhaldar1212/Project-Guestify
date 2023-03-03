import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

class Seats extends StatefulWidget {
  const Seats({super.key});

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  final textFormField = TextEditingController();
  final _formKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Seats booking',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Enter the number of tables',
                        fillColor: Colors.amber),
                    controller: textFormField,
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        String inputData = textFormField.text;
                        print(inputData);
                        int numData = int.parse(inputData);
                        print(numData);
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
              ),
            ),
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
    );
  }
}
