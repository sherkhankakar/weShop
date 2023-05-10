import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/Api_service.dart';
import '../models/glist_model.dart';
import '../network/Api_service_constant.dart';

class ListProvider with ChangeNotifier {
  String _msg = '';
  String get msg => _msg;

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  int _currentIndex = -1;
  int get currentIndex => _currentIndex;

  String _selectedValue = 'Dozen';

  String get selectedValue => _selectedValue;

  void setSelectedValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  set currentIndex(int newValue) {
    _currentIndex = newValue;
    log(newValue.toString());
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

  Stream<dynamic> getLists() async* {
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
      for (var d in data['data']['glists']) {
        myData.add(GlistModel.fromJson(d));
        sortedList.add(Item.fromJson(d));
        len.add(d['list_item'].length.toString());
      }

      myDataList = myData;
      _glistLength = len;
      _items = sortedList;
      notifyListeners();
      yield data;
    } else {
      yield data;
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
      print(_idsList);
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
    log(result.statusCode.toString());
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
    log(result.statusCode.toString());
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

  Future<dynamic> fetchListedItems(String listId) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.getListedItems,
      {
        'gros_list_id': listId,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    if (result.statusCode == 200) {
      _msg = 'List fetched successfully';
      log(result.body);
      List<AddedItemsModel> myData = [];
      for (var d in data['data']) {
        myData.add(AddedItemsModel.fromJson(d));
      }

      myDataList = myData;

      notifyListeners();
      return data;
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
      return data;
    }
  }

  Future<String> getSingleItem(String itemId) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.getItem,
      {
        'id': itemId,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    if (result.statusCode == 200) {
      _msg = 'List fetched successfully';
      notifyListeners();
      return data['data']['name'];
    } else {
      _msg = data['errors']['name'][0];
      notifyListeners();
      throw Exception(data['errors']['name'][0]);
    }
  }

  Future<dynamic> updateListItem(
      String listId, String itemId, String price, String qty) async {
    final result = await AuthenticationServices.baseFunction(
      Uri.parse('https://weshop.quitbug.com/public/api/listitemupdate'),
      {
        'gros_list_id': listId,
        'item_id': itemId,
        'item_qty': qty,
        'item_price': price,
      },
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());
    log(result.body);
    if (result.statusCode == 200) {
      _msg = 'List updated successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['gros_list_id'][0];
      notifyListeners();
      throw Exception(data['errors']['gros_list_id'][0]);
    }
  }
}
