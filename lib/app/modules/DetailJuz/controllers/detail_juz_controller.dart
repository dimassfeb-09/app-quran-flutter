import 'dart:convert';

import 'package:app_quran/app/data/models/juz_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailJuzController extends GetxController {
  Future<List<JuzModels>> getDetailJuz() async {
    List<JuzModels> allJuz = [];
    for (var i = 1; i <= 30; i++) {
      Uri url = Uri.parse("http://api.alquran.cloud/v1/juz/$i");
      var response = await http.get(url);

      Map<String, dynamic> fetchData =
          (jsonDecode(response.body) as Map<String, dynamic>)['data'];

      JuzModels juzModels = JuzModels.fromJson(fetchData);
      allJuz.add(juzModels);
    }
    print(allJuz[1]);
    return allJuz;
  }
}
