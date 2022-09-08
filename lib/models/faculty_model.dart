class FacultyModel {
  int? id;
  String? name;
  String? slug;

  FacultyModel({
    this.id,
    this.name,
    this.slug,
  });

  FacultyModel.fromJson(Map<String, dynamic> json) {
    id = json['term_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = id;
    data['name'] = name;
    data['slug'] = slug;

    return data;
  }
}
