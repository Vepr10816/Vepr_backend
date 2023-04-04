import 'dart:async';
import 'package:conduit_core/conduit_core.dart';   

class Migration4 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_PreValues", SchemaColumn("selectable", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, defaultValue: "false", isIndexed: true, isNullable: false, isUnique: false));
      database.addColumn("_Characteristics", SchemaColumn("selectable", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, defaultValue: "false", isIndexed: true, isNullable: false, isUnique: false));
		  database.deleteColumn("_PreValues", "selectable");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    