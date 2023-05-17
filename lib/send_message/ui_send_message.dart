import 'package:flutter/material.dart';

import '../utils/signout_button/signout_button.dart';

class UISendMessage extends StatefulWidget {
  const UISendMessage({super.key});

  @override
  State<UISendMessage> createState() => _UISendMessageState();
}

class _UISendMessageState extends State<UISendMessage> {
  final _fKey = GlobalKey<FormState>();
  final templateMessage = TextEditingController();
  final to = TextEditingController();

  final defaultTemplate =
      'Hello <NAME>, You\'re been invited for our event named <EVENT-NAME>, at <LOCATION>, <DATE & TIME>. You\re booked seats is <TABLE NUMBER>-<CHAIR NUMBER>';

  @override
  void initState() {
    super.initState();
    templateMessage.text = defaultTemplate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 219, 233),
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: const [SignOutButton()],
        title: const Text(
          'Send Message',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Message Template',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            Form(
              key: _fKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: templateMessage,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      minLines: 5,
                      maxLines: 7,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.message,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Message Template';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Text(
                    'To:',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: to,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorHeight: 20,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      enabled: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Message Template';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 150,
                  child: Card(
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 150,
                  child: Card(
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 150,
                  child: Card(
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 150,
                  child: Card(
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
