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

class AddedItemsModel {
  final int id;
  final String itemId;
  final String grosListId;
  bool isChecked;

  AddedItemsModel({
    required this.id,
    required this.itemId,
    required this.isChecked,
    required this.grosListId,
  });

  factory AddedItemsModel.fromJson(Map<String, dynamic> json) {
    return AddedItemsModel(
      id: json['id'],
      itemId: json['item_id'],
      grosListId: json['gros_list_id'],
      isChecked: false,
    );
  }
}
