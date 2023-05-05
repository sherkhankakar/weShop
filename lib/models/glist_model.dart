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

class Item {
  final String name;
  // final double price;
  final DateTime dateModified;

  Item({required this.name, required this.dateModified});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      // price: json['price'],
      dateModified: DateTime.parse(json['updated_at']),
    );
  }
}