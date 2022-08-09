import 'package:get/get.dart';

import '../modules/DetailJuz/bindings/detail_juz_binding.dart';
import '../modules/DetailJuz/views/detail_juz_view.dart';
import '../modules/DetailSurah/bindings/detail_surah_binding.dart';
import '../modules/DetailSurah/views/detail_surah_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/surah/bindings/surah_binding.dart';
import '../modules/surah/views/surah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SURAH,
      page: () => const SurahView(),
      binding: SurahBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_JUZ,
      page: () => const DetailJuzView(),
      binding: DetailJuzBinding(),
    ),
  ];
}
