import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material.dart';
import 'package:sinbad_lunch/components/Colors/colors.dart';
import 'package:sinbad_lunch/components/Widget/AutoSText/AStx.dart';
import 'package:sinbad_lunch/components/Widget/dimensions.dart';
import 'package:sinbad_lunch/package/page/CheckoutPages/page_Checkout.dart';

class PageBasket extends StatefulWidget {
  const PageBasket({Key? key}) : super(key: key);

  @override
  State<PageBasket> createState() => _PageBasketState();
}

class _PageBasketState extends State<PageBasket> {
  /***************************************/
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(titel: 'Basket'),
      body: Container(
        color: ColorsApp.primColr,
        // height: DimenApp.hightSc(context),
        // width: DimenApp.widthSc(context),
        child: Column(
          children: [
            //header in page "My Cart"
            SizedBox(
              height: DimenApp.hightSc(context, hightPy: 0.12 ),
              child: Container(
                padding: const EdgeInsets.only(top: 35),
                child: AStx(
                  'My Cart',
                  size: 20,
                  isBold: true,
                  colr: ColorsApp.white1,
                ),
              ),
            ),
            Container(
              width: DimenApp.widthSc(context),
              height: DimenApp.hightSc(context, hightPy: 0.59),
              child: SingleChildScrollView(
                // color: ColorsApp.white1,
                child: Column(
                  children: [
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My Cart',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                    AStx(
                      'My 5d5d5d5dd',
                      size: 20,
                      isBold: true,
                      colr: ColorsApp.primColr,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: ColorsApp.white1,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  // bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  // bottomLeft: Radius.circular(40.0),
                ),
              ),
            ),

            Container(
              color: ColorsApp.grey,
              height: DimenApp.hightSc(context, hightPy: 0.01),
            ),
            // Location and time
            /************************************************************************/

            SingleChildScrollView(
              child: Column(
                children: [    SizedBox(
                    width: DimenApp.widthSc(context),
                    height: DimenApp.hightSc(context, hightPy: 0.15),
                    child: Container(
                      color: ColorsApp.white1,
                      child: Text('items'),
                    ),
                  ),
                ],
              ),
            ),
            //button 1 Submit
            /************************************************************************/

            Center(
              child: Container(
                height: DimenApp.hightSc(context, hightPy: 0.1),
                width: DimenApp.widthSc(context),
                padding: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                child: SizedBox(
                  height: DimenApp.hightSc(context, hightPy: 0.08),
                  width: DimenApp.widthSc(context, widthPy: 0.82),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: ColorsApp.primColr,
                      shadowColor: ColorsApp.blak50,
                      elevation: 7,
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Page_Checkout()));
                    },
                    child: (isLoading)
                        ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ))
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AStx(
                          'Add to Cart',
                          size: 22,
                          colr: Colors.black54,
                        ),
                        // price item
                        AStx(
                          '\$5.00',
                          size: 17,
                          isBold: true,
                          colr: Colors.black54.withOpacity(0.5),
                        ),
                        // AutoSizeText(
                        //   'Add to Cart',
                        //   style: GoogleFonts.oxygen(
                        //     fontSize: 22,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                        // price item
                        // AutoSizeText('\$5.00',
                        //     style: GoogleFonts.oxygen(
                        //       fontSize: 17,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black54.withOpacity(0.5),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /************************************************************************/
          ],
        ),
      ),

      // Container(child: Text('Basket'),),
    );
  }
}
