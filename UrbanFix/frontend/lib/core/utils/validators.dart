class Validators {
  
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$",
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Please enter a valid email";
    }

    return null;
  }

  // ===== Password Validator =====
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }


  static String? validateConfirmPassword(
      String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }


  static String? validateRequired(
      String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    return null;
  }

 
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    if (value.length < 10) {
      return "Enter a valid phone number";
    }

    return null;
  }
}
