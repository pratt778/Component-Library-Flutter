import 'package:flutter_test/flutter_test.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

void main() {
  group('AppValidators', () {
    test('required validator', () {
      expect(AppValidators.required(null), isNotNull);
      expect(AppValidators.required(''), isNotNull);
      expect(AppValidators.required('   '), isNotNull);
      expect(AppValidators.required('hello'), isNull);
    });

    test('email validator', () {
      expect(AppValidators.email(null), isNull); // Empty allowed unless required
      expect(AppValidators.email(''), isNull);
      expect(AppValidators.email('invalid'), isNotNull);
      expect(AppValidators.email('user@test.com'), isNull);
    });

    test('requiredEmail validator', () {
      expect(AppValidators.requiredEmail(''), isNotNull);
      expect(AppValidators.requiredEmail('invalid'), isNotNull);
      expect(AppValidators.requiredEmail('user@test.com'), isNull);
    });

    test('phone validator & phoneError', () {
      expect(isValidPhone('9841234567'), isTrue);
      expect(isValidPhone('12345'), isFalse);
      expect(phoneError('9841234567'), isNull);
      expect(phoneError('12345'), isNotNull);
      expect(AppValidators.phone('+1 (555) 019-2834'), isNull);
    });

    test('numeric validator', () {
      expect(AppValidators.numeric('12345'), isNull);
      expect(AppValidators.numeric('12a45'), isNotNull);
    });

    test('minLength and maxLength', () {
      expect(AppValidators.minLength('abc', 5), isNotNull);
      expect(AppValidators.minLength('abcde', 5), isNull);
      expect(AppValidators.maxLength('abcdef', 5), isNotNull);
      expect(AppValidators.maxLength('abc', 5), isNull);
    });

    test('compose combines multiple validators', () {
      final validator = AppValidators.compose([
        AppValidators.required,
        AppValidators.email,
      ]);

      expect(validator(''), isNotNull);
      expect(validator('invalid'), isNotNull);
      expect(validator('test@example.com'), isNull);
    });
  });

  group('Debouncer', () {
    test('delays invocation until duration passes', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 50));
      var count = 0;

      debouncer.run(() => count++);
      debouncer.run(() => count++);
      debouncer.run(() => count++);

      expect(count, 0);
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(count, 1);
    });
  });
}
