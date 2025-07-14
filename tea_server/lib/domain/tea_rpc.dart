import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:server/data/models/tea_model.dart';
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
          log("Request with method ${request.method} and path ${request.requestedUri.path}");
          if (request.method == 'GET' && request.requestedUri.path == "/teas") {
            final teaList = await teaRepository.getTeas(null);

            final teaMap = teaList.map((tea) => tea.toMap()).toList();

            return Response.ok(jsonEncode(teaMap), headers: {'Content-Type': 'application/json'});
          }

          if (request.method == "POST" && request.requestedUri.path == "/teas") {
            try {
              final jsonBody = await request.readAsString();

              final body = jsonDecode(jsonBody);

              final newTea = Tea.fromMap(body);

              teaRepository.addTea(newTea);

              return Response.ok({"Success": true});
            } catch (e) {
              return Response.internalServerError();
            }
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
