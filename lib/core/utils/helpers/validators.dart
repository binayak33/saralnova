// import 'dart:developer';

// import 'package:get/get.dart';

// class Validators {
//   static String? checkFieldEmpty(String? fieldContent) {
//     fieldContent!.trim();
//     if (fieldContent.isEmpty) {
//       return 'This field is required';
//     }
//     return null;
//   }

//   static String? checkPhoneField(String? fieldContent) {
//     fieldContent!.trim();
//     if (fieldContent.isEmpty) {
//       return 'This field is required';
//     } else if (!(fieldContent.isNumericOnly && fieldContent.length == 10)) {
//       return 'Invalid phone number';
//     }

//     return null;
//   }

//   static String? checkPasswordField(String? fieldContent) {
//     fieldContent!.trim();
//     if (fieldContent.isEmpty) {
//       return 'This field is required';
//     } else if (fieldContent.length < 8) {
//       return 'The password should be at least 8 digits';
//     }

//     return null;
//   }

//   static String? checkConfirmPassword(String? password, String? fieldContent) {
//     var checkPassword = checkPasswordField(fieldContent);
//     if (checkPassword != null) {
//       return checkPassword;
//     }

//     if (password != fieldContent!) {
//       log("The passwords are  $password ====> $fieldContent");
//       return "Password does not match";
//     }
//     return null;
//   }

//   static String? checkEmailField(String? fieldContent) {
//     fieldContent!.trim();
//     if (fieldContent.isEmpty) {
//       return 'This field is required';
//     } else if (!GetUtils.isEmail(fieldContent.trim())) {
//       return 'Invalid email address';
//     }
//     return null;
//   }

//   static String? checkOptionalEmailField(String? fieldContent) {
//     fieldContent!.trim();
//     if ((fieldContent.isNotEmpty) && !GetUtils.isEmail(fieldContent)) {
//       return 'Invalid email address';
//     }
//     return null;
//   }

//   static String? checkPinField(String? fieldContent) {
//     fieldContent!.trim();
//     if (fieldContent.isEmpty) {
//       return 'This field is required';
//     } else if (!(fieldContent.isNumericOnly && fieldContent.length == 5)) {
//       return 'Invalid OTP';
//     }
//     return null;
//   }
// }


class Validator {
  static String? validateMobile(String value) {
    const pattern = r'(?:\+977[- ])?\d{2}-?\d{7,8}';
    final regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must be of 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  static String? validatePassword(String value) {
    // const pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // const pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // final regExp = RegExp(pattern);
    // const pattern = r'(^[a-z ]*$)';
    // final regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Password is required";
    }

    // else if (!regExp.hasMatch(value)) {
    //   return "Password must have at least 8 characters,an uppercase, a special symbol and a number";
    // }
  }

  static String? validateName(String value) {
    const pattern = r'(^[a-zA-Z ]*$)';
    final regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String? validateNumber(String value) {
    const pattern = r'^[0-9]+$';
    final regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Value must be [0-9]";
    }
    return null;
  }

  static String? validatePasswordLength(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 5) {
      return "Password must be longer than 5 characters";
    }
    return null;
  }

  static String? validateEmpty(String value) {
    if (value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? validateEmail(String value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Email is required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid email";
    } else {
      return null;
    }
  }
}
