import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:vepr_backend/controllers/app_order_controller.dart';
import 'package:vepr_backend/controllers/app_selectable_characteristics_controller.dart';
import 'package:vepr_backend/model/status.dart';

import 'controllers/app_addresses_controller.dart';
import 'controllers/app_all_addresses_controller.dart';
import 'controllers/app_all_category_controller.dart';
import 'controllers/app_all_characteristics.dart';
import 'controllers/app_all_currency.dart';
import 'controllers/app_all_data_type_controller.dart';
import 'controllers/app_all_pre_values_controller.dart';
import 'controllers/app_all_product_characteristics_controller.dart';
import 'controllers/app_all_product_controller.dart';
import 'controllers/app_all_product_photos.dart';
import 'controllers/app_all_requisites_controller.dart';
import 'controllers/app_all_subcategory_controller.dart';
import 'controllers/app_auth_controller.dart';
import 'controllers/app_category_controller.dart';
import 'controllers/app_characteristics.dart';
import 'controllers/app_company_controller.dart';
import 'controllers/app_currency_controller.dart';
import 'controllers/app_data_type_controller.dart';
import 'controllers/app_pre_valuses.controller.dart';
import 'controllers/app_product_characteristics_controller.dart';
import 'controllers/app_product_controller.dart';
import 'controllers/app_product_photos_controller.dart';
import 'controllers/app_requisites_controller.dart';
import 'controllers/app_subcategory.dart';
import 'controllers/app_token_controller.dart';
import 'model/addresses.dart';
import 'model/currency.dart';
import 'model/my_copany.dart';
import 'model/requisites.dart';
import 'model/role_user.dart';
import 'model/roles.dart';
import 'model/user.dart';
import 'model/user_company.dart';
import 'model/category.dart';
import 'model/subcategory.dart';
import 'model/characteristics.dart';
import 'model/data_type.dart';
import 'model/pre_values.dart';
import 'model/product.dart';
import 'model/product_charateristics.dart';


class AppService extends ApplicationChannel {
  late final ManagedContext managedContext;

  Future prepare() {
    final persistentStore = _initDatabase();

    managedContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);

    checkRoles();

    checkDataType();

    checkCurrency();

    checkStatus();

    return super.prepare();
  }

  void checkRoles() async {
    /*final qFindRole = Query<Roles>(managedContext)
      ..where((element) => element.roleName).equalTo('admin')
      ..returningProperties(
        (element) => [element.id],
      );
    final findRole = await qFindRole.fetchOne();

    if (findRole == null) {
      final qCreateRole = Query<Roles>(managedContext)
        ..values.roleName = 'admin';

      await qCreateRole.insert();
    }*/
    List roles = ["admin", "user"];
    List rolesName = [];

    final List<Roles> listRoles =
        await Query<Roles>(managedContext).fetch();

    for(int i = 0; i < listRoles.length; i++)
    {
      rolesName.add(listRoles[i].roleName);
    }

    for (String roleName in roles) {
      if (!rolesName.contains(roleName)) {
        final qCreateRole = Query<Roles>(managedContext)
          ..values.roleName = roleName;
        await qCreateRole.insert();
      }
    }
  }

  void checkDataType() async {
    List dataTypes = ["Целое число", "Число с запятой", "Строка", "Дата"];
    List dataTypesName = [];

    final List<DataType> listDataTypes =
        await Query<DataType>(managedContext).fetch();

    for(int i = 0; i < listDataTypes.length; i++)
    {
      dataTypesName.add(listDataTypes[i].typeName);
    }

    for (String typeName in dataTypes) {
      if (!dataTypesName.contains(typeName)) {
        final qCreateDataType = Query<DataType>(managedContext)
          ..values.typeName = typeName;
        await qCreateDataType.insert();
      }
    }
  }

  void checkStatus() async {
    List statuses = ["Ожидает оформления"];
    List statusesName = [];

    final List<Status> listStatuses =
        await Query<Status>(managedContext).fetch();

    for(int i = 0; i < listStatuses.length; i++)
    {
      statusesName.add(listStatuses[i].statusName);
    }

    for (String statusName in statuses) {
      if (!statusesName.contains(statusName)) {
        final qCreateStatus = Query<Status>(managedContext)
          ..values.statusName = statusName;
        await qCreateStatus.insert();
      }
    }
  }

  void checkCurrency() async{

    final List<Currency> list = await Query<Currency>(managedContext).fetch();

    if (list.isEmpty)
    {
      final qCreateCurrency = Query<Currency>(managedContext)
          ..values.currencyName = 'руб';
        await qCreateCurrency.insert();
    }
  }

  @override
  Controller get entryPoint => Router()
    ..route('token/[:refresh]').link(
      () => AppAuthContoller(managedContext),
    )
    ..route('myCompany/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppCompanyController(managedContext))
    ..route('requisites/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppRequisitesController(managedContext))
    ..route('allRequisites/[:idCompany]')
        .link(AppTokenContoller.new)!
        .link(() => AppAllRequisitesController(managedContext))
    ..route('addresses/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppAddressesController(managedContext))
    ..route('allAddresses/[:idCompany]')
        .link(AppTokenContoller.new)!
        .link(() => AppAllAddressesController(managedContext))
    ..route('category/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppCategoryController(managedContext))
    ..route('allCategory/[:idCompany]')
        .link(() => AppAllCategoryController(managedContext))
    ..route('subcategory/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppSubcategoryController(managedContext))
    ..route('allSubcategory/[:idCategory]')
        .link(() => AppAllSubcategoryController(managedContext))
    ..route('characteristics/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppCharacteristicsController(managedContext))
    ..route('allCharacteristics/[:idSubcategory]')
        .link(() => AppAllCharacteristicsController(managedContext))
    ..route('pre_values/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppPreValuesController(managedContext))
    ..route('allPre_values/[:idCharacteristics]')
        .link(() => AppAllPreValuesController(managedContext))
    ..route('allData_type')
        .link(() => AppAllDataTypeController(managedContext))
    ..route('data_type/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppDataTypeController(managedContext))
    ..route('allProduct/[:idSubcategory]')
        .link(() => AppAllProductController(managedContext))
    ..route('product/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppProductController(managedContext))
    ..route('allCurrency')
        .link(() => AppAllCurrencyController(managedContext))
    ..route('currency/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppCurrencyController(managedContext))
    ..route('allProduct_photos/[:idProduct]')
        .link(() => AppAllProductPhotosController(managedContext))
    ..route('product_photos/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppProductPhotosController(managedContext))
    ..route('allProduct_characteristics/[:idProduct]')
        .link(() => AppAllProductCharacteristicsController(managedContext))
    ..route('product_characteristics/[:id]')
        .link(AppTokenContoller.new)!
        .link(() => AppProductCharacteristicsController(managedContext))
    ..route('selectable_characteristics')
        .link(AppTokenContoller.new)!
        .link(() => AppSelectableCharacteristicsController(managedContext))
    ..route('order/[:id]')
        //.link(AppTokenContoller.new)!
        .link(() => AppOrderController(managedContext));

  PersistentStore _initDatabase() {
    final username = Platform.environment['DB_USERNAME'] ?? 'postgres';
    final password = Platform.environment['DB_PASSWORD'] ?? '1';
    final host = Platform.environment['DB_HOST'] ?? '127.0.0.1';
    final port = int.parse(Platform.environment['DB_PORT'] ?? '5432');
    final databaseName = Platform.environment['DB_NAME'] ?? 'db_vepr';
    return PostgreSQLPersistentStore(
        username, password, host, port, databaseName);
  }
}
