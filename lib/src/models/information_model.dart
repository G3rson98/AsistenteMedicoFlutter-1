// To parse this JSON data, do
//
//     final informationModel = informationModelFromJson(jsonString);

import 'dart:convert';

InformationModel informationModelFromJson(String str) => InformationModel.fromJson(json.decode(str));

String informationModelToJson(InformationModel data) => json.encode(data.toJson());

class InformationModel {
    InformationModel({
        this.id,
        this.name,
        this.commonName,
        this.sexFilter,
        this.categories,
        this.prevalence,
        this.acuteness,
        this.severity,
        this.extras,
        this.triageLevel,
    });

    String id;
    String name;
    String commonName;
    String sexFilter;
    List<String> categories;
    String prevalence;
    String acuteness;
    String severity;
    Extras extras;
    String triageLevel;

    factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
        id: json["id"],
        name: json["name"],
        commonName: json["common_name"],
        sexFilter: json["sex_filter"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        prevalence: json["prevalence"],
        acuteness: json["acuteness"],
        severity: json["severity"],
        extras: Extras.fromJson(json["extras"]),
        triageLevel: json["triage_level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "common_name": commonName,
        "sex_filter": sexFilter,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "prevalence": prevalence,
        "acuteness": acuteness,
        "severity": severity,
        "extras": extras.toJson(),
        "triage_level": triageLevel,
    };
}

class Extras {
    Extras({
        this.icd10Code,
        this.hint,
    });

    String icd10Code;
    String hint;

    factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        icd10Code: json["icd10_code"],
        hint: json["hint"],
    );

    Map<String, dynamic> toJson() => {
        "icd10_code": icd10Code,
        "hint": hint,
    };
}
