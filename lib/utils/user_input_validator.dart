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

  static String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return "Phone number field should not be emtpy";
    }
    if (phoneNumber.length < 10) {
      return "Phone number should contain 10 digits";
    }
    return null;
  }

  static String? valiedateReportDescription(String description) {
    if (description.isEmpty) {
      return "Description field should not be empty";
    }
    return null;
  }
}
