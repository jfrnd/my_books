import 'package:flutter_test/flutter_test.dart';

import '../fixtures/response.dart';

void main() {
  group('Equality', () {
    test(
      'two identical book objects should be equal',
      () {
        // act
        final isEqual = bookOne == bookOneCopy;
        // assert
        expect(isEqual, true);
      },
    );
    test(
      'two different book objects should not be equal',
      () {
        // act
        final isNotEqual = bookOne != bookTwo;
        // assert
        expect(isNotEqual, true);
      },
    );
  });
}
