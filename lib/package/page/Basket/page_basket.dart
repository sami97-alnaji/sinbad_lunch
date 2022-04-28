import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';

class PageBasket extends StatefulWidget {
  const PageBasket({Key? key}) : super(key: key);

  @override
  State<PageBasket> createState() => _PageBasketState();
}

class _PageBasketState extends State<PageBasket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(titel: 'Basket'),
      body: Container(child: Text('Basket'),),
    );


  }
}
