
// THIS IS THE ENCRYPTION CONSTANTS

import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class EncryptionConstants {
  static var encryptionKey = Key.fromUtf8('abcd1234567812345678912345678912');
  static var iv = IV.fromLength(16);
}