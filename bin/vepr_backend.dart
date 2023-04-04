import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:vepr_backend/model/roles.dart';
import 'package:vepr_backend/vepr_backend.dart';

void main(List<String> arguments) async{
  final port = int.parse(Platform.environment["PORT"] ?? '8081');

  final service = Application<AppService>()..options.port = port;

  await service.start(numberOfInstances: 3, consoleLogging: true);
}

