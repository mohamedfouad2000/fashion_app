class Data {
  String? mobile;
  String? name;
  String? email;
  dynamic address;
  dynamic profilePhotoPath;
  String? token;

  Data({
    this.mobile,
    this.name,
    this.email,
    this.address,
    this.profilePhotoPath,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mobile: json['mobile'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        address: json['address'] as dynamic,
        profilePhotoPath: json['profile_photo_path'] as dynamic,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'name': name,
        'email': email,
        'address': address,
        'profile_photo_path': profilePhotoPath,
        'token': token,
      };
}
