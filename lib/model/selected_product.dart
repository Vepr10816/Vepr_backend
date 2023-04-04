import 'package:conduit/conduit.dart';
import 'package:vepr_backend/model/currency.dart';
import 'package:vepr_backend/model/order_contents.dart';
import 'package:vepr_backend/model/product.dart';
import 'package:vepr_backend/model/product_charateristics.dart';
import 'package:vepr_backend/model/product_photos.dart';
import 'package:vepr_backend/model/selected_product_characteristics.dart';
import 'package:vepr_backend/model/subcategory.dart';

class SelectedProduct extends ManagedObject<_Selected_Product> implements _Selected_Product {}

class _Selected_Product{
  @primaryKey
  int? id;
  @Column(indexed: true, useSnakeCaseName: true, nullable: false)
  int? productQuantity;

  @Serialize(input: true, output: false)
  int? idProduct;

  ManagedSet<OrderContents>? orderContentsList;

  ManagedSet<SelectedProductCharacteristics>? selectedProductCharacteristicsList;

  @Relate(#selectedProductList, isRequired: true, onDelete: DeleteRule.cascade)
  Product? product;

}