// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/components/Encryptions/encryptionss.dart';

//https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/user/
//"http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/user/"
class Autho {
  String url =
      "https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/user/";

  Future signUp(
      {required String first_name,
      required String last_name,
      required String email,
      required String phone_number,
      required String company_id,
      required String password}) async {
    String link = url + "signup.php";
    var res = await http.post(Uri.parse(link), body: {
      "first_name": Encryption.instance.encrypt(first_name).toString(),
      "last_name": Encryption.instance.encrypt(last_name).toString(),
      "email": Encryption.instance.encrypt(email).toString(),
      "phone_number": Encryption.instance.encrypt(phone_number).toString(),
      "company_id": Encryption.instance.encrypt(company_id).toString(),
      "password": Encryption.instance.encrypt(password).toString(),
    }, headers: {
      "Accept": "application/json"
    });

    return json.decode(res.body);
  }

  Future sendEmail(String email) async {
    String link =
        "https://sinbadslunch.com/myBackENd/PHPMailer-master/new_php_mail/index.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": email,
    });

    // return json.decode(res.body);
  }

  Future confirmationCode(String email) async {
    String link = url + "confirmation_code.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": email,
    });
    print(res.body.toString());
    return Encryption.instance.decrypt(res.body.toString());
  }

  Future acceptance(String email, String code) async {
    String link = url + "acceptance.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": Encryption.instance.encrypt(email).toString(),
      "code": Encryption.instance.encrypt(code).toString(),
    });

    return Encryption.instance.decrypt(res.body).toString();
  }

  // Future logIn({required String email, required String password}) async {
  //
  //   String link = url + "login.php";
  //   var res = await http.post(Uri.parse(link),
  //       body: {
  //         "email":Encryption.instance.encrypt(email).toString(),
  //         "password":Encryption.instance.encrypt(password).toString(),
  //       }
  //   );
  //
  //   return  Encryption.instance.decrypt(res.body).toString();
  //
  // }

  Future logIn({required String email, required String password}) async {
    var data;
    String link = url + "login.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": Encryption.instance.encrypt(email).toString(),
      "password": Encryption.instance.encrypt(password).toString(),
    }, headers: {
      "Accept": "application/json"
    });

    if (res.statusCode == 200) {
      data = json.decode(Encryption.instance.decrypt(res.body));
    }
    return data;
  }

  Future forgotPassword({required String email}) async {
    String link = url + "forgot_password.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": Encryption.instance.encrypt(email).toString(),
    });
    print(json.decode(Encryption.instance.decrypt(res.body).toString()));
    return json.decode(Encryption.instance.decrypt(res.body).toString());
  }

  Future setNewPass({required String email, required String password}) async {
    String link = url + "set_new_password.php";
    var res = await http.post(Uri.parse(link), body: {
      "email": Encryption.instance.encrypt(email).toString(),
      "password": Encryption.instance.encrypt(password).toString(),
    });

    return json.decode(Encryption.instance.decrypt(res.body).toString());
  }
}
