class Country {
  int? id;
  String? type;
  int? parentId;
  int? ord;
  String? name;
  String? nameEn;
  dynamic img;
  dynamic imgThumbnail;
  dynamic flag;
  String? currencyCode;
  String? currencyCodeEn;
  String? countryCode;
  String? dailCode;
  int? deliveryPrice;
  int? fastDeliveryPrice;
  int? numViews;
  String? isActive;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userIp;
  dynamic userPcInfo;
  int? userAdded;

  Country({
    this.id,
    this.type,
    this.parentId,
    this.ord,
    this.name,
    this.nameEn,
    this.img,
    this.imgThumbnail,
    this.flag,
    this.currencyCode,
    this.currencyCodeEn,
    this.countryCode,
    this.dailCode,
    this.deliveryPrice,
    this.fastDeliveryPrice,
    this.numViews,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.userIp,
    this.userPcInfo,
    this.userAdded,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'] as int?,
        type: json['type'] as String?,
        parentId: json['parent_id'] as int?,
        ord: json['ord'] as int?,
        name: json['name'] as String?,
        nameEn: json['name_en'] as String?,
        img: json['img'] as dynamic,
        imgThumbnail: json['img_thumbnail'] as dynamic,
        flag: json['flag'] as dynamic,
        currencyCode: json['currency_code'] as String?,
        currencyCodeEn: json['currency_code_en'] as String?,
        countryCode: json['country_code'] as String?,
        dailCode: json['dail_code'] as String?,
        deliveryPrice: json['delivery_price'] as int?,
        fastDeliveryPrice: json['fast_delivery_price'] as int?,
        numViews: json['num_views'] as int?,
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
        userAdded: json['user_added'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'parent_id': parentId,
        'ord': ord,
        'name': name,
        'name_en': nameEn,
        'img': img,
        'img_thumbnail': imgThumbnail,
        'flag': flag,
        'currency_code': currencyCode,
        'currency_code_en': currencyCodeEn,
        'country_code': countryCode,
        'dail_code': dailCode,
        'delivery_price': deliveryPrice,
        'fast_delivery_price': fastDeliveryPrice,
        'num_views': numViews,
        'is_active': isActive,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_ip': userIp,
        'user_pc_info': userPcInfo,
        'user_added': userAdded,
      };
}
