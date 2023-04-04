import 'package:conduit/conduit.dart';
import 'package:vepr_backend/model/product.dart';

class ProductPhotos extends ManagedObject<_Product_Photos> implements _Product_Photos {}

class _Product_Photos{
  @primaryKey
  int? id;
  @Column(indexed: true, useSnakeCaseName: true, nullable: false)
  String? urlPhoto;

  @Serialize(input: true, output: false)
  int? idProduct;
  
  @Relate(#productPhotosList, isRequired: true, onDelete: DeleteRule.cascade)
  Product? product;

}