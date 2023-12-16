import 'color.dart';
import 'size.dart';

class ProductAttribute {
  int? id;
  int? ord;
  int? productId;
  int? sizeId;
  int? colorId;
  String? amount;
  int? newQuantity;
  int? allQuantity;
  dynamic price;
  dynamic img;
  String? isActive;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userIp;
  dynamic userPcInfo;
  Size? size;
  Color? color;

  ProductAttribute({
    this.id,
    this.ord,
    this.productId,
    this.sizeId,
    this.colorId,
    this.amount,
    this.newQuantity,
    this.allQuantity,
    this.price,
    this.img,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userIp,
    this.userPcInfo,
    this.size,
    this.color,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json['id'] as int?,
      ord: json['ord'] as int?,
      productId: json['product_id'] as int?,
      sizeId: json['size_id'] as int?,
      colorId: json['color_id'] as int?,
      amount: json['amount'] as String?,
      newQuantity: json['new_quantity'] as int?,
      allQuantity: json['all_quantity'] as int?,
      price: json['price'] as dynamic,
      img: json['img'] as dynamic,
      isActive: json['is_active'] as String?,
      deletedAt: json['deleted_at'] as dynamic,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      userIp: json['user_ip'] as dynamic,
      userPcInfo: json['user_pc_info'] as dynamic,
      size: json['size'] == null
          ? null
          : Size.fromJson(json['size'] as Map<String, dynamic>),
      color: json['color'] == null
          ? null
          : Color.fromJson(json['color'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ord': ord,
        'product_id': productId,
        'size_id': sizeId,
        'color_id': colorId,
        'amount': amount,
        'new_quantity': newQuantity,
        'all_quantity': allQuantity,
        'price': price,
        'img': img,
        'is_active': isActive,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_ip': userIp,
        'user_pc_info': userPcInfo,
        'size': size?.toJson(),
        'color': color?.toJson(),
      };
}
