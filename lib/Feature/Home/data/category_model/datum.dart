import 'sub_cat.dart';

class Datummms {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;
  List<SubCat>? subCat;

  Datummms({
    this.id,
    this.ord,
    this.type,
    this.parentId,
    this.name,
    this.img,
    this.details,
    this.subCat,
  });

  factory Datummms.fromJson(Map<String, dynamic> json) => Datummms(
        id: json['id'] as int?,
        ord: json['ord'] as int?,
        type: json['type'] as String?,
        parentId: json['parent_id'] as int?,
        name: json['name'] as String?,
        img: json['img'] as String?,
        details: json['details'] as String?,
        subCat: (json['sub_cat'] as List<dynamic>?)
            ?.map((e) => SubCat.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ord': ord,
        'type': type,
        'parent_id': parentId,
        'name': name,
        'img': img,
        'details': details,
        'sub_cat': subCat?.map((e) => e.toJson()).toList(),
      };
}
