import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/Api_service.dart';
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

  Stream<dynamic> getLists() async* {
    final prefs = await SharedPreferences.getInstance();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.list,
      {'user_id': prefs.getString('user_id')},
    );
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    if (result.statusCode == 200) {
      yield data;
    } else {
      yield data;
    }
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

  Future<dynamic> getAllItems() async {
    final result = await AuthenticationServices.getBaseFunction(
      Apiserviceconstant.getAllItems,
    );

    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.body);
    return data;
  }
}
