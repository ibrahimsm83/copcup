class Validation {
  static String? fieldValidation(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please enter $field';
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.length < 6) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? usernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    if (value.length > 20) {
      return 'Username must not exceed 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, periods, and underscores';
    }
    return null;
  }

  static String? emailValidation(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password is too weak';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? confirmPasswordValidation(String? value, String password) {
    String? passwordError = passwordValidation(password);
    if (passwordError != null) {
      return passwordError;
    }

    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return "Passwords don't match";
    }
    return null;
  }

  // static String? phoneValidation(String? value) {
  //   if (value!.isEmpty) {
  //     return 'Please enter a phone number';
  //   } else if (value.length < 6) {
  //     return 'Enter a valid phone number';
  //   } else {
  //     return null;
  //   }
  // }

  static String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    RegExp regex = RegExp(r'^\+\d{1,3}\d{10,14}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a phone number starting with +country-code';
    }
    return null;
  }

  static String? timingValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a timing';
    }
    RegExp regex = RegExp(r'^\d+$'); // Only allows digits of any length
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid timing in numbers';
    }
    return null;
  }

  static String? priceValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter item price';
    }
    RegExp regex = RegExp(r'^\d+$'); // Only allows digits of any length
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid price in numbers';
    }
    return null;
  }
}
