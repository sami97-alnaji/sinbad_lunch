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
  print(jsonDecode(Encryption.instance.decrypt( "0LKrPAhMZ0VfPc7q/DR08vEbIZDxnd/tfklF/P4/9t+rKYUK4w+bfcLVUN0B1DRzK9FyDLPP17iV4ioVBr/3WNbkvgh6XtvWWZ5NtE9baxZgmpIdOaHCHmORM2/awIkotbaOA5+CAwcHohrEKQUnbpxCBaD9QTQx3U6acea3SK9XmHxyxodM+ObyHoSIctgGfNIH0A+OY1cr89kZcV21+LmFP3kDhGBtZsdvSVU0fxsQnRJqejIL+E3nZ1b4BjJtD4/6bOFVzKinwIPVEZGKmoM55IoPGKmf14158c/8gm88Xy6iE7u/xxMn1lwJNvNMKy5UFE9hljh561t1x9CerJ4/9vYaigBUqfhJ35vsVwUSCaCQKXBDAdD1MuOMGGPm9Tna+smfC1tZLBZVXJ2zFclPLH9gFB8kAk+rEIFdgSzqmRCzym9H3mnji6zdxKQs" )));
}
