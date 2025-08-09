import 'package:intl/intl.dart';

String getMonthName(int monthNumber) {
  DateTime date = DateTime(2024, monthNumber, 1); // Use any year
  return DateFormat.MMM().format(date); // Full month name
}

bool isValidNumber(String input) {
  // Check if the input is empty or not a number
  if (input.isEmpty || double.tryParse(input) == null) {
    return false;
  }

  // Convert input to a number
  double number = double.parse(input);

  // Ensure number is not zero
  if (number == 0) {
    return false;
  }

  // Check if the number has a leading zero (except for decimals like "0.5")
  if (input.length > 1 && input.startsWith('0') && !input.startsWith('0.')) {
    return false;
  }

  return true;
}

bool isValidAge(String input) {
  // Check if the input is empty or not a number
  if (input.isEmpty || int.tryParse(input) == null) {
    return false;
  }

  int age = int.parse(input);

  // Check if the age is greater than 0 and doesn't have a leading zero (except "0" itself)
  if (age > 0 && !(input.length > 1 && input.startsWith('0'))) {
    return true;
  }

  return false;
}