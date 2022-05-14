// ignore_for_file: non_constant_identifier_names, camel_case_types

class get_suace {
  int? suace_id;
  String? suace_name;
  double? price;

  get_suace({this.suace_id, this.suace_name, this.price});

  factory get_suace.fromJson(Map<String, dynamic> json) {
    return get_suace(
      suace_id: int.tryParse(json['suace_id'].toString()) ?? -1,
      suace_name: json['suace_name'],
      price: double.tryParse(json['price'].toString()) ?? -1,
    );
  }

  static get_suace? List_Get_suace;
}
