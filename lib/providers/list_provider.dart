import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/Api_service.dart';
import '../models/glist_model.dart';
import '../models/list_model.dart';
import '../network/Api_service_constant.dart';

class ListProvider with ChangeNotifier {
  String _msg = '';
  String get msg => _msg;

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  int _currentIndex = -1;
  int get currentIndex => _currentIndex;

  String _selectedValue = 'Dozen';

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _title = false;
  bool get title => _title;

  void getEditValue(bool value) {
    _isEdit = value;
    log(_isEdit.toString());
    notifyListeners();
  }

  void getTitle(bool value) {
    _title = value;
    notifyListeners();
  }

  String get selectedValue => _selectedValue;

  void setSelectedValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set isChecked(bool newValue) {
    _isChecked = newValue;
    notifyListeners();
  }

  List<dynamic> myDataList = [];

  List<String> _glistLength = [];
  List<String> get gListLength => _glistLength;

  List<Item> _items = [];
  String _selectedSortOption = 'Price: Low to High';

  List<Item> get items => _items;

  String get selectedSortOption => _selectedSortOption;

  set selectedSortOption(String option) {
    _selectedSortOption = option;
    _sortItems();
    notifyListeners();
  }

  void _sortItems() {
    switch (_selectedSortOption) {
      // case 'Price: Low to High':
      //   _items.sort((a, b) => a.price.compareTo(b.price));
      //   break;
      // case 'Price: High to Low':
      //   _items.sort((a, b) => b.price.compareTo(a.price));
      //   break;
      case 'Date Modified':
        _items.sort((a, b) => a.dateModified.compareTo(b.dateModified));
        break;
      case 'Alphabetically: A-Z':
        _items.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Alphabetically: Z-A':
        _items.sort((a, b) => b.name.compareTo(a.name));
        break;
    }
  }

  Map<String, String> _grandTotal = {};
  Map<String, String> get grandTotal => _grandTotal;

  Future<dynamic> getLists() async {
    final prefs = await SharedPreferences.getInstance();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.list,
      {'user_id': prefs.getString('user_id')},
    );

    final data = jsonDecode(result.body) as Map<String, dynamic>;

