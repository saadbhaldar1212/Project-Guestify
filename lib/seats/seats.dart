import 'package:flutter/material.dart';

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
      body: Form(
        key: _formKey,
        child: SizedBox(
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(200, 17, 150, 207),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          // controller: eventNameController,
                          cursorHeight: 20,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Number of Tables',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter number of Tables';
                            }
                            return null;
                          },
                        ),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        // controller: eventNameController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Number of Chairs around Tables',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter number of Tables';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (() {}),
        child: const Text('Save Data'),
      ),
    );
  }
}
