import 'dart:async';
import 'package:conduit_core/conduit_core.dart';   

class Migration5 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Status", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("status_name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Order_Contents", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Order_Status", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("date_status", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Order", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("comment", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: true, isUnique: false),SchemaColumn("total_price", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),SchemaColumn("order_date", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, defaultValue: "now()", isIndexed: true, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Selected_Product", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("product_quantity", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_Selected_Product_Characteristics", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("_Order_Contents", SchemaColumn.relationship("selectedProduct", ManagedPropertyType.bigInteger, relatedTableName: "_Selected_Product", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Order_Contents", SchemaColumn.relationship("order", ManagedPropertyType.bigInteger, relatedTableName: "_Order", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Order_Status", SchemaColumn.relationship("order", ManagedPropertyType.bigInteger, relatedTableName: "_Order", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Order_Status", SchemaColumn.relationship("status", ManagedPropertyType.bigInteger, relatedTableName: "_Status", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Order", SchemaColumn.relationship("user", ManagedPropertyType.bigInteger, relatedTableName: "_User", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Selected_Product", SchemaColumn.relationship("product", ManagedPropertyType.bigInteger, relatedTableName: "_Product", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Selected_Product_Characteristics", SchemaColumn.relationship("selectedProduct", ManagedPropertyType.bigInteger, relatedTableName: "_Selected_Product", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
		database.addColumn("_Selected_Product_Characteristics", SchemaColumn.relationship("productCharacteristics", ManagedPropertyType.bigInteger, relatedTableName: "_Product_Characteristics", relatedColumnName: "id", rule: DeleteRule.cascade, isNullable: false, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    