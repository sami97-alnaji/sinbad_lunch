import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:sinbad_lunch/model/menu/get_all/get_suace.dart';


class GetAllMenu{
  String url = "http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/";

  Future<List<get_suace>> get_suace_Data( ) async {
    List<get_suace>? list;
    String link =url+"menu/get/get_suace.php";
    var res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_suace>((json) => get_suace.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }

}