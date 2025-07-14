import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:server/data/tea_database.dart';
import 'package:server/data/tea_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class TeaRpc {
  static Future<void> startServer() async {
    final teaDatabaseInstance = TeaDatabase.instance;
    final teaDatabase = await teaDatabaseInstance.teaDatabase;

    final teaRepository = TeaRepository(teaDatabase);

    runZonedGuarded(
      () async {
        // ignore: prefer_function_declarations_over_variables
        handler(Request request) async {
          if (request.method == 'GET' && request.requestedUri.path == "/teas") {
            log("Request with method ${request.method} and path ${request.requestedUri.path}");

            final teaList = await teaRepository.getTeas("Улун");

            final teaMap = teaList.map((tea) => tea.toMap());

            log(teaMap.toString());

            return Response.ok(jsonEncode({"hi": "huh"}));
          }

          return Response.notFound("Path not found");
        }

        var server = await io.serve(handler, 'localhost', 8080);
        log("Server has been started in port: ${server.port}");
      },
      (error, stack) {
        throw Exception("Error in start server proccess. Error: $error, and StackTrace: $stack");
      },
    );
  }
}
