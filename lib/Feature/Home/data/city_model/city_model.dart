import 'data.dart';

class CityModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  CityModel({
    this.result,
    this.errorMessage,
    this.errorMessageEn,
    this.data,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        result: json['result'] as bool?,
        errorMessage: json['error_message'] as String?,
        errorMessageEn: json['error_message_en'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'result': result,
        'error_message': errorMessage,
        'error_message_en': errorMessageEn,
        'data': data?.toJson(),
      };
}
