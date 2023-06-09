import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weshop/translations/locale_keys.g.dart';
class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late double width;
  late double height;
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: Text(LocaleKeys.profile_settings.tr(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          },icon: Icon(Icons.arrow_back_ios_rounded)),
          centerTitle: true,

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(child: Image.asset('assets/images/Ellipse (2).png')),
            SizedBox(height: 20),

            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20,),
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
                          borderSide: BorderSide(
                            color: Colors.black54
                          )),
                      hintText: LocaleKeys.full_name.tr(),
                      hintStyle: TextStyle(
                        color: Colors.black45
                      )),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20,),
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
                          borderSide: BorderSide(
                              color: Colors.black54
                          )),
                      hintText: LocaleKeys.Email.tr(),
                      hintStyle: TextStyle(
                          color: Colors.black45
                      )),
                ),
              ),
            ),
            Expanded(child: SizedBox(height: 20,)),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(0, 173, 25, 1),
              ), child: Text(LocaleKeys.save.tr())),
            )

          ],
        ),

      ),
    );
  }
}

