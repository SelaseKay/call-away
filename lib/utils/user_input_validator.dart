class Validator {
  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return "Username field should not be empty";
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email field should not be empty";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password field should not be emtpy";
    }
    if (password.length <= 6) {
      return "Password should contain more than 6 characters";
    }
    return null;
  }
}

String validateUserInput(String email, String password, String? username) {
  if (email.isEmpty || password.isEmpty || username!.isEmpty) {
    return "Fiels should not be empty";
  }

  if (password.length <= 6) {
    return "Password should have more than 6 characters";
  }

  return "";
}
