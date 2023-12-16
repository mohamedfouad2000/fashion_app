import 'datum.dart';

class FavModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Datum>? data;

  FavModel({
    this.result,
    this.errorMessage,
    this.errorMessageEn,
    this.data,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        result: json['result'] as bool?,
        errorMessage: json['error_message'] as String?,
        errorMessageEn: json['error_message_en'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'result': result,
        'error_message': errorMessage,
        'error_message_en': errorMessageEn,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
