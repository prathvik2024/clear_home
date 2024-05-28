class Validator {
 static bool isDigit({required String input}) =>
      RegExp(r"^\d+$").hasMatch(input.trim());

 static bool isSingleDigit({required String input}) =>
      RegExp(r"^\d$").hasMatch(input.trim());

 static bool isPhone({required String input}) =>
      RegExp(r"^[6-9]\d{9}$").hasMatch(input.trim());

 static bool isAlpha({required String input}) =>
      RegExp(r"[a-zA-Z]+$").hasMatch(input.trim());

 static bool isAlphaNumeric({required String input}) =>
      RegExp(r"^[a-zA-Z0-9]+$").hasMatch(input.trim());

 static  bool isEmail({required String input}) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input.trim());

 static  bool isStrongPassword({required String input}) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(input.trim());
}
