import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionGenerator {
  final encrypt.Key key;
  final encrypt.IV iv;
  final encrypt.Encrypter encrypter;

  EncryptionGenerator(String keyString)
      : key = encrypt.Key.fromUtf8(keyString),
        iv = encrypt.IV.fromLength(16), // IV must be consistent
        encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(keyString),
            mode: encrypt.AESMode.cbc)); // Ensure mode and padding are consistent

  String encryptText(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptText(String encryptedText) {
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
