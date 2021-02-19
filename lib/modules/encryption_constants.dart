import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class EncryptionConstants {
  static var encryptionKey = Key.fromUtf8('abcd12345678');
  static var iv = IV.fromLength(16);
}