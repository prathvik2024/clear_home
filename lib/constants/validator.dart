class Validator {
  bool isDigit({required String input}) =>
      RegExp(r"^\d+$").hasMatch(input.trim());

  bool isPhone({required String input}) =>
      RegExp(r"^[6-9]\d{9}$").hasMatch(input.trim());

  bool isAlpha({required String input}) =>
      RegExp(r"[a-zA-Z]+$").hasMatch(input.trim());

  bool isAlphaNumeric({required String input}) =>
      RegExp(r"^[a-zA-Z0-9]+$").hasMatch(input.trim());

  bool isEmail({required String input}) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input.trim());

  bool isStrongPassword({required String input}) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(input.trim());
}
