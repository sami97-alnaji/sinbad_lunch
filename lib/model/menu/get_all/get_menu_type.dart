// ignore_for_file: non_constant_identifier_names, camel_case_types

class get_menu_type {
  int? menu_type_id;
  String? menu_type_name, image_menu;

  get_menu_type({this.menu_type_id, this.menu_type_name, this.image_menu});

  factory get_menu_type.fromJson(Map<String, dynamic> json) {
    return get_menu_type(
      menu_type_id: int.tryParse(json['menu_type_id'].toString())??-1,
      menu_type_name: json['menu_type_name'],
      image_menu: json['image_menu'],
    );
  }
}
