import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';

class PageMyOrder extends StatefulWidget {
  const PageMyOrder({Key? key}) : super(key: key);

  @override
  State<PageMyOrder> createState() => _PageMyOrderState();
}

class _PageMyOrderState extends State<PageMyOrder> {
  ///********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful = true;

  Future<void> _tryConnection() async {
    bool? result = false;
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      final response =
          await InternetAddress.lookup('https://www.sinbadslunch.com/');

      setState(() {
        _isConnectionSuccessful = result; //response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful == result; // false;
      });
    }
  }

  _tryConnectionWAit() async {
    await _tryConnection();
  }

  /// *************************************************************************/

  @override
  void initState() {
    super.initState();

    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnectionSuccessful!) {
      try {
        return Scaffold(
          appBar: MyAppBar(
            titel: WordAppENG.PageMyOrder,
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 12.0, bottom: 5.0),
                  child: SizedBox(
                    height: 140,
                    width: double.infinity,
                    /*GestureDetector*/ child: InkWell(
                    onTap: () {print('tap');},

                      child: Card(
                        color: ColorsApp.white1.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  AStx(
                                    "Order Number : ",
                                    size: 15,
                                  ),
                                  AStx(
                                    "Date Order : ",
                                    size: 15,
                                  ),
                                  AStx(
                                    "Time Order : ",
                                    size: 15,
                                  ),
                                  AStx(
                                    "Total Amount : ",
                                    size: 15,
                                  ),
                                  AStx(
                                    "Status Order : ",
                                    size: 15,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  AStx(
                                    // order number
                                    "#65169",
                                    size: 14,
                                  ),
                                  AStx(
                                    // date order
                                    "2022-02-02",
                                    size: 14,
                                  ),
                                  AStx(
                                    // time order
                                    "10:12",
                                    size: 14,
                                  ),
                                  AStx(
                                    // total amount
                                    "\$"+"100.00",
                                    size: 14,
                                  ),
                                  AStx(
                                    // status order
                                     "In Preparation! ...",
                                    size: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } on Exception catch (_) {
        print("throwing new error");

        throw Center(
          child: AStx('Wait a moment please'),
        );
      }
    } else {
      return Center(
        child: AStx('Not connected to any network'),
      );
    }
  }
}
