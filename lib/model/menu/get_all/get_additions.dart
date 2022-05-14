// ignore_for_file: non_constant_identifier_names, camel_case_types

class 	get_additions{
  int? additions_id;
  String? additions_name,additions_description;
  double? additions_price;
bool? stut;

  get_additions(
      {this.additions_id,
      this.additions_name,
      this.additions_description,
      this.additions_price,
        this.stut
       });

  factory get_additions.fromJson(Map<String, dynamic> json) {
    return get_additions(
      additions_id: int.tryParse(json['additions_id'].toString())??-1,
      additions_name: json['additions_name'],
      additions_description: json['additions_description']??'',
      additions_price: double.tryParse(  json['additions_price'].toString())??-1,
      // stut: false,
    );
  }

}