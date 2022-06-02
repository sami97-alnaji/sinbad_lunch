
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/model/user/company_all.dart';

class GetAllUserInfo{
  String url = "http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/user/";
 // companyAll.php
  // ignore: non_constant_identifier_names
  Future<List<CompanyAll>> CompanyAllData( ) async {
    List<CompanyAll>? list;
    String link =url+"companyAll.php";
    var res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<CompanyAll>((json) => CompanyAll.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }

}