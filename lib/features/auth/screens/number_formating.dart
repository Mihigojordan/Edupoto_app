import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class NumberFormatting {
  
  /// **Formats & Validates Phone Number**
  String validateAndFormatNumber({required String input, required String countryCode}) {
    // Remove non-numeric characters except "+"
    input = input.replaceAll(RegExp(r'[^\d+]'), ''); 

    // Handle different cases of phone number input
    if (input.startsWith('+')) {
      // Already in international format, do nothing
    } else if (input.startsWith('0')) {
      // Remove leading "0" and add the country code
      input = '$countryCode${input.substring(1)}';
    }else if (input.startsWith('250')) {
      // Remove leading "0" and add the country code
      input = '$countryCode${input.substring(3)}';
    }  else if (!input.startsWith(countryCode)) {
      // If input does not start with the country code, add it
      input = '$countryCode$input';
    }

    try {
      // Parse the phone number
      PhoneNumber phoneNumber = PhoneNumber.parse(input);

      // Validate if the number is a mobile number
      if (!phoneNumber.isValid(type: PhoneNumberType.mobile)) {
        return ''; // Invalid number
      }

      return phoneNumber.international; // Return standardized format
    } catch (e) {
      return ''; // Invalid number
    }
  }
}
