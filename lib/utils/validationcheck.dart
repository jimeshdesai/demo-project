import 'package:demo-project/utils/constants.dart';

class ValidationCheck {
  static String? validateFirstName(value, valueEmpty) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    return null;
  }

  static String? validateLastName(value, valueEmpty) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, regionCode, context) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    try {
      final phoneUtil = PhoneNumberUtil.instance;
      final phoneNumber = phoneUtil.parse(value, regionCode);
      final isValid = phoneUtil.isValidNumber(phoneNumber);

      if (!isValid) {
        return "Incorrect Phone number";
      }
      return null;
    } catch (e) {
      return 'Invalid Phone number $regionCode';
    }
  }

  static String? validateMobileNumber(value, valueEmpty) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    return null;
  }

  static String? validatePassword(
      value, String? valueEmpty, String? validatePass) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    if (value.length < Constants.passwordLen) {
      return validatePass;
    }
    return null;
  }

  static String? validateEmail(
      String? value, String? valueEmpty, String? validateEmail) {
    if (value == null || value.isEmpty) {
      return valueEmpty;
    }

    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return validateEmail;
    }

    return null; // If everything is valid, return null
  }

  static String? validateLoginPassword(
    value,
    String? valueEmpty,
  ) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    return null;
  }

  static String? validateTemporaryPassword(
      value, String? valueEmpty, validateTPass) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    if (value.length < Constants.passwordLen) {
      return validateTPass;
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? confirmPassword,
      String? password,
      String? valueEmpty,
      String? validateCPassLen,
      String? validateCPass) {
    if (confirmPassword!.isEmpty) {
      return valueEmpty;
    }
    if (confirmPassword.length < Constants.passwordLen) {
      return validateCPassLen;
    }
    if (confirmPassword != password) {
      return validateCPass;
    }
    return null;
  }

  static String? validateComment(value, valueEmpty) {
    if (value!.isEmpty) {
      return valueEmpty;
    }
    return null;
  }
}
