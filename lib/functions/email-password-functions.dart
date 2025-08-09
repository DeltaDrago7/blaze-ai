
bool isValidEmail(String email) {
  final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
  );
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  final hasUppercase = RegExp(r'[A-Z]');
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  return hasUppercase.hasMatch(password) && hasSpecialChar.hasMatch(password);
}
