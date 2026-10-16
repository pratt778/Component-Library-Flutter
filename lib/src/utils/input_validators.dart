/// Input and form field validators shared by inputs and submit gates.
library;

/// `'Required'` when [value] is whitespace; `null` otherwise.
String? requiredError(String value) => value.trim().isEmpty ? 'Required' : null;

/// Nepal-format phone: exactly 10 digits. `'Required'` when empty (and
/// [required] is true), `'10 digits required'` for any partial / non-digit
/// entry. `null` when valid.
String? phoneError(String value, {bool required = true}) {
  final t = value.trim();
  if (t.isEmpty) return required ? 'Required' : null;
  if (!RegExp(r'^\d{10}$').hasMatch(t)) return '10 digits required';
  return null;
}

/// True when the phone number is exactly 10 digits. Mirrors [phoneError]
/// for use in submit-gate logic.
bool isValidPhone(String value) => RegExp(r'^\d{10}$').hasMatch(value.trim());

/// Comprehensive form field validators returning an error [String] when
/// invalid or `null` when valid (standard Flutter FormFieldValidator contract).
class AppValidators {
  AppValidators._();

  static final RegExp _email =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp _url = RegExp(
    r'^(https?://)?([\w-]+\.)+[\w-]{2,}(/\S*)?$',
    caseSensitive: false,
  );
  static final RegExp _phone = RegExp(r'^[+()\-.\s0-9]{7,15}$');
  static final RegExp _numeric = RegExp(r'^[0-9]+$');

  /// Fails when the value is empty or null.
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Validates an email address. Empty values are considered valid so [required]
  /// can independently decide if it is mandatory.
  static String? email(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return _email.hasMatch(value.trim())
        ? null
        : (message ?? 'Enter a valid email address');
  }

  /// Requires the field to be non-empty and a valid email address.
  static String? requiredEmail(
    String? value, {
    String? message,
    String? requiredMessage,
  }) {
    final reqError = required(value, message: requiredMessage);
    if (reqError != null) return reqError;
    return email(value, message: message);
  }

  /// Validates a URL (with or without protocol).
  static String? url(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return _url.hasMatch(value.trim())
        ? null
        : (message ?? 'Enter a valid URL');
  }

  /// Validates a general phone number.
  static String? phone(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return _phone.hasMatch(value.trim())
        ? null
        : (message ?? 'Enter a valid phone number');
  }

  /// Validates numeric digits only.
  static String? numeric(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return _numeric.hasMatch(value.trim())
        ? null
        : (message ?? 'Enter numbers only');
  }

  /// Validates minimum string length.
  static String? minLength(String? value, int min, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim().length >= min
        ? null
        : (message ?? 'Must be at least $min characters');
  }

  /// Validates maximum string length.
  static String? maxLength(String? value, int max, {String? message}) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim().length <= max
        ? null
        : (message ?? 'Must not exceed $max characters');
  }

  /// Composes multiple validators into one that runs sequentially.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}

/// Backward compatibility alias for [AppValidators].
typedef TextValidators = AppValidators;
