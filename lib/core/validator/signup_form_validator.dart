class SignupFormvalidator {
  String? validateEmail(String email) {
    if (!email.contains("@")) {
      return "Invalid Email";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 8) {
      return "Password must have 8 charecters";
    }
    return null;
  }

  String? validateConformPassword(String password, String conformPassword) {
    if (password.contains(conformPassword)) {
      return null;
    }
    if (password != conformPassword) {
      return "Passwords not match";
    }
  }
}
