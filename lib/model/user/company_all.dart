// ignore_for_file: non_constant_identifier_names

class CompanyAll {
  int? company_id, how_many_employees, Delivery_Limit;

  String? comp_name, comp_phone_number, comp_email, comp_adderss, comp_website;

  double? delivery_fee;

  DateTime? request_start_time, request_time_out, delivery_time;

  CompanyAll(
      {this.company_id,
      this.how_many_employees,
      this.Delivery_Limit,
      this.comp_name,
      this.comp_phone_number,
      this.comp_email,
      this.comp_adderss,
      this.comp_website,
      this.delivery_fee,
      this.request_start_time,
      this.request_time_out,
      this.delivery_time});

  factory CompanyAll.fromJson(Map<String, dynamic> json) {
    return CompanyAll(
      company_id: int.tryParse(json['company_id'].toString()) ?? -1,
      how_many_employees: int.tryParse(json['how_many_employees'].toString()) ?? -1,
      Delivery_Limit: int.tryParse(json['Delivery_Limit'].toString()) ?? -1,
      comp_name: json['comp_name'],
      comp_phone_number: json['comp_phone_number'],
      comp_email: json['comp_email'],
      comp_adderss: json['comp_adderss'],
      comp_website: json['comp_website'],
      delivery_fee: double.tryParse(json['delivery_fee'].toString()) ?? -1,
    );
  }

}
