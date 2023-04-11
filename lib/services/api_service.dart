import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtooon_viewer/models/webtoon_detail_model.dart';
import 'package:webtooon_viewer/models/webtoon_episode_model.dart';
import 'package:webtooon_viewer/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = 'today';
  static const String episodes = "episodes";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    //future타입은 요청이 처리될때까지 지연이 존재할때 사용한다.
    List<WebtoonModel> webtoonInstance = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstance.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstance;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      final webtoon = jsonDecode(responce.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final List<WebtoonEpisodeModel> episodeInstances = [];
    final url = Uri.parse('$baseUrl/$id/$episodes');
    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(responce.body);
      for (var episode in episodes) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    }
    throw Error();
  }
}
