// ignore_for_file: non_constant_identifier_names, camel_case_types

class UserInfo {

  String? user_id,
      first_name,
      last_name,
      email,
      phone_number,
      company_id,
      password,
      status_email;

/*
    $_SESSION["user_id"] = $data["user_id"];
    $_SESSION["first_name"] = $data["first_name"];
    $_SESSION["last_name"] = $data["last_name"];
    $_SESSION["email"] = $data["email"];
    $_SESSION["phone_number"] = $data["phone_number"];
    $_SESSION["company_id"]  = $data["company_id"];
    $_SESSION["password"] = $data["password"];
    $_SESSION["status_email"] = $data["status_email"];
 */
  UserInfo(
      {this.user_id,
      this.first_name,
      this.last_name,
      this.email,
      this.phone_number,
      this.company_id,
      this.password,
      this.status_email});

  // factory UserInfo.fromJson(Map<String, dynamic> json) {
  //   return UserInfo(
  //       user_id:  json['user_id']+"" ?? " ",
  //       first_name: json['first_name']+"" ?? " " ,
  //       last_name: json['last_name']+"" ?? " " ,
  //       email: json['email']+"" ?? " " ,
  //       phone_number: json['phone_number']+"" ?? " " ,
  //       company_id: json['company_id']+"" ?? " " ,
  //       password: json['password']+"" ?? " " ,
  //       status_email: json['status_email']+"" ?? " " );
  // }
}
