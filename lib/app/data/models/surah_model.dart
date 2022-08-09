// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SurahModels surahFromJson(String str) => SurahModels.fromJson(json.decode(str));

String surahToJson(SurahModels data) => json.encode(data.toJson());

class SurahModels {
  SurahModels({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.chapterNumber,
    required this.translatedName,
  });

  int id;
  String revelationPlace;
  int revelationOrder;
  bool bismillahPre;
  String nameSimple;
  String nameComplex;
  String nameArabic;
  int versesCount;
  List<int> pages;
  int chapterNumber;
  TranslatedName translatedName;

  factory SurahModels.fromJson(Map<String, dynamic> json) => SurahModels(
        id: json["id"],
        revelationPlace: json["revelation_place"],
        revelationOrder: json["revelation_order"],
        bismillahPre: json["bismillah_pre"],
        nameSimple: json["name_simple"],
        nameComplex: json["name_complex"],
        nameArabic: json["name_arabic"],
        versesCount: json["verses_count"],
        pages: List<int>.from(json["pages"].map((x) => x)),
        chapterNumber: json["chapter_number"],
        translatedName: TranslatedName.fromJson(json["translated_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "revelation_place": revelationPlace,
        "revelation_order": revelationOrder,
        "bismillah_pre": bismillahPre,
        "name_simple": nameSimple,
        "name_complex": nameComplex,
        "name_arabic": nameArabic,
        "verses_count": versesCount,
        "pages": List<dynamic>.from(pages.map((x) => x)),
        "chapter_number": chapterNumber,
        "translated_name": translatedName.toJson(),
      };
}

class TranslatedName {
  TranslatedName({
    required this.languageName,
    required this.name,
  });

  String languageName;
  String name;

  factory TranslatedName.fromJson(Map<String, dynamic> json) => TranslatedName(
        languageName: json["language_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language_name": languageName,
        "name": name,
      };
}
