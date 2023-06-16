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
  ) async {
    for (int i = 0; i < numbers.length; i++) {
      final message = '''
        Event: $eventName
        Date: $eventDate
        Time: $eventTime
        
        Dear ${guestName[i]},
        
        You have been allocated Table ${tableNumber[i]}, Chair ${chairNumber[i]}.
        
        Thank you for attending the event.
      ''';

      await _twilio.sendSMS(
        toNumber: numbers[i],
        messageBody: message,
      );
    }
  }
}
