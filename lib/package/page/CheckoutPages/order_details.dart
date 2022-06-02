class OrderDetails {

  OrderDetails(
      {required this.idItems,
      required this.nameItems,
      required this.numberOfItems,
      required this.totalPriceItems,
      this.isSauce,
      this.nameSauce,
      this.priceSauce,
      this.instructon,
      this.addingList,
      this.idISFree1,
      this.nameIsFree1,
      this.idISFree2,
      this.nameIsFree2,
      this.idISFree3,
      this.nameIsFree3});



  /// *****************************************************************/


  int idItems;
  String nameItems;
  int numberOfItems;
  double totalPriceItems;

  /// *****************************************************************/

  int? isSauce;
  String? nameSauce;
  double? priceSauce;

/// **********************************************************************/
  String? instructon;

/// ************************************************************************/
  List<AdditionalTopping>? addingList;

/// ***************************************************************************/
  int? idISFree1;
  String? nameIsFree1;

/// ***************************************************************************/
  int? idISFree2;
  String? nameIsFree2;


/// ***************************************************************************/
  int? idISFree3;
  String? nameIsFree3;


/*****************************************************************************/



}

class AdditionalTopping {
  int? isAdditional;
  String? nameAdditional;
  double? priceAdditional;
}
