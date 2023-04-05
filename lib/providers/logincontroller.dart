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
    prefs.setString('user_id', result['user']['id'].toString());
    prefs.setString('token', result['token']);
    print(result);
  }

  Future<void> registerNewUser(
      String email, String password, String name) async {
    final result = await AuthenticationServices.baseFunction(
      Apiserviceconstant.register,
      {'name': name, 'email': email, 'password': password},
    );

    print(result);
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

    print(result);
  }
}
