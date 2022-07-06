// ignore_for_file: non_constant_identifier_names

class OrderDetails {

  OrderDetails(
      {required this.itemsId,
      required this.itemsName,
      required this.itemsImage,
      required this.food_description,
      required this.itemsOfNumber,
      required this.itemsTotalPrice,
      this.sauceId,
      this.sauceName,
      this.saucePrice,
      this.instructon,
      this.addingList,
      this.iSFree1Id,
      this.isFree1Name,
      this.iSFree2Id,
      this.isFree2Name,
      this.iSFree3Id,
      this.isFree3Name});



  /// *****************************************************************/


  int itemsId;
  String itemsName,food_description, itemsImage;
  int itemsOfNumber;
  double itemsTotalPrice;

  /// *****************************************************************/

  int? sauceId;
  String? sauceName;
  double? saucePrice;

/// **********************************************************************/
  String? instructon;

/// ************************************************************************/
  List<AdditionalToppingg>? addingList;

/// ***************************************************************************/
  int? iSFree1Id;
  String? isFree1Name;

/// ***************************************************************************/
  int? iSFree2Id;
  String? isFree2Name;


/// ***************************************************************************/
  int? iSFree3Id;
  String? isFree3Name;


/*****************************************************************************/



}

class AdditionalToppingg {
  int? idAdditional;
  String? nameAdditional;
  double? priceAdditional;

  AdditionalToppingg(
      {this.idAdditional, this.nameAdditional, this.priceAdditional});
}
