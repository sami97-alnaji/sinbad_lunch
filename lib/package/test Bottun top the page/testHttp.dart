// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:sinbad_lunch/Controller/menu/getAllMenu.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_additions.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_food.dart';

class testHttp extends StatefulWidget {
  const testHttp({Key? key}) : super(key: key);

  @override
  State<testHttp> createState() => _testHttpState();
}

class _testHttpState extends State<testHttp> {
  @override
  void setState(VoidCallback fn) {
    GetAllMenu.res;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: DimenApp.hightSc(context),
        width: DimenApp.widthSc(context),
        color: Colors.amber.withAlpha(999999999999),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  for (var w in await GetAllMenu().get_food_Data()) {
                    print("\n" +
                        w.food_id.toString() +
                        "\t" +
                        w.kitchen_id.toString() +
                        "\t" +
                        w.food_name.toString() +
                        "\t" +
                        w.food_description.toString()+
                        "\t" +
                        w.food_image.toString()+
                        "\t" +
                        w.food_price.toString()

                    );
                    setState(() {
                      GetAllMenu.res;
                    });
                    if (GetAllMenu.res != null &&
                        GetAllMenu.res!.statusCode == 200) {
                      // print(GetAllMenu.res!.statusCode);
                    }
                  }
                },
                child: const Text("Http"),
              ),
            ),
            const SizedBox(height: 100),
            fun(),
            // FutureBuilder<List<get_additions>>(
            //   future: GetAllMenu().get_additions_Data(),
            //   // if you mean this method well return image url
            //   builder: (BuildContext context1,
            //       AsyncSnapshot<List<get_additions>> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       additions =snapshot.data;
            //       return buildAddition(additions) ;
            //       // foods = snapshot.data;
            //       // return buildFood(foods) ;
            //         // print("\n\t" +
            //         //     w.additions_id.toString() +
            //         //     "\t" +
            //         //     w.additions_name.toString() +
            //         //     "\t" +
            //         //     w.additions_description.toString()
            //         //     +"\t" +
            //         //     w.additions_price.toString()
            //         // );
            //         // setState(() {
            //         //   GetAllMenu.res;
            //         // });
            //
            //
            //     } else if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Text("loading ...");
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            SizedBox(
              height: DimenApp.hightSc(context,hightPy: 0.5),

              child:
              FutureBuilder<List<get_food>>(
              future: GetAllMenu().get_food_Data(),
              // if you mean this method well return image url
              builder: (BuildContext context1,
                  AsyncSnapshot<List<get_food>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // additions = snapshot.data;
                  // return buildAddition(additions) ;
                  foods = snapshot.data;
                  return buildFood(foods) ;
                  // print("\n\t" +
                  //     w.additions_id.toString() +
                  //     "\t" +
                  //     w.additions_name.toString() +
                  //     "\t" +
                  //     w.additions_description.toString()
                  //     +"\t" +
                  //     w.additions_price.toString()
                  // );
                  // setState(() {
                  //   GetAllMenu.res;
                  // });


                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("loading ...");
                } else {
                  return Container();
                }
              },
            ),
            ),

          ],
        ),
      ),
    );
  }
     List<get_additions>? additions;
     List<get_food>? foods;
  Widget fun() {
    return (GetAllMenu.res != null && GetAllMenu.res!.statusCode == 200)
        ? Container()
        : const CircularProgressIndicator();
  }

  // Widget funWait() {
  //   return FutureBuilder<List<get_additions>>(
  //     future: GetAllMenu().get_additions_Data( food.food_id),
  //     // if you mean this method well return image url
  //     builder:
  //         (BuildContext context, AsyncSnapshot<List<get_additions>> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return Text(snapshot.data![2].additions_name!);
  //       } else if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("loading ...");
  //       }else {
  //         return Container();
  //       }
  //     },
  //   );
  // }

  Widget buildAddition(List<get_additions>? additions)

      {
       return SizedBox(
         height: DimenApp.hightSc(context,hightPy: 0.5),
      width: DimenApp.widthSc(context),
         child: ListView.builder(
           itemCount: additions!.length,
           physics: const BouncingScrollPhysics(),
           itemBuilder: (context, index) {
             final addition = additions[index];
             return Card(
               child: Row(

                   children:
                 [
                   Text(addition.additions_id!.toString()),
                 Text(addition.additions_name!.toString()),
                   Text(addition.additions_price!.toString()),
                 ]
                 // Text(addition.additions_id!.toString()),
                 // Text(addition.additions_name!.toString()),
                 // // Text(addition.additions_description!.toString()),
                 // Text(addition.additions_price!.toString()),

               ),
             );
           },
           //   child: Column(
           //     children: [
           //   for (var w in additions! ) {
           // Text(w.additions_id!.toString());
           // Text(w.additions_name!.toString());
           // Text(w.additions_description!.toString());
           // Text(w.additions_price!.toString());
           // }
           //     ],
           //   ),
         ),
       ) ;
      }

  Widget buildFood(List<get_food>? foods)

      {
       return SizedBox(
         height: DimenApp.hightSc(context,hightPy: 0.4),
      // width: DimenApp.widthSc(context,widthPy: 0.7),
         child:
         ListView.builder(

           itemCount: foods!.length,
           physics: const BouncingScrollPhysics(),
           scrollDirection:Axis.horizontal,
           itemBuilder: (context, index) {
             final food = foods[index];
             return  Card(
               child: Row(

                   children:
                 [

                   // Text(food.food_id!.toString()),

                   // Text(food.kitchen_id!.toString()),
                   Column(
                     children: [
                       AStx(food.food_id!.toString(),MLin: 2,),
                       AStx(food.kitchen_id!.toString(),MLin: 2,),
                       AStx(food.food_name!.toString(),MLin: 2,),
                       AStx(food.food_description!.toString(),MLin: 2,),
                       AStx(food.food_image!.toString(),MLin: 2,),
                       AStx(food.food_price!.toString(),MLin: 2,),
                     ],
                   ),



                 ]
                 // Text(addition.additions_id!.toString()),
                 // Text(addition.additions_name!.toString()),
                 // // Text(addition.additions_description!.toString()),
                 // Text(addition.additions_price!.toString()),

               ),
             );
           },
           //   child: Column(
           //     children: [
           //   for (var w in additions! ) {
           // Text(w.additions_id!.toString());
           // Text(w.additions_name!.toString());
           // Text(w.additions_description!.toString());
           // Text(w.additions_price!.toString());
           // }
           //     ],
           //   ),
         ),
       ) ;
      }

}
