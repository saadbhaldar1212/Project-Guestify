import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TwilioService {
  final _twilio = TwilioFlutter(
    accountSid: dotenv.env['accountSid']!,
    authToken: dotenv.env['authToken']!,
    twilioNumber: dotenv.env['twilioNumber']!,
  );

  Future<void> sendMessages(
    List numbers,
    List guestName,
    List tableNumber,
    List chairNumber,
    String eventName,
    String eventDate,
    String eventTime,
    String eventLocation,
    String collegeName,
  ) async {
    for (int i = 0; i < numbers.length; i++) {
      final message = '''
        Hello ${guestName[i]},

You're invited to our event named $eventName, happening at $eventLocation on $eventDate, $eventTime. Your booked seats are Table:${tableNumber[i]} Chair:${chairNumber[i]}. 

Get ready to have an amazing time! We look forward to seeing you there!

The link is 

Best regards,
$collegeName
      ''';

      await _twilio.sendSMS(
        toNumber: numbers[i],
        messageBody: message,
      );
    }
  }
}
