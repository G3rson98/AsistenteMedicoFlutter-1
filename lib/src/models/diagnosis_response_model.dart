// To parse this JSON data, do
//
//     final diagnosisResponse = diagnosisResponseFromJson(jsonString);

import 'dart:convert';

DiagnosisResponse diagnosisResponseFromJson(String str) => DiagnosisResponse.fromJson(json.decode(str));

String diagnosisResponseToJson(DiagnosisResponse data) => json.encode(data.toJson());

class DiagnosisResponse {
    DiagnosisResponse({
        this.question,
        this.conditions,
        this.extras,
    });

    Question question;
    List<Condition> conditions;
    Extras extras;

    factory DiagnosisResponse.fromJson(Map<String, dynamic> json) => DiagnosisResponse(
        question: Question.fromJson(json["question"]),
        conditions: List<Condition>.from(json["conditions"].map((x) => Condition.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
    );

    Map<String, dynamic> toJson() => {
        "question": question.toJson(),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
        "extras": extras.toJson(),
    };
}

class Condition {
    Condition({
        this.id,
        this.name,
        this.commonName,
        this.probability,
    });

    String id;
    String name;
    String commonName;
    double probability;

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        id: json["id"],
        name: json["name"],
        commonName: json["common_name"],
        probability: json["probability"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "common_name": commonName,
        "probability": probability,
    };
}

class Extras {
    Extras();

    factory Extras.fromJson(Map<String, dynamic> json) => Extras(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Question {
    Question({
        this.type,
        this.text,
        this.items,
        this.extras,
    });

    String type;
    String text;
    List<Item> items;
    Extras extras;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        type: json["type"],
        text: json["text"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "extras": extras.toJson(),
    };
}

class Item {
    Item({
        this.id,
        this.name,
        this.choices,
    });

    String id;
    String name;
    List<Choice> choices;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    };
}

class Choice {
    Choice({
        this.id,
        this.label,
    });

    String id;
    String label;

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
    };
}
