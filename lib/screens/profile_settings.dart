import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/logincontroller.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late double width;
  late double height;
  TextEditingController? nameCtr;
  TextEditingController? emailCtr;

  loginController? provider;

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameCtr = TextEditingController(text: prefs.getString('name'));
      emailCtr = TextEditingController(text: prefs.getString('email'));
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
    provider = Provider.of<loginController>(context, listen: false);
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: const Text(
            'Profile Settings',
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
        body: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(child: Image.asset('assets/images/Ellipse (2).png')),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Center(
                  child: TextFormField(
                    controller: nameCtr,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: nameCtr == null ? 'Name' : nameCtr!.text,
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Center(
                  child: TextFormField(
                    controller: emailCtr,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black54)),
                      hintText: emailCtr == null ? 'Email' : emailCtr!.text,
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 20,
              )),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate())
                      provider!
                          .updateUserRecord(nameCtr!.text, emailCtr!.text)
                          .whenComplete(() {
                        if (provider!.msg ==
                            'User Record Updated Successfully') {
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
                      });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  ),
                  child: Selector<loginController, bool>(
                    selector: (_, loginController) => loginController.isLoading,
                    builder: (context, isLoading, child) {
                      return isLoading == true
                          ? CircularProgressIndicator()
                          : Text('Save');
                    },
                  ),
                ),
              ),
              SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
