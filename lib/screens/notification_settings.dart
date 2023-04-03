import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  late double width;
  late double height;

  bool _switchValue = false;
  bool _switchValue2 = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
        title: const Text('Notification Settings',
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
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('List Request Notifications',
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
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('List Changes Notifications',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(20,20,20,1),
                  ),
                ),
                Switch(
                  activeColor: Color.fromRGBO(0, 173, 25, 1),
                  inactiveThumbColor: Colors.black,
                  value: _switchValue2,
                  onChanged: (value){
                    setState(() {
                      _switchValue2=value;
                    });
                  },

                ),
              ],
            ),
            SizedBox(height: 10),
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
