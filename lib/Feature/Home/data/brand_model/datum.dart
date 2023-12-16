class DatumMmm {
  int? id;
  int? ord;
  String? type;
  int? parentId;
  String? name;
  String? img;
  String? details;

  DatumMmm({
    this.id,
    this.ord,
    this.type,
    this.parentId,
    this.name,
    this.img,
    this.details,
  });

  factory DatumMmm.fromJson(Map<String, dynamic> json) => DatumMmm(
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
