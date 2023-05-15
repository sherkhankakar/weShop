import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/logincontroller.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  loginController? provider;

  late double width;
  late double height;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<loginController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: Text(
            LocaleKeys.change_password.tr(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            textfieldContainer(LocaleKeys.change_password.tr(), currPass),
            SizedBox(height: 15),
            textfieldContainer(LocaleKeys.new_password.tr(), newPass),
            SizedBox(height: 15),
            textfieldContainer(LocaleKeys.confirm_password.tr(), confirmPass),
            Expanded(child: SizedBox()),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      provider!
                          .updatePassword(currPass.text, newPass.text)
                          .whenComplete(
                        () {
                          if (provider!.msg ==
                              'Password Updated Successfully') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(provider!.msg),
                              ),
                            );
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(provider!.msg),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  ),
                  child: Text(LocaleKeys.save.tr())),
            )
          ],
        ),
      ),
    );
  }

  textfieldContainer(String hint, TextEditingController ctr) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Center(
        child: TextFormField(
          controller: ctr,
          keyboardType: TextInputType.name,
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            focusColor: Color.fromRGBO(0, 173, 25, 1),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 2, color: Colors.green)),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.black54)),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black45),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide $hint';
            }
            return null;
          },
        ),
      ),
    );
  }
}
