class OrderDetails {

  OrderDetails(
      {required this.itemsId,
      required this.itemsName,
      required this.itemsImage,
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
  String itemsName;
  String itemsImage;
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
  int? isAdditional;
  String? nameAdditional;
  double? priceAdditional;

  AdditionalToppingg(
      {this.isAdditional, this.nameAdditional, this.priceAdditional});
}
