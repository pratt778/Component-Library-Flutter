import 'package:flutter_test/flutter_test.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

void main() {
  group('DateTimeX extensions', () {
    test('isToday, isYesterday, isTomorrow', () {
      final now = DateTime.now();
      expect(now.isToday, isTrue);
      expect(now.isYesterday, isFalse);
      expect(now.isTomorrow, isFalse);

      final yesterday = now.subtract(const Duration(days: 1));
      expect(yesterday.isYesterday, isTrue);

      final tomorrow = now.add(const Duration(days: 1));
      expect(tomorrow.isTomorrow, isTrue);
    });

    test('addMonths and addDays', () {
      final date = DateTime(2025, 1, 15);
      expect(date.addMonths(1), DateTime(2025, 2, 15));
      expect(date.addDays(5), DateTime(2025, 1, 20));
    });

    test('startOfDay and endOfDay', () {
      final date = DateTime(2025, 5, 10, 14, 30);
      expect(date.startOfDay, DateTime(2025, 5, 10, 0, 0, 0));
      expect(date.endOfDay, DateTime(2025, 5, 10, 23, 59, 59, 999));
    });
  });

  group('NumExtensions', () {
    test('formatWithCommas', () {
      expect(1000.formatWithCommas(), '1,000');
      expect(1000000.formatWithCommas(), '1,000,000');
      expect(500.formatWithCommas(), '500');
    });

    test('roundTo and toPercentage', () {
      expect(3.14159.roundTo(2), 3.14);
      expect(0.75.toPercentage(0), '75%');
    });

    test('isBetween and clamp', () {
      expect(10.isBetween(5, 15), isTrue);
      expect(20.isBetween(5, 15), isFalse);
    });
  });

  group('StringExtensions', () {
    test('capitalize and titleCase', () {
      expect('hello'.capitalize(), 'Hello');
      expect('hello world'.titleCase(), 'Hello World');
    });

    test('removeWhitespace', () {
      expect('  foo   bar  '.removeWhitespace(), 'foobar');
    });

    test('isValidEmail', () {
      expect('test@example.com'.isValidEmail, isTrue);
      expect('invalid-email'.isValidEmail, isFalse);
    });

    test('isValidUrl', () {
      expect('https://flutter.dev'.isValidUrl, isTrue);
      expect('not-a-url'.isValidUrl, isFalse);
    });

    test('truncate', () {
      expect('Hello World'.truncate(8), 'Hello...');
      expect('Hello'.truncate(10), 'Hello');
    });

    test('toCamelCase and toSnakeCase', () {
      expect('hello_world'.toCamelCase(), 'helloWorld');
      expect('helloWorld'.toSnakeCase(), 'hello_world');
    });
  });
}
