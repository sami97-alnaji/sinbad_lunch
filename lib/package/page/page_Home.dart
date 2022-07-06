// ignore_for_file: non_constant_identifier_names, avoid_print
//flutter run -d chrome --web-renderer html
import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
import 'package:sinbad_lunch/Controller/menu/getAllMenu.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/button/btnCollection.dart';
import 'package:sinbad_lunch/components/Widget/button/btn_menu_iitems.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/components/provider/product_page_variables.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_food.dart';
import 'package:sinbad_lunch/model/menu/get_all/get_menu_type.dart';
import 'package:sinbad_lunch/package/definitions/items_menu/items_menu.dart';
import 'package:sinbad_lunch/package/page/page_product.dart';

// ignore: must_be_immutable
class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);
  Color setBackColor = ColorsApp.white;

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
//    dd(){
//      PageHome().setBackColor = ColorsApp.primColr;
//    setState(() {
//      PageHome().setBackColor ;
//    });
// print( PageHome().setBackColor);
//  }
  funcOne() => print('one');

  //
  // funcTwo() {
  //   print('two');
  // }
  //  List<Function> onPaused = [funcOne,funcTwo,()=>print('func anonym')] ;
  // //run every function in onPaused

  // /*List<List<String>> */
  // late List<String> heddfr = [];
  // List headlines = [
  //   [
  //     ImageApp.imgPlatters,
  //     "dishes",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //       print('sami');
  //     },
  //     ColorsApp.white1,
  //   ],
  //   [
  //     ImageApp.imgPlatters,
  //     WordAppENG.platters + "sisisi",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //     },
  //     ColorsApp.white1,
  //   ],
  //   [
  //     ImageApp.imgPlatters,
  //     WordAppENG.platters + "sijdosijo",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //     },
  //     ColorsApp.white1,
  //   ],
  //   [
  //     ImageApp.imgPlatters,
  //     WordAppENG.platters + "osdkpsaok",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //     },
  //     ColorsApp.white1,
  //   ],
  //   [
  //     ImageApp.imgPlatters,
  //     WordAppENG.platters + "sdijsaoid",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //     },
  //     ColorsApp.white1,
  //   ],
  //   [
  //     ImageApp.imgPlatters,
  //     WordAppENG.platters + "ncimf",
  //     () {
  //       PageHome().setBackColor = ColorsApp.primColr;
  //     },
  //     ColorsApp.white1,
  //   ],
  // ];
  var itemsMenu = [];
  var headlines1 = [];
  int stopping_place_Btn = 0;
  String stopping_place_Btn1 = 'dishes';
  Timer? _timer;
  /********************************************************/
  // check conncetion to server
  bool? _isConnectionSuccessful=true;

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.woolha2.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }
  _tryConnectionWAit() async {

    await _tryConnection();
  }
  ex() async {
    await EasyLoading.dismiss();
  }
  /***************************************************************************/
  @override
  void initState() {
    /****************************************************/
    // for (int i = 0; i < headlines.length; i++) {
    //   headlines1.add(HeadLines(
    //     headlines[i][1].toString(),
    //     headlines[i][0].toString(),
    //     onTap: () {
    //       setState(() {
    //         PageHome().setBackColor = ColorsApp.primColr;
    //         // stopping_place_Btn = i;
    //       });
    //       print(stopping_place_Btn);
    //       print("heddfr\n " + heddfr[stopping_place_Btn] + "  \n nheddfr");
    //     }, //headlines[i][2] as Function()?,
    //   ));
    // }
    /****************************************************/
    /****************************************************/
    // for (int i = 0; i < headlines.length; i++) {
    //   // int uu = i * 787456;
    //
    //   setState(() {
    //     heddfr.add(headlines[i][1]);
    //     // print("heddfr\n "+heddfr[i] +"  \n nheddfr");
    //   });
    // }
    /****************************************************/
    _tryConnectionWAit();
    /****************************************************/

    for (int i = 0; i < 15; i++) {
      itemsMenu.add(ItemsMenu(
        imageItem: ImageApp.imGyro,
        nameItem: WordAppENG.gloryBeginingRestrant,
        titelItem: WordAppENG.titelItemgloryBeginingRestrant,
        pricceItem: '\$51.00',
      ));
    }
    setFirstLocation();

    ex();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.show(status: 'loading...',
      // maskType: EasyLoadingMaskType.black
    );
    int duration = 1;
    Timer(  Duration(seconds: duration), () async {
      if(itemsMenu != []) {
        EasyLoading.dismiss();
        setState(() {
          duration=0;
        });

      }else{
        setState(() {
          duration+=1;
        });
      }
      await EasyLoading.dismiss();
    });
    super.initState();
  }

  setFirstLocation() async {
    var num = await GetAllMenu().get_menu_type_Data();
    stopping_place_Btn = num[0].menu_type_id!;
    stopping_place_Btn1 = num[0].menu_type_name!;
  }

  late List<Color> o = [];
  late List<Widget> b = [];
  TextEditingController? controllerCountItems = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var count;

  @override
  Widget build(BuildContext context) {
    if(_isConnectionSuccessful!) {
      try {
    /****************************************************/
    count = Provider.of<ProductPageVariables>(context);

    /****************************************************/
    for (int i = 0; i < 10; i++) {
      o.add(Colors.blue);
    }
    /*******************************************************/
    for (int i = 0; i < 10; i++) {
      b.add(TextButton(
        onPressed: () {
          setState(() {
            o[i] = Colors.redAccent;
          });
        },

        child: AStx(
          'sami1',
          size: 22,
          isBold: true,
          colr: Colors.redAccent,
        ),

        // Text(
        //   'sami1',
        //   style: TextStyle(fontSize: 22, color: o[i]),
        // )
      ));
    }
    /*******************************************************/
    DateTime timeBackPressed = DateTime.now();
    setState(() {
      PageHome().setBackColor;
    });

        return WillPopScope(
          onWillPop: () async {
            final difference = DateTime.now().difference(timeBackPressed);
            final isExitWarning = difference >= const Duration(seconds: 1);

            timeBackPressed = DateTime.now();
            if (isExitWarning) {
              const message = 'Press back again to exit';
              Fluttertoast.showToast(msg: message, fontSize: 18);
              return false;
            } else {
              Fluttertoast.cancel();
              return true;
            }
          },
          child: Scaffold(
            drawer: const MyDrawer(),
            appBar: MyAppBar(titel: 'Home'),
            body: Scaffold(
              body: Container(
                height: DimenApp.hightSc(context),
                width: DimenApp.widthSc(context),
                color: ColorsApp.white1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // image up screen on home page as a Advertising
                      // Card(
                      //   child:

                      //image
                      setImageInHeader(),

                      //note   --->!
                      // SizedBox(
                      //   height:
                      //   DimenApp.hightSc(context, hightPy: 0.011), //128,
                      // ),
                      // count.note(),

                      SizedBox(
                        height:
                            DimenApp.hightSc(context, hightPy: 0.011), //128,
                      ),
                      // ),
                      /************************************************************************************************************/
                      // list of ButtonCollection (Package)
                      // The names of the categories in the menu
                      // When you click on it, a menu appears
                      /************************************************************************************************************/
                      SizedBox(
                        // height: DimenApp.hightSc(context, hightPy: 0.35),
                        width: DimenApp.widthSc(context),
                        child:
                            // Card(child:
                            Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AStx(
                                WordAppENG.specialFodItm,
                                size: 20,
                                isBold: true,
                                colr: ColorsApp.primColr,
                              ),

                              // AutoSizeText(WordAppENG.specialFodItm,
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 28,
                              //       color: ColorsApp.primColr,
                              //     )),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                ),
                                child: AStx(
                                  WordAppENG.gloryBeginingRestrant1,
                                ),
                              ),
                              // AutoSizeText(WordAppENG.gloryBeginingRestrant1,
                              //     style: const TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 165,
                                //DimenApp.hightSc(context, hightPy: 0.28),
                                width: DimenApp.widthSc(context),
                                /**************************************************/
                                child: FutureBuilderGet_menu_type(),
                                /**************************************************/
                                // ListView(orizontal,
                                //                                 //   children: [
                                //                                 //
                                //                                 //     SizedBox(width: 20,),
                                //                                 //     TextButton(onPressed: (){ setState(() {
                                //                                 //       o[1]=Colors.redAccen
                                //   scrollDirection:  Axis.ht;
                                //     });}, child: Text('sami1',style: TextStyle(fontSize: 22,color: o[1]),)),
                                //
                                //      SizedBox(width: 20,),
                                //     TextButton(onPressed: (){ setState(() {
                                //       o[2]=Colors.redAccent;
                                //     });}, child: Text('sami1',style: TextStyle(fontSize: 22,color: o[2]),)),
                                //
                                //      SizedBox(width: 20,),
                                //     TextButton(onPressed: (){ setState(() {
                                //       o[3]=Colors.redAccent;
                                //     });}, child: Text('sami1',style: TextStyle(fontSize: 22,color: o[3]),)),
                                //
                                //      SizedBox(width: 20,),
                                //     TextButton(onPressed: (){ setState(() {
                                //       o[4]=Colors.redAccent;
                                //     });}, child: Text('sami1',style: TextStyle(fontSize: 22,color: o[4]),)),
                                //
                                //      SizedBox(width: 20,),
                                //     TextButton(onPressed: (){ setState(() {
                                //       o[5]=Colors.redAccent;
                                //     });}, child: Text('sami1',style: TextStyle(fontSize: 22,color: o[5]),)),
                                //
                                //
                                //   ],
                                // )
/*********************************************************/
                                // ListView(
                                //     scrollDirection: Axis.horizontal,
                                //     children: [
                                //   // const SizedBox(
                                //   //   width: 20,
                                //   // ),
                                //   ...headlines1.map(
                                //     (e) => btnCollection(
                                //       e.label,
                                //       e.imagePath,
                                //       onTap: () {
                                //         funcOne();
                                //         setState(() {
                                //           // ButtonCollectionState().setBackColor = ColorsApp.primColr;
                                //           // Col.f = ColorsApp.primColr;
                                //           stopping_place_Btn1 = e.label;
                                //         });
                                //         print(stopping_place_Btn1);
                                //         // print("heddfr\n "+heddfr[stopping_place_Btn] +"  \n nheddfr");
                                //       }, //e.onTap,
                                //     ),
                                //   ),
                                // ]
                                //
                                //     // List.generate(
                                //     //   headlines.length,
                                //     //   (index) => ButtonCollection(
                                //     //     headlines[index][1].toString(),
                                //     //     headlines[index][0].toString(),
                                //     //     onTab: headlines[index][2] as Function()?,
                                //     //   ),
                                //     // ),
                                //
                                //     /************************************************************************************/
                                //
                                //     // Here, according to the button you choose
                                //     // Show me my list
                                //     // Each menu is based on what he chose the button
                                //     /**********************************************************************************/
                                //     ),
                                /**************************************************/

                                // FutureBuilder<List<get_food>>(
                                //     future: GetAllMenu().get_food_Data(),
                                //     // if you mean this method well return image url
                                //     builder: (BuildContext context1,
                                //         AsyncSnapshot<List<get_food>> snapshot) {
                                //       if (snapshot.connectionState == ConnectionState.done) {
                                //         // additions = snapshot.data;
                                //         // return buildAddition(additions) ;
                                //         foods = snapshot.data;
                                //         return buildFood(foods) ;
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
                                //       } else if (snapshot.connectionState == ConnectionState.waiting) {
                                //         return Text("loading ...");
                                //       } else {
                                //         return Container();
                                //       }
                                //     },
                                //   ),
                              ),
                            ],
                          ),
                        ),
                        // ),
                      ),
                      /************************************************************************************************************/
                      // Display Menu NAme
                      /************************************************************************************************************/
                      Center(
                        child: AStx(
                          stopping_place_Btn1,
                          size: 18,
                          isBold: true,
                        ),
                        // AutoSizeText(stopping_place_Btn1,style: TextStyle(fontSize: 28,)),
                      ),
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.028),
                        // width: DimenApp.widthSc(context),
                      ),
                      /************************************************************************************************************/
                      //Display the menu according to the selected button
                      /************************************************************************************************************/
                      //       ...itemsMenu.map(
                      //         (e) => btnMenuItems(
                      //             imageItem: e.imageItem,
                      //             nameItem: e.nameItem,
                      //             titelItem: e.titelItem,
                      //             pricceItem: e.pricceItem,
                      // controllerCountItems:controllerCountItems,
                      //             onTab: () {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (BuildContext context) =>
                      //                           PageProduct(title: e.nameItem)));
                      //             }),
                      //       ),

                      FutureBuilderGetFoodMenu(),
                      /************************************************************************************************************/
                      SizedBox(
                        height: DimenApp.hightSc(context, hightPy: 0.028),
                        // width: DimenApp.widthSc(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } on Exception catch (_) {
        print("throwing new error");

        throw Center(
          child: AStx('Wait a moment please'),
        );
      }
    }else{
      return Center(
        child: AStx('Not connected to any network'),
      );
    }
  }

  /// *****************************************************************************/
  List<get_food>? foods;

  FutureBuilderGetFoodMenu() => FutureBuilder<List<get_food>>(
        future: GetAllMenu().get_food_Data(),
        // if you mean this method well return image url
        builder:
            (BuildContext context1, AsyncSnapshot<List<get_food>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            foods = snapshot.data;
            return buildFood(foods);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading ...");
          } else {
            return Container();
          }
        },
      );

  Widget buildFood(List<get_food>? foods) {
    return ListView.builder(
      shrinkWrap: true,
//menu_type_id
      itemCount: foods!.length,
      physics: const BouncingScrollPhysics(),
      // scrollDirection:Axis.vertical,
      itemBuilder: (context, index) {
        final food = foods[index];
        if (food.menu_type_id == stopping_place_Btn) {
          return btnMenuItems(
              imageItem: food.food_image ?? ImageApp.imgLogo,
              nameItem: food.food_name ?? '',
              titelItem: food.food_description ?? '',
              pricceItem: food.food_price ?? 99.1,
              controllerCountItems: controllerCountItems,
              onTab: () {
                count.reVariables();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PageProduct(food: food)));
              });
        } else {
          return Container();
        }
        //   Card(
        //   child: Row(
        //       children:
        //       [
        //         Column(
        //           children: [
        //             AStx(food.food_id!.toString(),MLin: 2,),
        //             AStx(food.kitchen_id!.toString(),MLin: 2,),
        //             AStx(food.food_name!.toString(),MLin: 2,),
        //             AStx(food.food_description!.toString(),MLin: 2,),
        //             AStx(food.food_image!.toString(),MLin: 2,),
        //             AStx(food.food_price!.toString(),MLin: 2,),
        //           ],
        //         ),
        //       ]
        //   ),
        // );
      },
    );
  }

  /// *****************************************************************************/
  List<get_menu_type>? menuTypes;

  FutureBuilderGet_menu_type() {
    return FutureBuilder<List<get_menu_type>>(
      future: GetAllMenu().get_menu_type_Data(),
      // if you mean this method well return image url
      builder:
          (BuildContext context, AsyncSnapshot<List<get_menu_type>> snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: AStx('some think is Warring'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            menuTypes = snapshot.data;
            return buildMenuType(menuTypes);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading ...");
          } else if (snapshot.connectionState == ConnectionState.active) {
            return CircularProgressIndicator(
              color: ColorsApp.primColr,
            );
          } else {
            return Container();
          }
        } on Exception catch (_) {
          print("throwing new error");

          throw Container();
        }
      },
    );
  }

  Widget buildMenuType(List<get_menu_type>? menuTypes) {
    try {
      return ListView.builder(
        itemCount: menuTypes!.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final menuType = menuTypes[index];
          return btnCollection(
            menuType.menu_type_name!.toString(),
            menuType.image_menu!.toString(),
            onTap: () {
              funcOne();
              setState(() {
                stopping_place_Btn1 = menuType.menu_type_name!.toString();
                stopping_place_Btn = menuType.menu_type_id!;
              });
              print(stopping_place_Btn1);
            }, //e.onTap,
          );
        },
      );
    } on Exception catch (_) {
      print("throwing new error");

      throw Center(
        child: AStx('some think is Warring'),
      );
    }
  }

  ///*******************************************************************************/
  setImageInHeader() {
    var image = 'https://sinbadslunch.com/myBackENd/home_page_imgEdit.png';
    /**********/
    var text1 = 'GET MEALS DELIVERED AT WORK ORDER INDIVIDUALLY';
    var text2 =
        'F R E E   D E L I V E R Y   N O   M I N I M U M   N O   H I D D E N   F E E S';
    var text3 = ' WE ONLY ACCEPT ORDERS FROM 6:00AM TILL 10:00 AM\n  ANY'
        ' ORDER AFTER 10:00 WILL NOT BE  FILLED';
    /************/
    var color1 = ColorsApp.text1home;
    var color2 = ColorsApp.text2home;
    var color3 = ColorsApp.text3home;
    /************/
    var size1Text = 9.0;
    var size2Text = 7.0;
    var size3Text = 8.0;
    /************/
    return Container(
      height: DimenApp.hightSc(context, hightPy: 0.24),
      width: DimenApp.widthSc(context),
      padding: const EdgeInsets.all(4.5),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox.fromSize(
          size: const Size.fromRadius(48),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // //image set
              // Image.network( 'https://sinbadslunch.com/myBackENd/home_page_imgEdit.png',
              //   fit: BoxFit.fitHeight,
              //   height:
              //   DimenApp.hightSc(context, hightPy: 0.28),
              //     loadingBuilder: (  ctx,   child,   loadingProgress) {
              //       if (loadingProgress == null) {
              //         return child;
              //       }else {
              //         return const Center(
              //           child: CircularProgressIndicator(
              //             valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              //           ),
              //         );
              //       }
              //     },
              //
              // ),

              CachedNetworkImage(
                imageUrl: image,
                // "https://sinbadslunch.com/myBackENd/home_page_img.png",
                fit: BoxFit.fitHeight,
                height: DimenApp.hightSc(context, hightPy: 0.28),
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: ColorsApp.primColr,
                )),
              ),

              Container(
                height: DimenApp.hightSc(context, hightPy: 0.3),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: CachedNetworkImageProvider(
                      image,
                      // "https://sinbadslunch.com/myBackENd/home_page_img.png",
                      // placeholder: (context, url) =>
                      //     Center(
                      //         child: CircularProgressIndicator(
                      //           color: ColorsApp.primColr,
                      //         )),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      /***************************************************************************/
                      // FadeInImage(
                      //   imageErrorBuilder: (  context,   exception,  stackTrace) {
                      //     print('Error Handler');
                      //     return Container(
                      //       width: 200.0,
                      //       height: 300.0,
                      //       child: Image.asset('assets/images/gyro.png'),
                      //     );
                      //   },
                      //   placeholder: const AssetImage('assets/images/site_logo.png'),
                      //   image: const NetworkImage('https://sinbadslunch.com/myBackENd/home_page_imgEdit.png'),
                      //   fit: BoxFit.cover,
                      //   height: 100.0,
                      //   width: 100.0,
                      // ),
                      /***************************************************************************/

                      // text set above the image ;
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 135.0, left: 10, right: 10),
                      //     child:
                      Expanded(
                        child: AStx(
                          text1,
                          colr: color1,
                          size: size1Text,
                          isBold: true,
                        ),
                      ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       bottom: 86.0, left: 20, right: 20),
                      //   child:
                      Expanded(
                        child: AStx(
                          text2,
                          colr: color2,
                          size: size2Text,
                          // isBold: true,
                        ),
                      ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       bottom: 15, left: 30, right: 30),
                      //   child:
                      Expanded(
                        flex: 2,
                        child: AStx(
                          text3,
                          colr: color3,
                          size: size3Text,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      // ),
                    ],
                  ),
                ),
              ),

              // text set above the image ;
              // Padding(
              //   padding: const EdgeInsets.only(
              //       bottom: 135.0, left: 10, right: 10),
              //   child: AStx(
              //     'GET MEALS DELIVERED AT WORK ORDER INDIVIDUALLY',
              //     colr: ColorsApp.text1home,
              //     size: 16,
              //     isBold: true,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       bottom: 86.0, left: 20, right: 20),
              //   child: AStx(
              //     'F R E E   D E L I V E R Y   N O   M I N I M U M   N O   H I D D E N   F E E S',
              //     colr: ColorsApp.text2home,
              //     size: 13,
              //     isBold: true,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       bottom: 15, left: 30, right: 30),
              //   child: AStx(
              //     ' WE ONLY ACCEPT '
              //     ' ORDERS FROM 6:00AM  TILL 10:00 AM\n  ANY'
              //     ' ORDER AFTER 10:00 WILL NOT BE  FILLED',
              //     colr: ColorsApp.text3home,
              //     size: 14,
              //     isBold: true,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // child: CircleAvatar(
      //    radius: 2,
      //    child: ClipOval(
      //      child: CachedNetworkImage(
      //        imageUrl:  "https://sinbadslunch.com/myBackENd/home_page_img.png",
      //        fit: BoxFit.fitHeight,
      //        height: DimenApp.hightSc(context, hightPy: 0.23),
      //      ),
      //    ),
      //  ),
      // child: Image.asset(
      //   ImageApp.imAd,
      //   height: DimenApp.hightSc(context, hightPy: 0.23),
      //   fit: BoxFit.fitHeight,
      // ),
    );
  }
}
