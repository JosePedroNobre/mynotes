import 'dart:math';

/// This is here because I was working with mocked data, so this was a way to generate id's for the mocked repository.
String generateUniqueId() {
  final random = Random();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final randomValue = random.nextInt(100000);
  return '$timestamp$randomValue';
}
