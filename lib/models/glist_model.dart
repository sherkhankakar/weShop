class GlistModel {
  final int id;
  final String title;
  bool isChecked;

  GlistModel({required this.id, required this.title, required this.isChecked});

  factory GlistModel.fromJson(Map<String, dynamic> json) {
    return GlistModel(
      id: json['id'],
      title: json['name'],
      isChecked: false,
    );
  }
}
