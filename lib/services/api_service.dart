import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon_detail_model.dart';
import 'package:webtoon_app/models/webtoon_episode_model.dart';
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

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.parse("$baseUrl/$id");

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Error();
    }

    final Map<String, dynamic> webtoon = jsonDecode(response.body);
    return WebtoonDetailModel.fromJson(webtoon);
  }

  static Future<List<WebtoonEpisodeModel>> getLatest10EpisodesById(
      String id) async {
    final uri = Uri.parse("$baseUrl/$id/episodes");

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Error();
    }

    final List<WebtoonEpisodeModel> episodes = [];
    for (final episodeJson in jsonDecode(response.body)) {
      episodes.add(WebtoonEpisodeModel.fromJson(episodeJson));
    }
    return episodes;
  }
}
