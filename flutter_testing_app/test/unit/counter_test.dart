import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/models/counter.dart';

void main() {
  test('Counter value should increment', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });

  group('Counter Unit Test', () {
    test("value should start at zero", () {
      final counter = Counter();
      expect(counter.value, 0);
    });

    test("value should increment", () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
  });
}