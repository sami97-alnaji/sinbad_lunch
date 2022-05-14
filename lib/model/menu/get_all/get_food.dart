// ignore_for_file: non_constant_identifier_names, camel_case_types

class get_food {
  int? food_id, menu_type_id, kitchen_id, is_free1, is_free2, is_free3;
  String? food_name, food_description, food_image;

  double? food_price;

  get_food({
    this.food_id,
    this.menu_type_id,
    this.kitchen_id,
    this.food_name,
    this.food_description,
    this.food_image,
    this.food_price,
    this.is_free1,
    this.is_free2,
    this.is_free3,
  });

  factory get_food.fromJson(Map<String, dynamic> json) {
    return get_food(
      food_id: int.tryParse(json['food_id'].toString())??-1,
      is_free1: int.tryParse(json['is_free1'].toString())??-1,
      is_free2: int.tryParse(json['is_free2'].toString())??-1,
      is_free3: int.tryParse(json['is_free3'].toString())??-1,
      menu_type_id: int.tryParse(json['menu_type_id'])??-1,
      kitchen_id: int.tryParse(json['kitchen_id'])??-1,
      food_name: json['food_name'],
      food_description: json['food_description'],
      food_image: json['food_image'],
      food_price: double.tryParse(json['food_price'].toString())??-1,
    );
  }
}
