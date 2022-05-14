// ignore_for_file: non_constant_identifier_names, camel_case_types

class get_list_additions{
  int? food_id,additions_id;

  get_list_additions({this.food_id, this.additions_id});


  factory get_list_additions.fromJson(Map<String, dynamic> json) {
    return get_list_additions(
      food_id: int.tryParse(json['food_id'].toString())??-1,
      additions_id: int.tryParse(json['additions_id'].toString())??-1,
    );
  }

}