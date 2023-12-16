class DatumSlider {
  int? id;
  int? ord;
  String? type;
  String? name;
  String? img;
  int? productId;
  int? catId;

  DatumSlider({
    this.id,
    this.ord,
    this.type,
    this.name,
    this.img,
    this.productId,
    this.catId,
  });

  factory DatumSlider.fromJson(Map<String, dynamic> json) => DatumSlider(
        id: json['id'] as int?,
        ord: json['ord'] as int?,
        type: json['type'] as String?,
        name: json['name'] as String?,
        img: json['img'] as String?,
        productId: json['product_id'] as int?,
        catId: json['cat_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ord': ord,
        'type': type,
        'name': name,
        'img': img,
        'product_id': productId,
        'cat_id': catId,
      };
}
