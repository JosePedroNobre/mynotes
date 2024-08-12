import 'dart:math';

String generateUniqueId() {
  final random = Random();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final randomValue = random.nextInt(100000); // Generate a random number
  return '$timestamp$randomValue';
}
