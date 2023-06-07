import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weshop/main.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  late double width;
  late double height;
  int? _value;
  SharedPreferences? prefs;

  Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _value = prefs!.getInt('lang');
    });
  }

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
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
          LocaleKeys.language_settings.tr(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 21.0,
            ),
            rowTiles('English', 1, 'en', 'US'),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Urdu', 2, 'ur', 'PAK'),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Chinese', 3, 'zh', 'CHN'),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('French', 4, 'fr', 'FRA'),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Arabic', 5, 'ar', 'SAU'),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    ));
  }

  rowTiles(String title, int i, String selectedLang, String selectedCountry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        Radio(
          activeColor: Color.fromRGBO(0, 173, 25, 1),
          value: i,
          groupValue: _value,
          onChanged: (value) async {
            prefs!.setInt('lang', value!);
            log(prefs!.getInt('lang').toString());
            setState(() {
              // context.locale = Locale(selectedLang, selectedCountry);
              EasyLocalization.of(context)!
                  .setLocale(
                    Locale(
                      selectedLang,
                      selectedCountry,
                    ),
                  )
                  .whenComplete(() => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => MyApp()),
                      (route) => false));
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
