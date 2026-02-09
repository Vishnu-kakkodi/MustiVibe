// class Validators {
//   // Phone number validation
//   static String? validatePhoneNumber(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Phone number is required';
//     }

//     final trimmedValue = value.trim();

//     // Check if it contains only digits
//     if (!RegExp(r'^[0-9]+$').hasMatch(trimmedValue)) {
//       return 'Phone number should contain only digits';
//     }

//     // Check length
//     if (trimmedValue.length != 10) {
//       return 'Phone number must be exactly 10 digits';
//     }

//     // Check if it starts with valid Indian mobile prefix (6-9)
//     if (!RegExp(r'^[6-9]').hasMatch(trimmedValue)) {
//       return 'Phone number should start with 6, 7, 8, or 9';
//     }

//     return null; // Valid
//   }

//   // Email validation (if needed in future)
//   static String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email is required';
//     }

//     final emailRegex = RegExp(
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//     );

//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Enter a valid email address';
//     }

//     return null;
//   }

//   // OTP validation
//   static String? validateOtp(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'OTP is required';
//     }

//     final trimmedValue = value.trim();

//     if (!RegExp(r'^[0-9]+$').hasMatch(trimmedValue)) {
//       return 'OTP should contain only digits';
//     }

//     if (trimmedValue.length != 6) {
//       return 'OTP must be 6 digits';
//     }

//     return null;
//   }

//   // Name validation
//   static String? validateName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Name is required';
//     }

//     if (value.trim().length < 2) {
//       return 'Name must be at least 2 characters';
//     }

//     if (value.trim().length > 50) {
//       return 'Name must be less than 50 characters';
//     }

//     return null;
//   }

//   // Generic required field validation
//   static String? validateRequired(String? value, String fieldName) {
//     if (value == null || value.trim().isEmpty) {
//       return '$fieldName is required';
//     }
//     return null;
//   }

//   // Age validation
//   static String? validateAge(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Age is required';
//     }

//     final age = int.tryParse(value.trim());
//     if (age == null) {
//       return 'Enter a valid age';
//     }

//     if (age < 18) {
//       return 'You must be at least 18 years old';
//     }

//     if (age > 100) {
//       return 'Please enter a valid age';
//     }

//     return null;
//   }
// }













class Validators {
  /// Validates Indian mobile phone numbers
  /// Returns null if valid, error message string if invalid
  static String? validatePhoneNumber(String? value) {
    // Check for null or empty
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }

    // Remove any whitespace
    final trimmedValue = value.trim();

    // Check if empty after trimming
    if (trimmedValue.isEmpty) {
      return 'Mobile number is required';
    }

    // Check if it contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(trimmedValue)) {
      return 'Mobile number should contain only digits';
    }

    // Check length - must be exactly 10 digits
    if (trimmedValue.length < 10) {
      return 'Mobile number must be 10 digits';
    }

    if (trimmedValue.length > 10) {
      return 'Mobile number cannot exceed 10 digits';
    }

    // Check if it starts with valid Indian mobile prefix (6-9)
    final firstDigit = trimmedValue[0];
    if (!['6', '7', '8', '9'].contains(firstDigit)) {
      return 'Mobile number must start with 6, 7, 8, or 9';
    }

    // Additional validation: check for obviously invalid patterns
    // All same digits (e.g., 9999999999)
    if (RegExp(r'^(\d)\1{9}$').hasMatch(trimmedValue)) {
      return 'Please enter a valid mobile number';
    }

    // Sequential digits (e.g., 1234567890)
    if (trimmedValue == '1234567890' || trimmedValue == '0123456789') {
      return 'Please enter a valid mobile number';
    }

    return null; // Valid
  }

  /// Validates OTP (6 digits)
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return 'OTP is required';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(trimmedValue)) {
      return 'OTP should contain only digits';
    }

    if (trimmedValue.length < 6) {
      return 'OTP must be 6 digits';
    }

    if (trimmedValue.length > 6) {
      return 'OTP cannot exceed 6 digits';
    }

    return null;
  }

  /// Validates email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates name (2-50 characters)
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return '$fieldName is required';
    }

    if (trimmedValue.length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (trimmedValue.length > 50) {
      return '$fieldName must be less than 50 characters';
    }

    // Check if name contains only letters and spaces
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(trimmedValue)) {
      return '$fieldName should contain only letters';
    }

    return null;
  }

  /// Validates age (18-100)
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return 'Age is required';
    }

    final age = int.tryParse(trimmedValue);
    
    if (age == null) {
      return 'Please enter a valid age';
    }

    if (age < 18) {
      return 'You must be at least 18 years old';
    }

    if (age > 100) {
      return 'Please enter a valid age';
    }

    return null;
  }

  /// Generic required field validation
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  /// Validates password (minimum 6 characters)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Validates confirm password
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}