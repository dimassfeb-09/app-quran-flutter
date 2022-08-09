// To parse this JSON data, do
//
//     final detailSurah = detailSurahFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailSurah detailSurahFromJson(String str) =>
    DetailSurah.fromJson(json.decode(str));

String detailSurahToJson(DetailSurah data) => json.encode(data.toJson());

class DetailSurah {
  DetailSurah({
    required this.id,
    required this.verseNumber,
    required this.chapterId,
    required this.verseKey,
    required this.textIndopak,
    required this.juzNumber,
    required this.hizbNumber,
    required this.rubElHizbNumber,
    required this.sajdahNumber,
    required this.pageNumber,
    required this.sajdah,
    required this.textMadani,
    required this.words,
    required this.audio,
    required this.translations,
  });

  int id;
  int verseNumber;
  int chapterId;
  String verseKey;
  String textIndopak;
  int juzNumber;
  int hizbNumber;
  int rubElHizbNumber;
  dynamic sajdahNumber;
  int pageNumber;
  dynamic sajdah;
  String textMadani;
  List<Word> words;
  DetailSurahAudio audio;
  List<TranslationElement> translations;

  factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        id: json["id"],
        verseNumber: json["verse_number"],
        chapterId: json["chapter_id"],
        verseKey: json["verse_key"],
        textIndopak: json["text_indopak"],
        juzNumber: json["juz_number"],
        hizbNumber: json["hizb_number"],
        rubElHizbNumber: json["rub_el_hizb_number"],
        sajdahNumber: json["sajdah_number"],
        pageNumber: json["page_number"],
        sajdah: json["sajdah"],
        textMadani: json["text_madani"],
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
        audio: DetailSurahAudio.fromJson(json["audio"]),
        translations: List<TranslationElement>.from(
            json["translations"].map((x) => TranslationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "verse_number": verseNumber,
        "chapter_id": chapterId,
        "verse_key": verseKey,
        "text_indopak": textIndopak,
        "juz_number": juzNumber,
        "hizb_number": hizbNumber,
        "rub_el_hizb_number": rubElHizbNumber,
        "sajdah_number": sajdahNumber,
        "page_number": pageNumber,
        "sajdah": sajdah,
        "text_madani": textMadani,
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
        "audio": audio.toJson(),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class DetailSurahAudio {
  DetailSurahAudio({
    required this.url,
    required this.duration,
    required this.segments,
    required this.format,
  });

  String url;
  int duration;
  List<List<int>> segments;
  String format;

  factory DetailSurahAudio.fromJson(Map<String, dynamic> json) =>
      DetailSurahAudio(
        url: json["url"],
        duration: json["duration"],
        segments: List<List<int>>.from(
            json["segments"].map((x) => List<int>.from(x.map((x) => x)))),
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "duration": duration,
        "segments": List<dynamic>.from(
            segments.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "format": format,
      };
}

class TranslationElement {
  TranslationElement({
    required this.id,
    required this.languageName,
    required this.text,
    required this.resourceName,
    required this.resourceId,
  });

  int id;
  LanguageName? languageName;
  String text;
  String resourceName;
  int resourceId;

  factory TranslationElement.fromJson(Map<String, dynamic> json) =>
      TranslationElement(
        id: json["id"],
        languageName: languageNameValues.map[json["language_name"]],
        text: json["text"],
        resourceName: json["resource_name"],
        resourceId: json["resource_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_name": languageNameValues.reverse[languageName],
        "text": text,
        "resource_name": resourceName,
        "resource_id": resourceId,
      };
}

enum LanguageName { INDONESIAN, ENGLISH }

final languageNameValues = EnumValues({
  "english": LanguageName.ENGLISH,
  "indonesian": LanguageName.INDONESIAN,
});

class Word {
  Word({
    required this.id,
    required this.position,
    required this.textIndopak,
    required this.verseKey,
    required this.lineNumber,
    required this.pageNumber,
    required this.code,
    required this.className,
    required this.textMadani,
    required this.charType,
    required this.transliteration,
    required this.translation,
    required this.audio,
  });

  int id;
  int position;
  String textIndopak;
  String verseKey;
  int lineNumber;
  int pageNumber;
  String code;
  String className;
  String textMadani;
  String charType;
  TransliterationClass transliteration;
  TransliterationClass translation;
  WordAudio audio;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["id"],
        position: json["position"],
        textIndopak: json["text_indopak"],
        verseKey: json["verse_key"],
        lineNumber: json["line_number"],
        pageNumber: json["page_number"],
        code: json["code"],
        className: json["class_name"],
        textMadani: json["text_madani"],
        charType: json["char_type"],
        transliteration: TransliterationClass.fromJson(json["transliteration"]),
        translation: TransliterationClass.fromJson(json["translation"]),
        audio: WordAudio.fromJson(json["audio"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "text_indopak": textIndopak,
        "verse_key": verseKey,
        "line_number": lineNumber,
        "page_number": pageNumber,
        "code": code,
        "class_name": className,
        "text_madani": textMadani,
        "char_type": charType,
        "transliteration": transliteration.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
      };
}

class WordAudio {
  WordAudio({
    required this.url,
  });

  String url;

  factory WordAudio.fromJson(Map<String, dynamic> json) => WordAudio(
        url: json["url"] == null ? '' : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? '' : url,
      };
}

class TransliterationClass {
  TransliterationClass({
    required this.languageName,
    required this.text,
  });

  LanguageName? languageName;
  String text;

  factory TransliterationClass.fromJson(Map<String, dynamic> json) =>
      TransliterationClass(
        languageName: languageNameValues.map[json["language_name"]],
        text: json["text"] == null ? '' : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "language_name": languageNameValues.reverse[languageName],
        "text": text == null ? '' : text,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
