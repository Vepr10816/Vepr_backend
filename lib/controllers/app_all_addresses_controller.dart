import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:vepr_backend/model/addresses.dart';
import 'package:vepr_backend/model/my_copany.dart';


import '../model/requisites.dart';
import '../model/response.dart';
import '../utils/app_response.dart';
import '../utils/app_utils.dart';

class AppAllAddressesController extends ResourceController {
  AppAllAddressesController(this.managedContext);

  final ManagedContext managedContext;


  @Operation.get("idCompany")
  Future<Response> getFullAddresses(@Bind.path("idCompany") int idCompany,
  @Bind.header(HttpHeaders.authorizationHeader) String header) 
  async {
    try {

      final qGetAddresses = Query<Addresses>(managedContext)..where((x) => x.mycompany?.id).equalTo(idCompany);

      final List<Addresses> list = await qGetAddresses.fetch();

      if (list.isEmpty)
      {
        return Response.notFound(body: ModelResponse(data: [], message: "Нет ни одного адреса"));
      }

      return Response.ok(list);
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }
}