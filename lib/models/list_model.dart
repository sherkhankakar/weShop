class ListModel{
   bool? success;
  List<Data>? data;

  ListModel({this.success, this.data});

  ListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? grosListId;
  String? itemId;
  String? itemQty;
  String? itemPrice;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.grosListId,
      this.itemId,
      this.itemQty,
      this.itemPrice,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grosListId = json['gros_list_id'];
    itemId = json['item_id'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gros_list_id'] = this.grosListId;
    data['item_id'] = this.itemId;
    data['item_qty'] = this.itemQty;
    data['item_price'] = this.itemPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}