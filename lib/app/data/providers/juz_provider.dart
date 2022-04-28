import 'package:get/get.dart';

import '../models/juz_model.dart';

class JuzProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Juz.fromJson(map);
      if (map is List) return map.map((item) => Juz.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Juz?> getJuz(int id) async {
    final response = await get('juz/$id');
    return response.body;
  }

  Future<Response<Juz>> postJuz(Juz juz) async => await post('juz', juz);
  Future<Response> deleteJuz(int id) async => await delete('juz/$id');
}
