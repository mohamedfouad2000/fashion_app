class Countricity {
  int? id;
  String? name;
  int? parentId;
  List<dynamic>? cities;

  Countricity({this.id, this.name, this.parentId, this.cities});

  factory Countricity.fromJson(Map<String, dynamic> json) => Countricity(
        id: json['id'] as int?,
        name: json['name'] as String?,
        parentId: json['parent_id'] as int?,
        cities: json['cities'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'parent_id': parentId,
        'cities': cities,
      };
}
