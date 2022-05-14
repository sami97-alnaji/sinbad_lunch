// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/model/menu/get_all/get_additions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_food.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_list_additions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_list_suace.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_menu_type.dart';

import 'dart:convert';

import 'package:sinbad_lunch/model/menu/get_all/get_suace.dart';


class GetAllMenu{
  String url = "http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/";
  static http.Response? res;

  Future<List<get_suace>> get_suace_Data( ) async {
    List<get_suace>? list;
    String link =url+"menu/get/get_suace.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_suace>((json) => get_suace.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }
  Future<List<get_suace>> get_query_suace(int food_id  ) async {
    List<get_suace>? list;
    String link =url+"menu/get/get_query_suace.php";
    res = await http.post( Uri.parse(link), body: {
      'food_id': food_id.toString() ,}, headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_suace>((json) => get_suace.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }

  Future<List<get_additions>> get_additions_Data( ) async {
    List<get_additions>? list;
    String link =url+"/menu/get/get_additions.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_additions>((json) => get_additions.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }

  Future<List<get_additions>> get_query_additions(int food_id ) async {
    List<get_additions>? list;
    String link =url+"/menu/get/get_query_additions.php";
    res = await http.post( Uri.parse(link), body: {
      'food_id': food_id.toString() ,}, headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_additions>((json) => get_additions.fromJson(json)).toList();
    }

    print("List Size of get_query_additions : ${list!.length}");
    return list;
  }


  Future<List<get_food>> get_food_Data( ) async {
    List<get_food>? list;
    String link =url+"/menu/get/get_food.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_food>((json) => get_food.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }
  Future<List<get_list_additions>> get_list_additions_Data( ) async {
    List<get_list_additions>? list;
    String link =url+"/menu/get/get_list_additions.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_list_additions>((json) => get_list_additions.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }
  Future<List<get_list_suace>> get_list_suace_Data( ) async {
    List<get_list_suace>? list;
    String link =url+"/menu/get/get_list_suace.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_list_suace>((json) => get_list_suace.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }
  Future<List<get_menu_type>> get_menu_type_Data( ) async {
    List<get_menu_type>? list;
    String link =url+"/menu/get/get_menu_type.php";
      res = await http.get( Uri.parse(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res!.statusCode == 200) {
      var data = json.decode(res!.body);
      var rest = data as List;
      // print(rest);
      list = rest.map<get_menu_type>((json) => get_menu_type.fromJson(json)).toList();
    }

    print("List Size: ${list!.length}");
    return list;
  }


}