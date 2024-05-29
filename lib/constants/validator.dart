enum ValidationType { isDigit, isPhone, isSingleDigit, isAlpha, isAlphaNumeric, isEmail, isStrongPassword }

class Validator {
  static bool isDigit({required String input}) => RegExp(r"^\d+$").hasMatch(input.trim());

  static bool isSingleDigit({required String input}) => RegExp(r"^\d$").hasMatch(input.trim());

  static bool isPhone({required String input}) => RegExp(r"^[6-9]\d{9}$").hasMatch(input.trim());

  static bool isAlpha({required String input}) => RegExp(r"[a-zA-Z]+$").hasMatch(input.trim());

  static bool isAlphaNumeric({required String input}) => RegExp(r"^[a-zA-Z0-9]+$").hasMatch(input.trim());

  static bool isEmail({required String input}) =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input.trim());

  static bool isStrongPassword({required String input}) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(input.trim());

  static String? validate({required String? input, required ValidationType type, String? errorMsg}) {
    if (ValidationType.isDigit == type && !isDigit(input: input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid digit!";
    } else if (ValidationType.isSingleDigit == type && !isSingleDigit(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid single digit!";
    } else if (ValidationType.isPhone == type && !isPhone(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid phone number!";
    } else if (ValidationType.isAlpha == type && !isAlpha(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid alphabets!";
    } else if (ValidationType.isAlphaNumeric == type && !isAlphaNumeric(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid alpha numeric value!";
    } else if (ValidationType.isEmail == type && !isEmail(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter valid email!";
    } else if (ValidationType.isStrongPassword == type && !isStrongPassword(input:input?.trim() ?? "")) {
      return errorMsg ?? "Please enter strong password!";
    } else
      return null;
  }
}
