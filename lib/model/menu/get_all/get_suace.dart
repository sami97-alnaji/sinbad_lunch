import 'dart:convert';

import 'package:http/http.dart' as http;

class get_suace {
  int? suace_id;
  String? suace_name;
  double? price;

  get_suace({this.suace_id , this.suace_name , this.price});

  factory get_suace.fromJson(Map<String, dynamic> json) {
    return get_suace(
      suace_id: int.parse(json['suace_id']),
      suace_name: json['suace_name'],
      price: double.parse(  json['price']),
    );
  }




}