    if (result.statusCode == 200) {
      List<GlistModel> myData = [];
      List<String> len = [];
      List<Item> sortedList = [];
      for (var d
          in (data['data']['glists'] + data['data']['listcontributers'])) {
        myData.add(GlistModel.fromJson(d));
        sortedList.add(Item.fromJson(d));
        len.add(d['list_item'].length.toString());
      }
      _totalPrice.clear();
      _grandTotal.clear();
      for (int i = 0; i < data['data']['glists'].length; i++) {
        for (int j = 0;
            j < data['data']['glists'][i]['list_item'].length;
            j++) {
          print(
              'for loop:  ${data['data']['glists'][i]['list_item'][j]['item_price']}');

          if (data['data']['glists'][i]['list_item'][j]['item_price'] != null &&
              data['data']['glists'][i]['list_item'][j]['item_qty'] != null) {
            calculateTotalPrice(
              data['data']['glists'][i]['list_item'][j]['item_price']
                  .toString(),
              data['data']['glists'][i]['list_item'][j]['item_qty'].toString(),
              data['data']['glists'][i]['list_item'][j]['item_id'].toString(),
            );
            if (_grandTotal.containsKey(data['data']['glists'][i]['name'])) {
              _grandTotal.update(
                  data['data']['glists'][i]['name'],
                  (value) =>
                      '${(int.parse(data['data']['glists'][i]['list_item'][j]['item_price']) * int.parse(data['data']['glists'][i]['list_item'][j]['item_qty']))}');
            } else {
              _grandTotal.addAll({
                '${data['data']['glists'][i]['name']}':
                    '${(int.parse(data['data']['glists'][i]['list_item'][j]['item_price']) * int.parse(data['data']['glists'][i]['list_item'][j]['item_qty']))}'
              });
            }
          }
        }
      }

      myDataList = myData;
      _glistLength = len;
      _items = sortedList;
      notifyListeners();
      return data;
    } else {
      return data;
    }
  }

  List<String> _idsList = [];
  List<String> get idsList => _idsList;

  String? _listIdForItems;
  String get listIdForItems => _listIdForItems!;

  void toggleItem(int itemId, {bool? isListedItem = false}) {
    final index = myDataList.indexWhere((item) => item.id == itemId);
    List<String> ids = [];
    if (index != -1) {
      myDataList[index].isChecked = !myDataList[index].isChecked;
      if (isListedItem == false) {
        for (var i in myDataList) {
          if (i.isChecked == true) {
            ids.add(i.id.toString());
          }
        }
      }
      if (isListedItem == true) {
        for (var i in myDataList) {
          if (i.isChecked == true) {
            ids.add(i.itemId.toString());
          }
        }
        _listIdForItems = myDataList[0].grosListId;
      }
      _idsList = ids;
      notifyListeners();
    }
  }

  // method to delete checked items
  void deleteCheckedItems() {
    myDataList.removeWhere((item) => item.isChecked);

    notifyListeners();
  }

  Future<void> addNewList(String listName) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.addList,
      {'user_id': prefs.getString('user_id'), 'name': listName},
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;

    if (result.statusCode == 200) {
      _msg = 'List added successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
    }
  }

  Future<void> addItemsToList(String listId, String itemId) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.addListItem,
      {'gros_list_id': listId, 'item_id': itemId},
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;

    if (result.statusCode == 200) {
      _msg = 'List added successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
    }
  }

  Future<void> updateListName(String listName, String listId) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.updateList,
      {
        'list_id': listId,
        'user_id': prefs.getString('user_id'),
        'name': listName,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    if (result.statusCode == 200) {
      _msg = 'List updated successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
    }
  }

  Future<dynamic> getAllItems() async {
    final result = await AuthenticationServices.getBaseFunction(
      Apiserviceconstant.getAllItems,
    );

    final data = jsonDecode(result.body) as Map<String, dynamic>;

    return data;
  }

  //delete list
  Future<void> deleteList(String listId) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.deleteList,
      {
        'list_id': listId,
        'user_id': prefs.getString('user_id'),
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    if (result.statusCode == 200) {
      _msg = 'List deleted successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
    }
  }

  Future<void> deleteItems(Map<String, dynamic>? itemAndListIds) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.deleteListItem,
      itemAndListIds!,
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    if (result.statusCode == 200) {
      _msg = 'item deleted successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
    }
  }

  Future<ListModel> fetchListedItems(String listId) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.getListedItems,
      {
        'gros_list_id': listId,
      },
    );
    final data = ListModel.fromJson(jsonDecode(result.body));
    final mapData = jsonDecode(result.body) as Map<String, dynamic>;
    if (result.statusCode == 200) {
      _msg = 'List fetched successfully';

      List<AddedItemsModel> myData = [];
      for (var d in mapData['data']) {
        myData.add(AddedItemsModel.fromJson(d));
      }
      myDataList = myData;

      notifyListeners();
      return data;
    } else {
      _msg = data.success.toString();
      notifyListeners();
      return data;
    }
  }

  Future<dynamic> getSingleItem(String itemId, String price, String qty) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.getItem,
      {
        'id': itemId,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;

    if (result.statusCode == 200) {
      _msg = 'List fetched successfully';
      notifyListeners();
      print(data);
      return data;
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
      throw Exception(data['errors']['name'][0]);
    }
  }

  Future<dynamic> updateListItem(
      String listId, String itemId, String price, String qty, int index) async {
    final result = await AuthenticationServices.baseFunction(
      Uri.parse('http://weshop.kretivetech.com/public/api/listitemupdate'),
      {
        'gros_list_id': listId,
        'item_id': itemId,
        'item_qty': qty,
        'item_price': price,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());

    if (result.statusCode == 200) {
      _msg = 'List updated successfully';
      // calculateTotalPrice(price, qty, itemId);
      getLists();
      notifyListeners();
    } else {
      _msg = data['errors']['gros_list_id'];
      notifyListeners();
      throw Exception(data['errors']['gros_list_id'][0]);
    }
  }

  Map<String, dynamic> _totalPrice = {};

  Map<String, dynamic> get totalPrice => _totalPrice;

  void calculateTotalPrice(String? price, String qty, String itemId) {
    if (_totalPrice.containsKey(itemId)) {
      _totalPrice.update(
          itemId, (value) => '${int.parse(price!) * int.parse(qty)}');

      log('grandTotal: $_grandTotal');
    } else {
      _totalPrice.addAll({itemId: '${int.parse(price!) * int.parse(qty)}'});
    }
    notifyListeners();
  }

  Future<void> addContributor(String listId) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await AuthenticationServices.baseFunction(
        Apiserviceconstant.addContributor, {
      'user_id': prefs.getString('user_id'),
      'gros_list_id': listId,
    }).catchError((e) {
      _msg = e.toString();
      notifyListeners();
    });

    if (result.statusCode == 200) {
      _msg = 'Added as a Contributor successfully';
      notifyListeners();
    } else {
      _msg = result['errors']['gros_list_id'][0];
      notifyListeners();
      throw Exception(result['errors']['gros_list_id'][0]);
    }
  }
}
