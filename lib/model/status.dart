import 'package:conduit/conduit.dart';
import 'package:vepr_backend/model/category.dart';
import 'package:vepr_backend/model/order_status.dart';
import 'package:vepr_backend/model/product.dart';

import 'characteristics.dart';
import 'my_copany.dart';


class Status extends ManagedObject<_Status> implements _Status {}
class _Status {
  @primaryKey
  int? id;
  @Column(indexed: true, useSnakeCaseName: true, nullable: false)
  String? statusName;
  
  ManagedSet<OrderStatus>? orderStatusList;
}