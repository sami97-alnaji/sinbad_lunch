import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sinbad_lunch/Components/Widget/dimensions.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/button/buttonCollection.dart';
import 'package:sinbad_lunch/components/Widget/button/button_menu_iitems.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_app_bar.dart';
import 'package:sinbad_lunch/components/Widget/start_page/my_drawer.dart';
import 'package:sinbad_lunch/components/Words/Words.dart';
import 'package:sinbad_lunch/components/image/images.dart';
import 'package:sinbad_lunch/package/definitions/items_menu/items_menu.dart';
import 'package:sinbad_lunch/package/page/page_product.dart';
import 'package:sinbad_lunch/package/test%20Bottun%20top%20the%20page/headlines.dart';

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

  /*List<List<String>> */
  late List<String> heddfr = [];
  List headlines = [
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "f6ds4g684",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
        print('sami');
      },
      ColorsApp.white1,
    ],
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "sisisi",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
      },
      ColorsApp.white1,
    ],
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "sijdosijo",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
      },
      ColorsApp.white1,
    ],
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "osdkpsaok",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
      },
      ColorsApp.white1,
    ],
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "sdijsaoid",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
      },
      ColorsApp.white1,
    ],
    [
      ImageApp.imgPlatters,
      WordAppENG.platters + "ncimf",
      () {
        PageHome().setBackColor = ColorsApp.primColr;
      },
      ColorsApp.white1,
    ],
  ];
  var itemsMenu = [];
  var headlines1 = [];
  int stopping_place_Btn = 0;
  String stopping_place_Btn1 = '';

  @override
  void initState() {
    /****************************************************/
    for (int i = 0; i < headlines.length; i++) {
      headlines1.add(HeadLines(
        headlines[i][1].toString(),
        headlines[i][0].toString(),
        onTap: () {
          setState(() {
            PageHome().setBackColor = ColorsApp.primColr;
            stopping_place_Btn = i;
          });
          print(stopping_place_Btn);
          print("heddfr\n " + heddfr[stopping_place_Btn] + "  \n nheddfr");
        }, //headlines[i][2] as Function()?,
      ));
    }
    /****************************************************/
    /****************************************************/
    for (int i = 0; i < headlines.length; i++) {
      int uu = i * 787456;

      setState(() {
        heddfr.add(headlines[i][1]);
        // print("heddfr\n "+heddfr[i] +"  \n nheddfr");
      });
    }
    /****************************************************/

    for (int i = 0; i < 15; i++) {
      itemsMenu.add(ItemsMenu(
        imageItem: ImageApp.imGyro,
        nameItem: WordAppENG.gloryBeginingRestrant,
        titelItem: WordAppENG.titelItemgloryBeginingRestrant,
        pricceItem: '\$51.00',
      ));
    }
    super.initState();
  }

  late List<Color> o = [];
  late List<Widget> b = [];

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            'sami1',
            style: TextStyle(fontSize: 22, color: o[i]),
          )));
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
                  Container(
                    height: DimenApp.hightSc(context, hightPy: 0.22),
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
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://likedomens.000webhostapp.com/home_page_img.png",
                          fit: BoxFit.fitHeight,
                          height: DimenApp.hightSc(context, hightPy: 0.28),
                        ),
                      ),
                    ),
                    // child: CircleAvatar(
                    //    radius: 2,
                    //    child: ClipOval(
                    //      child: CachedNetworkImage(
                    //        imageUrl:  "https://likedomens.000webhostapp.com/home_page_img.png",
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
                  ),
                  // ),
                  /************************************************************************************************************/
                  // list of ButtonCollection (Package)
                  // The names of the categories in the menu
                  // When you click on it, a menu appears
                  /************************************************************************************************************/
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.31),
                    width: DimenApp.widthSc(context),
                    child:
                        // Card(child:
                        Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Column(
                        children: [
                          AutoSizeText(WordAppENG.specialFodItm,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: ColorsApp.primColr,
                              )),
                          AutoSizeText(WordAppENG.gloryBeginingRestrant1,
                              style: const TextStyle(fontSize: 18)),
                          SizedBox(
                            height: DimenApp.hightSc(context, hightPy: 0.23),
                            width: DimenApp.widthSc(context),
                            child:

                                // ListView(
                                //   scrollDirection:  Axis.horizontal,
                                //   children: [
                                //
                                //     SizedBox(width: 20,),
                                //     TextButton(onPressed: (){ setState(() {
                                //       o[1]=Colors.redAccent;
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

                                ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ...headlines1.map(
                                    (e) => ButtonCollection(
                                      e.label,
                                      e.imagePath,
                                      onTap: () {
                                        funcOne();
                                        setState(() {
                                          // ButtonCollectionState().setBackColor = ColorsApp.primColr;
                                          // Col.f = ColorsApp.primColr;
                                          stopping_place_Btn1 = e.label;
                                        });
                                        print(stopping_place_Btn1);
                                        // print("heddfr\n "+heddfr[stopping_place_Btn] +"  \n nheddfr");
                                      }, //e.onTap,
                                    ),
                                  ),
                                ]

                                    // List.generate(
                                    //   headlines.length,
                                    //   (index) => ButtonCollection(
                                    //     headlines[index][1].toString(),
                                    //     headlines[index][0].toString(),
                                    //     onTab: headlines[index][2] as Function()?,
                                    //   ),
                                    // ),

                                    /************************************************************************************/

                                    // Here, according to the button you choose
                                    // Show me my list
                                    // Each menu is based on what he chose the button
                                    /**********************************************************************************/
                                    ),
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ),
                  /************************************************************************************************************/
                  Center(
                    child: AutoSizeText(stopping_place_Btn1,style: TextStyle(fontSize: 28,)),
                  ),
                  SizedBox(
                    height: DimenApp.hightSc(context, hightPy: 0.028),
                    // width: DimenApp.widthSc(context),
                  ),
                  /************************************************************************************************************/
                  //Display the menu according to the selected button
                  /************************************************************************************************************/
                  ...itemsMenu.map(
                    (e) => ButtonMenuItems(
                        imageItem: e.imageItem,
                        nameItem: e.nameItem,
                        titelItem: e.titelItem,
                        pricceItem: e.pricceItem,
                        onTab: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PageProduct(title: e.nameItem)));
                        }),
                  ),
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
  }
}
