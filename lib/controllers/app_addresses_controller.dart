import 'dart:io';
import 'package:conduit/conduit.dart';
import '../model/addresses.dart';
import '../utils/app_response.dart';

class AppAddressesController extends ResourceController {
  AppAddressesController(this.managedContext);

  final ManagedContext managedContext;

  @Operation.post()
  Future<Response> createAddresses(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.body() Addresses bodyAddresses
  ) async {
    try {

      final qCreateAddressesData = Query<Addresses>(managedContext)
        ..values.addressName = bodyAddresses.addressName
        ..values.mycompany!.id = bodyAddresses.idMycompany;

      await qCreateAddressesData.insert();

      return AppResponse.ok(message: 'Успешное создание адреса');
    } catch (error) {
      return AppResponse.serverError(error, message: 'Ошибка создания адреса');
    }
  }

  @Operation.put('id')
  Future<Response> updateAddresses(
      @Bind.header(HttpHeaders.authorizationHeader) String header,
      @Bind.path("id") int id,
      @Bind.body() Addresses bodyAddresses
  ) async {
    try {
      final requisite = await managedContext.fetchObjectWithID<Addresses>(id);
      if (requisite == null) {
        return AppResponse.ok(message: "адрес не найден");
      }
      final qUpdateAddresses = Query<Addresses>(managedContext)
        ..where((x) => x.id).equalTo(id)
       ..values.addressName = bodyAddresses.addressName
        ..values.mycompany!.id = bodyAddresses.idMycompany;
      await qUpdateAddresses.update();

      return AppResponse.ok(message: 'адрес обновлен');

    } catch (e) {
      return AppResponse.serverError(e);
    }
  }

  @Operation.get("id")
  Future<Response> getAddressesFromID(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int id,
  ) async {
    try {
      final requisite = await managedContext.fetchObjectWithID<Addresses>(id);
      if (requisite == null) {
        return AppResponse.ok(message: "Адрес не найден");
      }
      return Response.ok(requisite);
    } catch (error) {
      return AppResponse.serverError(error, message: "Ошибка получения адреса");
    }
  }


  @Operation.delete("id")
  Future<Response> deleteAddresses(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int id,
  ) async {
    try {
      final address = await managedContext.fetchObjectWithID<Addresses>(id);
      if (address == null) {
        return AppResponse.ok(message: "Адрес не найден");
      }
      final qDeleteAddresses = Query<Addresses>(managedContext)
        ..where((x) => x.id).equalTo(id);
      await qDeleteAddresses.delete();
      return AppResponse.ok(message: "Успешное удаление Адреса");
    } catch (error) {
      return AppResponse.serverError(error, message: "Ошибка удаления Адреса");
    }
  }

}