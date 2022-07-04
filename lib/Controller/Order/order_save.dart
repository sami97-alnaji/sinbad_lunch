// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:sinbad_lunch/components/Encryptions/encryptionss.dart';

//https://sinbadslunch.com/myBackENd/Back-End%20Sinbad-Lunch%20API/
//"http://192.168.80.1/Back-End%20Sinbad-Lunch%20API/user/"
class OrderSave {
  String url = 'http://192.168.80.1//Back-End Sinbad-Lunch API/menu/order/';

  //     "http://192.168.80.1//Back-End Sinbad-Lunch API/test/get_data_save_order.php";

  // ignore: non_constant_identifier_names
  Future orderSaveDataInfo() async {
    String link =
        url + "get_data_save_order_info.php";
    // String sss = 'http://192.168.80.1//Back-End Sinbad-Lunch API/shortCall.php';
    //`order_info_id` = X , `user_id`, `company_id`, `order_time`,
    // `amount`, `delivery_fee`, `municipality_tax`, `tip`,
    // `total_amount`, `payment_status`
    var res = await http.post(Uri.parse(link), body: {
      // "ec": Encryption.instance.encrypt('samisad123@gmail.com').toString(),
      "user_id": "1",
      "company_id": "1",
      "order_time": "123456789",
      "amount": "1234",
      "delivery_fee": "1234",
      "municipality_tax": "1234",
      "tip": "1234",
      "total_amount": "1234",
      "payment_status": "1234",
      // "ordr": json.encode(ordr)
    },
        headers: {
      "Accept": "application/json"
    }
    );
    // print(res.body);
    if (res.statusCode == 200) {
      // var data = json.decode(res.body);
      // var rest = data as List;
      // print(rest);
      // list = rest.map<CompanyAll>((json) => CompanyAll.fromJson(json)).toList();
    }

    // print("List Size: ${res.body}");
    return res.body;
  }
  Future orderSaveDataDetails(String numberItems, String itemsTotalPrice, String orderFoodId) async {
    /*
            echo "order_food_id   = ".$_POST["order_food_id"]."\n";
            echo "order_info_id   = ".$_POST["order_info_id"]."\n";
            echo "food_id   = ".$_POST["food_id"]."\n";
            echo "suace_id   = ".$_POST["suace_id"]."\n";
            echo "is_free_1Id   = ".$_POST["is_free_1Id"]."\n";
            echo "is_free_2Id   = ".$_POST["is_free_2Id"]."\n";
            echo "is_free_3Id   = ".$_POST["is_free_3Id"]."\n";
            echo "Instruction   = ".$_POST["Instruction"]."\n";
            echo "number_items   = ".$_POST["number_items"]."\n";
     */
    String link =
        url + "get_data_save_order_details.php";
    //`order_info_id` = X , `user_id`, `company_id`, `order_time`,
    // `amount`, `delivery_fee`, `municipality_tax`, `tip`,
    // `total_amount`, `payment_status`
    var res = await http.post(Uri.parse(link), body: {
      "order_food_id": orderFoodId,
      "total_food_Item": itemsTotalPrice,
      "numberItems": numberItems,
      // "amount": "1234",
      // "delivery_fee": "1234",
      // "municipality_tax": "1234",
      // "tip": "1234",
      // "total_amount": "1234",
      // "payment_status": "1234",
      // "ordr": json.encode(ordr)
    }, headers: {
      "Accept": "application/json"
    });
    // print(res.body);
    if (res.statusCode == 200) {
      // var data = json.decode(res.body);
      // var rest = data as List;
      // print(rest);
      // list = rest.map<CompanyAll>((json) => CompanyAll.fromJson(json)).toList();
    }

    print(" ${res.body}");
    // return res.body;
  }
}
