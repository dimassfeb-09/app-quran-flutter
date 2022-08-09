// To parse this JSON data, do
//
//     final detailDescriptionSurah = detailDescriptionSurahFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailDescriptionSurah detailDescriptionSurahFromJson(String str) =>
    DetailDescriptionSurah.fromJson(json.decode(str));

String detailDescriptionSurahToJson(DetailDescriptionSurah data) =>
    json.encode(data.toJson());

class DetailDescriptionSurah {
  DetailDescriptionSurah({
    required this.chapterId,
    required this.languageName,
    required this.shortText,
    required this.source,
    required this.text,
  });

  int chapterId;
  String languageName;
  String shortText;
  String source;
  String text;

  factory DetailDescriptionSurah.fromJson(Map<String, dynamic> json) =>
      DetailDescriptionSurah(
        chapterId: json["chapter_id"],
        languageName: json["language_name"],
        shortText: json["short_text"],
        source: json["source"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId,
        "language_name": languageName,
        "short_text": shortText,
        "source": source,
        "text": text,
      };
}
