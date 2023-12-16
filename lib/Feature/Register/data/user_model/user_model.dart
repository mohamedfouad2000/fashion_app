import 'data.dart';

class UserModel {
  bool? status;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;
  UserModel({
    this.status,
    this.errorMessage,
    this.errorMessageEn,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json['status'] ?? false,
        errorMessage: json['error_message'] ?? json['message'] ?? '',
        errorMessageEn: json['error_message_en'] ?? json['message'] ?? '',
        data: json['data'] == null
            ? Data()
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'error_message': errorMessage,
        // 'message': errorMessage,
        'error_message_en': errorMessageEn,
        'data': data?.toJson(),
      };
}
