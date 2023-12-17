import 'countricity.dart';

class Data {
  int? userId;
  List<Countricity>? countricities;
  String? mobile;
  dynamic orderId;
  String? email;

  Data({
    this.userId,
    this.countricities,
    this.mobile,
    this.orderId,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json['user_id'] as int?,
        countricities: (json['countricities'] as List<dynamic>?)
            ?.map((e) => Countricity.fromJson(e as Map<String, dynamic>))
            .toList(),
        mobile: json['mobile'] as String?,
        orderId: json['order_id'] as dynamic,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'countricities': countricities?.map((e) => e.toJson()).toList(),
        'mobile': mobile,
        'order_id': orderId,
        'email': email,
      };
}
