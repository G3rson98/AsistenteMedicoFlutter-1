import 'dart:convert';

DiagnosisQuery diagnosisQueryFromJson(String str) => DiagnosisQuery.fromJson(json.decode(str));

String diagnosisQueryToJson(DiagnosisQuery data) => json.encode(data.toJson());

class DiagnosisQuery {
    DiagnosisQuery({
        this.sex,
        this.age,
        this.evidence,
    });

    String sex;
    int age;
    List<Evidence> evidence;

    factory DiagnosisQuery.fromJson(Map<String, dynamic> json) => DiagnosisQuery(
        sex: json["sex"],
        age: json["age"],
        evidence: List<Evidence>.from(json["evidence"].map((x) => Evidence.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sex": sex,
        "age": age,
        "evidence": List<dynamic>.from(evidence.map((x) => x.toJson())),
    };
}

class Evidence {
    Evidence({
        this.id,
        this.choiceId,
    });

    String id;
    String choiceId;

    factory Evidence.fromJson(Map<String, dynamic> json) => Evidence(
        id: json["id"],
        choiceId: json["choice_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "choice_id": choiceId,
    };
}
