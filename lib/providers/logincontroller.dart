import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/userModel.dart';
import '../../network/Api_service.dart';
import '../network/Api_service_constant.dart';

class loginController with ChangeNotifier {
  UsersDetails? usersDetails;
  allowUserToSignInWithFB() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email,name,picture.type(large)",
      );
      this.usersDetails = new UsersDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"] ?? " ",
      );
      notifyListeners();
    }
  }

  allowUserToSignOut() async {
    await FacebookAuth.i.logOut();
    usersDetails = null;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _msg = '';
  String get msg => _msg;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;
  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    notifyListeners();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.signIn,
      {'email': email, 'password': password},
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.body);
    if (result.statusCode == 200 && data['success'] == true) {
      prefs.setString('user_id', data['user']['id'].toString());
      prefs.setString('token', data['token']);
      prefs.setString('email', data['user']['email']);
      prefs.setString('name', data['user']['name']);

      _msg = 'Successful';
      notifyListeners();
    } else {
      _msg = data['message'];
      notifyListeners();
    }
    print(result);
  }

  Future<dynamic> registerNewUser(
      String email, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.register,
      {'name': name, 'email': email, 'password': password},
    );

    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    if (result.statusCode == 201) {
      prefs.setString('token', data['token']);
      _msg = 'Successfully registered';
      print(data);
      notifyListeners();
      return data;
    } else {
      print(data);
      _msg = data['errors']['email'][0];
      notifyListeners();
      return data;
    }
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.forgortPassword,
      {'email': email},
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    if (result.statusCode == 200) {
      _msg = 'Successful';
      notifyListeners();
    } else {
      _msg = data['errors']['email'][0];
      notifyListeners();
    }
    print(result);
  }

  Future<void> resetPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.resetPassword,
      {'email': email, 'new_password': password},
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    log(result.statusCode.toString());

    if (result.statusCode == 200) {
      _msg = 'Successful';
      notifyListeners();
    } else {
      _msg = data['message'];
      notifyListeners();
    }
    print(result);
  }

  Future<void> verifyResetPassword(String email, String otp) async {
    _isLoading = true;
    notifyListeners();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.verifyPassword,
      {'email': email, 'otp': otp},
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    print(data);
    if (result.statusCode == 200) {
      _msg = 'Successful';
      notifyListeners();
    } else {
      _msg = data['message'];
      notifyListeners();
    }
    print(result);
  }

  Future<void> confirmPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.resetPassword,
      {'email': email, 'new_password': password},
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    print(data);
    if (result.statusCode == 200) {
      _msg = 'Password Changed Successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['email'][0] ?? data['errors']['new_password'][0];
      notifyListeners();
    }
    print(result);
  }

  Future<void> updatePassword(String currPass, String newPass) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.updatePassword,
      {
        'user_id': prefs.getString('user_id'),
        'cur_pass': currPass,
        'new_pass': newPass
      },
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    }).catchError((e) {
      _msg = e.toString();
      notifyListeners();
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    print(data);
    if (result.statusCode == 200) {
      _msg = 'Password Updated Successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['email'][0] ??
          data['errors']['cur_pass'][0] ??
          data['erros']['new_pass'][0];
      notifyListeners();
    }
    print(result);
  }

  Future<void> updateUserRecord(String userName, String email) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.updateUser,
      {
        'user_id': prefs.getString('user_id'),
        'email': email,
        'name': userName,
      },
    ).whenComplete(() {
      _isLoading = false;
      notifyListeners();
      prefs.setString('email', email);
      prefs.setString('name', userName);
    });
    log(result.statusCode.toString());
    final data = jsonDecode(result.body) as Map<String, dynamic>;
    print(data);
    if (result.statusCode == 200) {
      _msg = 'User Record Updated Successfully';
      notifyListeners();
    } else {
      _msg = data['errors']['email'][0] ?? data['errors']['name'][0];
      notifyListeners();
    }
    print(result);
  }
}
