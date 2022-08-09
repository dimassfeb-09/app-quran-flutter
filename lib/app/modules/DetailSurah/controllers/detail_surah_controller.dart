import 'dart:convert';

import 'package:app_quran/app/data/models/descriptionSurah_models.dart';
import 'package:app_quran/app/data/models/detailsurah_model.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  Future<List<DetailSurah>> getDetailSurah({required int id}) async {
    Uri url = Uri.parse(
        "http://api.quran.com/api/v3/chapters/$id/verses?recitation=1&translations=174&text_type=words&language=id");
    final response = await http.get(url);

    List<DetailSurah> allData = [];

    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['verses'];

    fetchData.forEach((element) {
      allData.add(DetailSurah.fromJson(element));
    });

    return allData;
  }
}
