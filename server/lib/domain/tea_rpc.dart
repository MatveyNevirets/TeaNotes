import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class TeaRpc {
  static startServer() async {
    // ignore: prefer_function_declarations_over_variables
    final handler = (Request request) async {
      if (request.method == 'GET' && request.requestedUri.path == "/teas") {
        log("Request with method ${request.method} and path ${request.requestedUri.path}");
        return Response.ok(jsonEncode(["hi", "hello", "\n", "what's up?"]));
      }

      return Response.notFound("Path not found");
    };

    var server = await io.serve(handler, 'localhost', 8080);
    log("Server has been started in port: ${server.port}");
  }
}
