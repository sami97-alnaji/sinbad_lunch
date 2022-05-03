import 'package:flutter/material.dart';
import 'package:sinbad_lunch/Controller/menu/getAllMenu.dart';

class testHttp extends StatefulWidget {
  const testHttp({Key? key}) : super(key: key);

  @override
  State<testHttp> createState() => _testHttpState();
}

class _testHttpState extends State<testHttp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.withAlpha(999999999999),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            var xx = await GetAllMenu().get_suace_Data();
            for (var w in xx) {
              print("\n\t" +
                  w.suace_id.toString() +
                  "\t" +
                  w.suace_name.toString() +
                  "\t" +
                  w.price.toString().toString());
            }
          },
          child: Text("Http"),
        ),
      ),
    );
  }
}
