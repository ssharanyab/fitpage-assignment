// Import the utility class
import 'package:fitpage_assignment/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyUtils.getVariable', () {
    test('returns value for type "value"', () {
      final data = {
        'variable': {
          '\$test': {
            'type': 'value',
            'values': [42],
          },
        },
      };
      expect(Utils().getVariable(data, 'test'), '42');
    });
  });
}
