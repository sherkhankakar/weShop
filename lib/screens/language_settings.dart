import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {

  late double width;
  late double height;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
        title:  Text(LocaleKeys.language_settings.tr(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 21.0,
            ),
            rowTiles('English', 1),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Urdu', 2),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Chinese', 3),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('French', 4),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            rowTiles('Arabic', 5),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            SizedBox(height: 40,),
            TextButton(onPressed: (){
              context.locale = Locale('en','US');
            }, child: Text('Change'))

          ],
        ),
      ),
    ));
  }

  rowTiles(String title, int i,) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.black
          ),),
        Radio(
          activeColor: Color.fromRGBO(0, 173, 25, 1),
          value: i,
          groupValue: _value,
          onChanged: (value){
            setState(() {
              _value = value!;
            });
          },

        ),

      ],
    );
  }

}
