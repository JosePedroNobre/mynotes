import 'package:flutter_test/flutter_test.dart';
import 'package:mynotes/core/encryption_generator.dart';

void main() {
  group('EncryptionGenerator', () {
    const keyString = 'myverysafe256bitkeyforencryption123';

    test('should encrypt and decrypt text correctly', () {
      final key = keyString.substring(0, 32); // key is 32 characters
      final helper = EncryptionGenerator(key);

      const originalText = "Test Encryption";
      final encryptedText = helper.encryptText(originalText);
      final decryptedText = helper.decryptText(encryptedText);

      expect(decryptedText, equals(originalText), reason: 'Decrypted text should match the original');
    });

    test('should produce different encrypted texts for different inputs', () {
      final key = keyString.substring(0, 32); // key is 32 characters
      final helper = EncryptionGenerator(key);

      const text1 = "Hello, World!";
      const text2 = "Flutter is awesome!";

      final encryptedText1 = helper.encryptText(text1);
      final encryptedText2 = helper.encryptText(text2);

      expect(encryptedText1, isNot(equals(encryptedText2)),
          reason: 'Different inputs should produce different encrypted texts');
    });

    test('should throw error for incorrect decryption key', () {
      final correctKey = keyString.substring(0, 32);
      const wrongKey = 'wrongkeywrongkeywrongkeywrongkey';
      final helper = EncryptionGenerator(correctKey);

      const originalText = "This is a secret message";
      final encryptedText = helper.encryptText(originalText);

      final wrongHelper = EncryptionGenerator(wrongKey);

      expect(
        () => wrongHelper.decryptText(encryptedText),
        throwsA(isA<ArgumentError>()),
        reason: 'Decrypting with a wrong key should throw an ArgumentError',
      );
    });
  });
}
