import 'dart:convert';

SintomasModel sintomasModelFromJson(String str) => SintomasModel.fromJson(json.decode(str));

String sintomasModelToJson(SintomasModel data) => json.encode(data.toJson());

class SintomasModel {
    SintomasModel({
        this.id,
        this.name,
        this.commonName,
        this.sexFilter,
        this.category,
        this.seriousness,
        this.extras,
        this.children,
        this.imageUrl,
        this.imageSource,
        this.parentId,
        this.parentRelation,
    });

    String id;
    String name;
    String commonName;
    String sexFilter;
    String category;
    String seriousness;
    Extras extras;
    List<Child> children;
    dynamic imageUrl;
    dynamic imageSource;
    dynamic parentId;
    dynamic parentRelation;

    factory SintomasModel.fromJson(Map<String, dynamic> json) => SintomasModel(
        id: json["id"],
        name: json["name"],
        commonName: json["common_name"],
        sexFilter: json["sex_filter"],
        category: json["category"],
        seriousness: json["seriousness"],
        extras: Extras.fromJson(json["extras"]),
        children: List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
        imageUrl: json["image_url"],
        imageSource: json["image_source"],
        parentId: json["parent_id"],
        parentRelation: json["parent_relation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "common_name": commonName,
        "sex_filter": sexFilter,
        "category": category,
        "seriousness": seriousness,
        "extras": extras.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "image_url": imageUrl,
        "image_source": imageSource,
        "parent_id": parentId,
        "parent_relation": parentRelation,
    };
}

class Child {
    Child({
        this.id,
        this.parentRelation,
    });

    String id;
    String parentRelation;

    factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        parentRelation: json["parent_relation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_relation": parentRelation,
    };
}

class Extras {
    Extras();

    factory Extras.fromJson(Map<String, dynamic> json) => Extras(
    );

    Map<String, dynamic> toJson() => {
    };
}
