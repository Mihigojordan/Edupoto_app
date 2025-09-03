
String normalizeRwandaPhoneNumber(String inputNumber, {bool throwOnInvalid = false}) {
  try {
    String digitsOnly = inputNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Handle empty/short numbers
    if (digitsOnly.isEmpty) return '250';
    if (digitsOnly == '0') return '250';

    // Remove prefixes
    if (digitsOnly.startsWith('0')) {
      digitsOnly = digitsOnly.substring(1);
    } else if (digitsOnly.startsWith('250')) {
      digitsOnly = digitsOnly.substring(3);
    }

    // Validate remaining digits
    if (digitsOnly.length != 9 || !digitsOnly.startsWith('7') || !RegExp(r'^[0-9]+$').hasMatch(digitsOnly)) {
      if (throwOnInvalid) {
        throw FormatException('Invalid Rwanda phone number: $inputNumber');
      }
      return '250$digitsOnly'; // Return as-is but with country code
    }

    return '250$digitsOnly';
  } catch (e) {
    if (throwOnInvalid) rethrow;
    return '250';
  }
}