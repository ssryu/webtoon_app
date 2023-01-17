import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final uri = Uri.parse("$baseUrl/$today");

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Error();
    }

    final List<dynamic> webtoons = jsonDecode(response.body);
    final List<WebtoonModel> webtoonInstances = [];
    for (final webtoon in webtoons) {
      final toon = WebtoonModel.fromJson(webtoon);
      webtoonInstances.add(toon);
    }

    return webtoonInstances;
  }
}
