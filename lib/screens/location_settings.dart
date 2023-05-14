

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weshop/screens/home_location.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class LocationSettings extends StatefulWidget {
  const LocationSettings({Key? key}) : super(key: key);

  @override
  State<LocationSettings> createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {

  late double width;
  late double height;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
        title: Text(LocaleKeys.location_setting.tr(),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.location.tr(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(20,20,20,1),
                  ),
                ),
                Switch(
                  activeColor: Color.fromRGBO(0, 173, 25, 1),
                  inactiveThumbColor: Colors.black,
                  value: _switchValue,
                  onChanged: (value){
                    setState(() {
                      _switchValue=value;
                    });
                  },

                ),
              ],
            ),
            //SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeLocation()));
                },
                child: Text(LocaleKeys.home_location.tr(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(20,20,20,1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
          ],
        ),
      ),
    ));
  }
}
