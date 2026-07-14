import 'dart:math';

class RandomGenerator {
  static int generateRandomIndex(int max) {
    if (max <= 0) throw ArgumentError('Max must be greater than 0');
    return Random().nextInt(max);
  }
}
