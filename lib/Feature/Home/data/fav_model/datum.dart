import 'product.dart';

class Datum {
  int? id;
  int? favoId;
  int? priceWithDiscount;
  Product? product;

  Datum({this.id, this.favoId, this.priceWithDiscount, this.product});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        favoId: json['favo_id'] as int?,
        priceWithDiscount: json['price_with_discount'] as int?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'favo_id': favoId,
        'price_with_discount': priceWithDiscount,
        'product': product?.toJson(),
      };
}
