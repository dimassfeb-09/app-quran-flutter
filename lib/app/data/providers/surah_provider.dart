import 'dart:convert';

import 'package:get/get.dart';

import '../models/surah_model.dart';

class SurahProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Surah.fromJson(map);
      if (map is List) return map.map((item) => Surah.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
