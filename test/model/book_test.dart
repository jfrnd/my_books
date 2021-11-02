import 'package:flutter_test/flutter_test.dart';

import '../fixtures/response.dart';

void main() {
  group('Equality', () {
    test(
      'two identical book objects should be equal',
      () {
        // act
        final isEqual = book_one == book_one_copy;
        // assert
        expect(isEqual, true);
      },
    );
    test(
      'two different book objects should not be equal',
      () {
        // act
        final isNotEqual = book_one != book_two;
        // assert
        expect(isNotEqual, true);
      },
    );
  });
}
