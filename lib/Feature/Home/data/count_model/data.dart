import 'country.dart';

class Data {
  int? userId;
  List<Country>? countries;
  String? mobile;
  dynamic orderId;
  String? email;

  Data({
    this.userId,
    this.countries,
    this.mobile,
    this.orderId,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json['user_id'] as int?,
        countries: (json['countries'] as List<dynamic>?)
            ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
            .toList(),
        mobile: json['mobile'] as String?,
        orderId: json['order_id'] as dynamic,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'countries': countries?.map((e) => e.toJson()).toList(),
        'mobile': mobile,
        'order_id': orderId,
        'email': email,
      };
}
