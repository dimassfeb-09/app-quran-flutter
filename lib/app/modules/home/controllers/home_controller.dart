import 'dart:convert';
import 'package:get/get.dart';
import 'package:app_quran/app/data/models/detailsurah_model.dart';
import 'package:app_quran/app/data/models/juz_model.dart';
import '../../../data/models/surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  Future<List<Surah>> getSurah() async {
    var response =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah"));

    List data = (jsonDecode(response.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<DetailSurah> getDetailSurah(String idDetailSurah) async {
    var response = await http
        .get(Uri.parse("https://api.quran.sutanlab.id/surah/$idDetailSurah"));

    Map<String, dynamic> data = jsonDecode(response.body)["data"];

    return DetailSurah.fromJson(data);
  }

  Future<List<Juz>> getJuz() async {
    List<Juz> allData = [];
    for (var i = 1; i <= 30; i++) {
      var response =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/juz/$i"));

      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>)["data"];

      allData.add(Juz.fromJson(data));
    }

    return allData;
  }

  Future<List<Juz>> getDetailJuz(String idDetailJuz) async {
    List<Juz> allData = [];

    for (var i = 1; i <= 30; i++) {
      var response = await http
          .get(Uri.parse("https://api.quran.sutanlab.id/juz/$idDetailJuz"));

      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>)["data"];

      allData.add(Juz.fromJson(data));
    }

    print("total ${allData.length}");
    return allData;
  }
}
