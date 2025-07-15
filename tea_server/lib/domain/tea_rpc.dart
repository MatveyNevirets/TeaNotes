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
        teaRepository.addTea(
          Tea(
            title: "Золотой бык",
            description:
                '''Мощный и яркий молодой шэн пуэр с интересным профилем и хорошим балансом от известной чайной фабрики Син Вэнь. Хорошо сбалансирован для молодого шэна.
Аромат
Медово-копчёный, цветочный. Пьянящий, сладкий аромат из пустой горячий пиалы.
Вкус
Мягкий, ровный, сладко-сухофруктовый, с нотками цветов, чернослива, кураги и слегка пропечёной травы. Очень приятное, объёмное послевкусие, тёплое и уютное.
Воздействие
Мощное, тонизирующее, освежающее.''',
            imagePath: "assets/images/golden_bull.jpg",
            pricePerGram: 16,
            age: 4,
            type: "Шен Пуэр",
            brewingTemperature: "95-85C",
            countOfSpills: 10,
            gatheringYear: 2021,
            gatheringPlace: "Фабрика Синь Вэнь, уезд Юндэ, округ Линьцан, провинция Юньнань, Китай.",
          ),
        );

        teaRepository.addTea(
          Tea(
            title: "Гунтин Зелёное Дерево",
            description: '''Премиальный зрелый гунтин из отборного сырья.
Слово Гунтин (кит. 宫廷, «Дворцовый») указывает на категорию сырья, т.е. размер листа. Такие листья мелкие, и при этом цельные, а не резанные. В гунтинах нежные листочки обязательно перемежаются большим количеством чайных почек. Вместе они обеспечивают сильный вкус и мощное воздействие.

Аромат
Сладковатый, с нотами древесины и орехов.

Вкус
Густой, бархатистый, плотный и мягкий, с доминирующей шоколадно-ореховой тематикой. Послевкусие обволакивающее, сладкое, продолжительное.

Воздействие
Хорошо тонизирует, согревает, воодушевляет.''',
            imagePath: "assets/images/green_tree.jpg",
            pricePerGram: 12,
            age: 8,
            type: "Шу Пуэр",
            brewingTemperature: "95-85С",
            countOfSpills: 6,
            gatheringYear: 2017,
            gatheringPlace:
                "Фабрика Баньчжан в уезде Мэнхай (кит. 勐海縣班章), горы Буланшань, уезд Мэнхай, округ Сишуанбаньна, провинция Юньнань, Китай.",
          ),
        );
        teaRepository.addTea(
          Tea(
            title: "Гунтин Зелёное Дерево",
            description: '''Премиальный зрелый гунтин из отборного сырья.
Слово Гунтин (кит. 宫廷, «Дворцовый») указывает на категорию сырья, т.е. размер листа. Такие листья мелкие, и при этом цельные, а не резанные. В гунтинах нежные листочки обязательно перемежаются большим количеством чайных почек. Вместе они обеспечивают сильный вкус и мощное воздействие.

Аромат
Сладковатый, с нотами древесины и орехов.

Вкус
Густой, бархатистый, плотный и мягкий, с доминирующей шоколадно-ореховой тематикой. Послевкусие обволакивающее, сладкое, продолжительное.

Воздействие
Хорошо тонизирует, согревает, воодушевляет.''',
            imagePath: "assets/images/green_tree.jpg",
            pricePerGram: 12,
            age: 8,
            type: "Шу Пуэр",
            brewingTemperature: "95-85С",
            countOfSpills: 6,
            gatheringYear: 2017,
            gatheringPlace:
                "Фабрика Баньчжан в уезде Мэнхай (кит. 勐海縣班章), горы Буланшань, уезд Мэнхай, округ Сишуанбаньна, провинция Юньнань, Китай.",
          ),
        );
        teaRepository.addTea(
          Tea(
            title: "Золотой бык",
            description:
                '''Мощный и яркий молодой шэн пуэр с интересным профилем и хорошим балансом от известной чайной фабрики Син Вэнь. Хорошо сбалансирован для молодого шэна.
Аромат
Медово-копчёный, цветочный. Пьянящий, сладкий аромат из пустой горячий пиалы.
Вкус
Мягкий, ровный, сладко-сухофруктовый, с нотками цветов, чернослива, кураги и слегка пропечёной травы. Очень приятное, объёмное послевкусие, тёплое и уютное.
Воздействие
Мощное, тонизирующее, освежающее.''',
            imagePath: "assets/images/golden_bull.jpg",
            pricePerGram: 16,
            age: 4,
            type: "Шен Пуэр",
            brewingTemperature: "95-85C",
            countOfSpills: 10,
            gatheringYear: 2021,
            gatheringPlace: "Фабрика Синь Вэнь, уезд Юндэ, округ Линьцан, провинция Юньнань, Китай.",
          ),
        );

        // ignore: prefer_function_declarations_over_variables
        handler(Request request) async {
          log("Request with method ${request.method} and path ${request.requestedUri.path}");
          if (request.method == 'GET' && request.requestedUri.path == "/teas") {
            final queryParams = request.requestedUri.queryParameters;
            final typeFilter = queryParams['type'];

            final teaList = await teaRepository.getTeas(typeFilter);

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
