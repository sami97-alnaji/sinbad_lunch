// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/components/Encryptions/encryptionss.dart';

//https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/
//"http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/user/"
class OrderSave {
  String url =
      'https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/menu/order/';

  // 'http://192.168.80.1//Back-End Sinbad-Lunch API/menu/order/';

  //     "http://192.168.80.1//Back-End Sinbad-Lunch API/test/get_data_save_order.php";

  Future orderSaveDataInfo({
    required String user_id,
    required String company_id,
    required String amount,
    required String delivery_fee,
    required String tip,
    required String tax,
    required String total_amount,
    required String token_message,
  }) async {
    String link = url + "get_data_save_order_info.php";
    // String sss = 'http://192.168.80.1//Back-End Sinbad-Lunch API/shortCall.php';
    //`order_info_id` = X , `user_id`, `company_id`, `order_time`,
    // `amount`, `delivery_fee`, `municipality_tax`, `tip`,
    // `total_amount`, `payment_status`
    var res = await http.post(Uri.parse(link), body: {
      // "ec": Encryption.instance.encrypt('samisad123@gmail.com').toString(),
      "user_id": Encryption.instance.encrypt(user_id).toString(),
      "company_id": Encryption.instance.encrypt(company_id).toString(),
      "amount": Encryption.instance.encrypt(amount).toString(),
      "delivery_fee": Encryption.instance.encrypt(delivery_fee).toString(),
      "tax": Encryption.instance.encrypt(tax).toString(),
      "tip": Encryption.instance.encrypt(tip).toString(),
      "total_amount": Encryption.instance.encrypt(total_amount).toString(),
      "token_message": Encryption.instance.encrypt(token_message).toString(),
      // "ordr": json.encode(ordr)
    }, headers: {
      "Accept": "application/json"
    });
    if (res.statusCode == 200 || res.statusCode == 201) {
      return json.decode(Encryption.instance.decrypt(res.body));
    }

    return "no Connection";
  }

  Future orderSaveDataDetails(
      {required String order_info_id,
      required String food_id,
      required String? suace_id,
      required String? is_free_1Id,
      required String? is_free_2Id,
      required String? is_free_3Id,
      required String? instruction,
      required String total_food_Item,
      required String number_items}) async {
    String link = url + "get_data_save_order_details.php";
    //`order_info_id` = X , `user_id`, `company_id`, `order_time`,
    // `amount`, `delivery_fee`, `municipality_tax`, `tip`,
    // `total_amount`, `payment_status`
    var res = await http.post(Uri.parse(link), body: {
      "order_info_id": Encryption.instance.encrypt(order_info_id),
      "food_id": Encryption.instance.encrypt(food_id),
      "suace_id": Encryption.instance.encrypt(suace_id ?? "-1"),
      "is_free_1Id": Encryption.instance.encrypt(is_free_1Id??"-1"),
      "is_free_2Id": Encryption.instance.encrypt(is_free_2Id??"-1"),
      "is_free_3Id": Encryption.instance.encrypt(is_free_3Id??"-1"),
      "instruction": Encryption.instance.encrypt(instruction??"-1"),
      "total_food_Item":
          Encryption.instance.encrypt(total_food_Item),
      "number_items": Encryption.instance.encrypt(number_items),
    }, headers: {
      "Accept": "application/json"
    });
    if (res.statusCode == 200 || res.statusCode == 201) {

      print("orderSaveDataDetails : ");
      print (/*json.decode(*/Encryption.instance.decrypt(res.body)/*)*/);
      return json.decode(Encryption.instance.decrypt(res.body));
    }

    return "no Connection";
  }

  Future orderAdditionsSaveData (
      {required String order_info_id,
        required String order_food_id,
        required String addition_id, }) async {
    String link = url + "get_data_save_order_additions_details.php";
    //`order_info_id` = X , `user_id`, `company_id`, `order_time`,
    // `amount`, `delivery_fee`, `municipality_tax`, `tip`,
    // `total_amount`, `payment_status`
    var res = await http.post(Uri.parse(link), body: {
      "order_info_id": Encryption.instance.encrypt(order_info_id).toString(),
      "order_food_id": Encryption.instance.encrypt(order_food_id).toString(),
      "addition_id": Encryption.instance.encrypt(addition_id).toString(),
    }, headers: {
      "Accept": "application/json"
    });
    if (res.statusCode == 200 || res.statusCode == 201) {
      return json.decode(Encryption.instance.decrypt(res.body));
    }

    return "no Connection";
  }

}
