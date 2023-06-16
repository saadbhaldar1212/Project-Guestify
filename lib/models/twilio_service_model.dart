import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  final _twilio = TwilioFlutter(
      accountSid: 'AC3bc0718a7e906eb524e630d47ea1a320',
      authToken: '20d2d7e90716abf34b5a0f9010c13d53',
      twilioNumber: '+13613061193');

  Future<void> sendMessages(
    List numbers,
    List guestName,
    List tableNumber,
    List chairNumber,
    String eventName,
    String eventDate,
    String eventTime,
    String eventLocation,
    // String collegeName,
  ) async {
    for (int i = 0; i < numbers.length; i++) {
      final message = '''
        Hello ${guestName[i]},

You're invited to our event named $eventName, happening at $eventLocation on $eventDate, $eventTime. Your booked seats are ${tableNumber[i]}-${chairNumber[i]}. 

Get ready to have an amazing time! We look forward to seeing you there!

Best regards,
Indira College of Commerce and Science
      ''';

      await _twilio.sendSMS(
        toNumber: numbers[i],
        messageBody: message,
      );
    }
  }
}
