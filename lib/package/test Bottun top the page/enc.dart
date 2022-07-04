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
  print(jsonDecode(Encryption.instance.decrypt("iB0HrPwVhy0+n2bB1pG2ZfoIn4R9qDWcxFunOXN7K4tyOkcNKzW080CHKUN+/f9sY5+29zFJzo9JzdMeSreDHDEOCxkTb83o8cLvhAd2AHCN3Ma4L1hsKdg/tL785AVIe8lDyp58D84diLlGQadm0HFglvopNcOa0r9LYy0UrLBiC0jYayZuH8qHp1TFFvXhgIHBxbnaelz1qAz/3sKg0A==")));
}
