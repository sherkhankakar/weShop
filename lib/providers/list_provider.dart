import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/Api_service.dart';
import '../network/Api_service_constant.dart';

class ListProvider with ChangeNotifier {
  Future<void> getLists() async {
    final prefs = await SharedPreferences.getInstance();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.list,
      {'user_id': prefs.getString('user_id')},
    );

    print(result);
  }
}
