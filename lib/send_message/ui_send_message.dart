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

  @override
  void initState() {
    super.initState();
    templateMessage.text = 'Hello, You\'re been invited for our event';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            const Text(
              'Message Template',
              style: TextStyle(
                color: Colors.black,
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
                      ),
                      minLines: 5,
                      maxLines: 7,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
