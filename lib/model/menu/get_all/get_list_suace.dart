// ignore_for_file: non_constant_identifier_names, camel_case_types

class get_list_suace{
  int? food_id,suace_id;

  get_list_suace({this.food_id, this.suace_id});

  factory get_list_suace.fromJson(Map<String, dynamic> json) {
    return get_list_suace(
      food_id: int.tryParse(json['food_id'].toString())??-1,
      suace_id: int.tryParse(json['suace_id'].toString())??-1,
    );
  }

}