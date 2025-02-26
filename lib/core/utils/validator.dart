class Validator {
  static String? validateField(String? value, String fieldType,
      {String? password}) {
    if (value == null || value.trim().isEmpty) {
      return _getEmptyMessage(fieldType);
    }

    switch (fieldType) {
      case 'name':
        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          return 'Name should contain only letters';
        }
        break;

      case 'email':
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Enter a valid email';
        }
        break;

      case 'password':
      case 'new password':
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'^(?=.[A-Z])(?=.\d).+$').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter and one number';
        }
        break;
      case 'old password':
        if (password == null || value != password) {
          return 'Passwords is not correct';
        }
        break;
      case 'confirmPassword':
        if (password == null || value != password) {
          return 'Passwords do not match';
        }
        break;

      case 'phone':
        if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
          return 'Enter a valid 11-digit phone number';
        }
        break;
    }

    return null;
  }

  static String _getEmptyMessage(String fieldType) {
    return 'Please enter your $fieldType';
  }
}
