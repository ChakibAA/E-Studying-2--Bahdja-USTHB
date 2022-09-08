class ModuleModel {
  String? id;
  String? title;

  ModuleModel({
    this.id,
    this.title,
  });

  ModuleModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'].toString();
    title = json['post_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;

    data['post_title'] = title;

    return data;
  }
}
