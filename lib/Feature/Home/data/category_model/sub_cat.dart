class SubCat {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;

  SubCat({
    this.id,
    this.ord,
    this.type,
    this.parentId,
    this.name,
    this.img,
    this.details,
  });

  factory SubCat.fromJson(Map<String, dynamic> json) => SubCat(
        id: json['id'] as int?,
        ord: json['ord'] as int?,
        type: json['type'] as String?,
        parentId: json['parent_id'] as int?,
        name: json['name'] as String?,
        img: json['img'] as String?,
        details: json['details'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ord': ord,
        'type': type,
        'parent_id': parentId,
        'name': name,
        'img': img,
        'details': details,
      };
}
