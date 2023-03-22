import 'dart:math';

int getRandomInt(int length) {
  Random random = new Random();
  return random
      .nextInt(length); // Generates a random integer between 0-100 (inclusive)
}
