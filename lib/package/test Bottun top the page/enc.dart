import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:sinbad_lunch/components/Encryptions/encryptionss.dart';

void main() {
  final plainText = 'dXbKBIvfqdHWu6CoWGsYog==';//'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromLength(32);
  final iv = IV.fromLength(8);
  final encrypter = Encrypter(Salsa20(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print('\n sami \n');
  print(encrypted.base64); // CR+IAWBEx3sA/dLkkFM/orYr9KftrGa7lIFSAAmVPbKIOLDOzGwEi9ohstDBqDLIaXMEeulwXQ==
//jsonDecode
  print(Encryption.instance.decrypt( "H1hHRSLfLOirj2v63xMdGPi67WIKDMDHvXmd4DN9D+i3kq/fkXpS2LCJevCsI+d7" ));
  print(toPrecision(55));
}
double toPrecision(double n) => double.parse(n.toStringAsFixed(2));