// To parse this JSON data, do
//
//     final translateModel = translateModelFromJson(jsonString);

import 'dart:convert';

TranslateModel translateModelFromJson(String str) => TranslateModel.fromJson(json.decode(str));

String translateModelToJson(TranslateModel data) => json.encode(data.toJson());

class TranslateModel {
    TranslateModel({
        this.data,
    });

    Data data;

    factory TranslateModel.fromJson(Map<String, dynamic> json) => TranslateModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.translations,
    });

    List<Translation> translations;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
    };
}

class Translation {
    Translation({
        this.translatedText,
        this.detectedSourceLanguage,
    });

    String translatedText;
    String detectedSourceLanguage;

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        translatedText: json["translatedText"],
        detectedSourceLanguage: json["detectedSourceLanguage"],
    );

    Map<String, dynamic> toJson() => {
        "translatedText": translatedText,
        "detectedSourceLanguage": detectedSourceLanguage,
    };
}
