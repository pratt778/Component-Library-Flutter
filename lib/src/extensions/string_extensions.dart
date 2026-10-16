/// Helpful string manipulation and validation extensions.
extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word.
  String titleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Removes all whitespace from the string.
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Checks if the string matches a standard email format.
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Checks if the string is a valid HTTP/HTTPS URL.
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/[^\s$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(this);
  }

  /// Truncates the string to a specified length with an optional ellipsis.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    if (maxLength <= ellipsis.length) return substring(0, maxLength);
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Reverses the characters in the string.
  String reversed() {
    return split('').reversed.join('');
  }

  /// Checks if the string contains only alphabetic characters.
  bool get isAlphabetic {
    final alphaRegex = RegExp(r'^[a-zA-Z]+$');
    return alphaRegex.hasMatch(this);
  }

  /// Checks if the string contains only numeric digits.
  bool get isNumeric {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(this);
  }

  /// Converts the string to camelCase.
  String toCamelCase() {
    if (isEmpty) return this;
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((word) => word.capitalize()).join();
  }

  /// Converts the string to snake_case.
  String toSnakeCase() {
    return replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
  }

  /// Converts the string to kebab-case.
  String toKebabCase() {
    return replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-').toLowerCase();
  }

  /// Pluralizes a word if [count] is not 1.
  String pluralize(num count, {String? plural}) {
    if (count == 1) return this;
    return plural ?? '${this}s';
  }
}
