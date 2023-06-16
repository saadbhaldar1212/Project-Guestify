// ignore_for_file: non_constant_identifier_names

/*

Update - convert the statically typed template message into variable so it can be used
          to edit by suer in fututre update

*/

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/send_message/final_step_for_sending_message.dart';
import 'package:guestify/utils/utility.dart';

import '../utils/progress_stepper/custom_progress_indicator.dart';
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

  Color _color1 = const Color.fromRGBO(0, 77, 120, 1.000);
  Color _color2 = Colors.white;
  Color _color3 = Colors.white;
  Color _color4 = Colors.white;

  Color _text1 = Colors.black;
  Color _text2 = Colors.black;
  Color _text3 = Colors.black;
  Color _text4 = Colors.black;

  String college_name = 'Indira College of Commerce and Science, Wakad';

  @override
  void initState() {
    super.initState();
    templateMessage.text = '''Hello [Name],

You're invited to our event named [Event Name], happening at [Location] on [Date & Time]. We're excited to have you join us!

Your booked seats are [Table Number]-[Chair Number]. Get ready to have an amazing time!

We look forward to seeing you there!

Best regards,
$college_name
''';
    _text1 = Colors.white;
  }

  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final for_message = db.child('guest/');
    const template = 'template';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 219, 233),
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: CustomStepProgressIndicator(
            //     totalSteps: 2,
            //     currentStep: 1,
            //     size: 40,
            //     selectedColor: const Color.fromRGBO(0, 77, 120, 1.000),
            //     unselectedColor: Colors.white,
            //     unselectedSize: 30,
            //     customStep: (p0, p1, p2) =>
            //         p1 == const Color.fromRGBO(0, 77, 120, 1.000)
            //             ? Container(
            //                 color: p1,
            //                 child: const Icon(
            //                   Icons.check,
            //                   color: Colors.white,
            //                 ),
            //               )
            //             : Container(
            //                 color: p1,
            //                 child: const Icon(
            //                   Icons.remove,
            //                 ),
            //               ),
            //   ),
            // ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Select a Template',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 450,
                      child: Ink(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _color1 = const Color.fromRGBO(0, 77, 120, 1.000);
                              _color2 = Colors.white;
                              _color3 = Colors.white;
                              _color4 = Colors.white;

                              _text1 = Colors.white;
                              _text2 = Colors.black;
                              _text3 = Colors.black;
                              _text4 = Colors.black;

                              templateMessage.text = '''Hello [Name],

You're invited to our event named [Event Name], happening at [Location] on [Date & Time]. We're excited to have you join us!

Your booked seats are [Table Number]-[Chair Number]. Get ready to have an amazing time!

We look forward to seeing you there!

Best regards,
$college_name
''';
                            });
                          },
                          child: Card(
                            color: _color1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(
                                child: Text(
                                  '''Hello [Name],

You're invited to our event named [Event Name], happening at [Location] on [Date & Time]. We're excited to have you join us!

Your booked seats are [Table Number]-[Chair Number]. Get ready to have an amazing time!

We look forward to seeing you there!

Best regards,
$college_name
''',
                                  style: TextStyle(
                                    color: _text1,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 450,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _color1 = Colors.white;
                            _color2 = const Color.fromRGBO(0, 77, 120, 1.000);
                            _color3 = Colors.white;
                            _color4 = Colors.white;

                            _text1 = Colors.black;
                            _text2 = Colors.white;
                            _text3 = Colors.black;
                            _text4 = Colors.black;

                            templateMessage.text = '''
Hey [Name],

We're thrilled to invite you to our upcoming event, [Event Name], taking place at [Location] on [Date & Time].

We've reserved seats specifically for you, and you'll be sitting at [Table Number]-[Chair Number]. So make yourself comfortable and get ready for a memorable experience!

Feel free to bring along friends or family members to share in the fun. We promise an evening filled with entertainment, laughter, and great company.

We can't wait to have you join us!

Warm regards,
$college_name''';
                          });
                        },
                        child: Card(
                          color: _color2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(
                              child: Text(
                                '''
Hey [Name],

We're thrilled to invite you to our upcoming event, [Event Name], taking place at [Location] on [Date & Time].

We've reserved seats specifically for you, and you'll be sitting at [Table Number]-[Chair Number]. So make yourself comfortable and get ready for a memorable experience!

Feel free to bring along friends or family members to share in the fun. We promise an evening filled with entertainment, laughter, and great company.

We can't wait to have you join us!

Warm regards,
$college_name''',
                                style: TextStyle(
                                  color: _text2,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 450,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _color1 = Colors.white;
                        _color2 = Colors.white;
                        _color3 = const Color.fromRGBO(0, 77, 120, 1.000);
                        _color4 = Colors.white;

                        _text1 = Colors.black;
                        _text2 = Colors.black;
                        _text3 = Colors.white;
                        _text4 = Colors.black;

                        templateMessage.text = '''Hey [Name]!

You're cordially invited to be a part of our spectacular event, [Event Name], happening at [Location] on [Date & Time].

Guess what? We've secured a fantastic spot for you! Your exclusive seat awaits you at [Table Number]-[Chair Number]. Get ready for an evening of excitement and enjoyment!

Make sure to mark your calendar and bring your enthusiasm. This event is going to be truly unforgettable, and we wouldn't want you to miss out.

Looking forward to seeing you there!

Best regards,
$college_name''';
                      });
                    },
                    child: Card(
                      color: _color3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Text(
                            '''Hey [Name]!

You're cordially invited to be a part of our spectacular event, [Event Name], happening at [Location] on [Date & Time].

Guess what? We've secured a fantastic spot for you! Your exclusive seat awaits you at [Table Number]-[Chair Number]. Get ready for an evening of excitement and enjoyment!

Make sure to mark your calendar and bring your enthusiasm. This event is going to be truly unforgettable, and we wouldn't want you to miss out.

Looking forward to seeing you there!

Best regards,
$college_name''',
                            style: TextStyle(
                              color: _text3,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 450,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _color1 = Colors.white;
                        _color2 = Colors.white;
                        _color3 = Colors.white;
                        _color4 = const Color.fromRGBO(0, 77, 120, 1.000);

                        _text1 = Colors.black;
                        _text2 = Colors.black;
                        _text3 = Colors.black;
                        _text4 = Colors.white;
                        templateMessage.text = '''Hey [Name]!

We're thrilled to extend a special invitation to you for our upcoming event, [Event Name], at [Location] on [Date & Time].

Guess what? You're in for a treat! We've already reserved your spot, and you'll be seated at [Table Number]-[Chair Number]. Get ready to immerse yourself in an incredible experience!

Come prepared to have a great time with friends, indulge in delicious treats, and create lasting memories. We can't wait to celebrate together!

Save the date, and we'll see you soon!

Warmest regards,
$college_name''';
                      });
                    },
                    child: Card(
                      color: _color4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Text(
                            '''Hey [Name]!

We're thrilled to extend a special invitation to you for our upcoming event, [Event Name], at [Location] on [Date & Time].

Guess what? You're in for a treat! We've already reserved your spot, and you'll be seated at [Table Number]-[Chair Number]. Get ready to immerse yourself in an incredible experience!

Come prepared to have a great time with friends, indulge in delicious treats, and create lasting memories. We can't wait to celebrate together!

Save the date, and we'll see you soon!

Warmest regards,
$college_name''',
                            style: TextStyle(
                              color: _text4,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Message',
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
                      enabled: false,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      minLines: 5,
                      maxLines: 50,
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
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: (() {
                        if (_fKey.currentState!.validate()) {
                          for_message.child(template).update(
                              {'Template': templateMessage.text}).then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SendMessageUsingTwilio(),
                              ),
                            );
                            Utils().toastMessage('Template Set Successfully');
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        }
                      }),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
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
