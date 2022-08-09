import 'dart:convert';

import 'package:app_quran/app/data/models/juz_model.dart';
import 'package:app_quran/app/data/models/surah_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:http/retry.dart';

class HomeController extends GetxController {
  RxInt selectedMenu = 0.obs;
  RxString lastReadTitle = "".obs;
  RxString lastReadArab = "".obs;

  Future<List<SurahModels>> getSurah() async {
    Uri url = Uri.parse("http://api.quran.com/api/v3/chapters?language=id");
    final response = await http.get(url);
    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['chapters'];

    List<SurahModels> allSurah = [];

    fetchData.forEach((element) {
      allSurah.add(SurahModels.fromJson(element));
    });

    return allSurah;
  }

  Future<List<JuzModels>> getJuz() async {
    List<JuzModels> allJuz = [];
    for (var i = 1; i <= 30; i++) {
      Uri url = Uri.parse("http://api.alquran.cloud/v1/juz/$i");
      var response = await http.get(url);

      Map<String, dynamic> fetchData =
          (jsonDecode(response.body) as Map<String, dynamic>)['data'];

      JuzModels juzModels = JuzModels.fromJson(fetchData);
      allJuz.add(juzModels);
    }
    print(allJuz.length);
    return allJuz;
  }
}
