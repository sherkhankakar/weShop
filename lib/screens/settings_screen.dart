import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weshop/screens/profile_settings.dart';

import '../main.dart';
import 'change_password.dart';
import 'language_settings.dart';
import 'location_settings.dart';
import 'notification_settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 173, 25, 1),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Image.asset(
                    'assets/images/Ellipse (2).png',
                    height: 80,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagja Alfatih',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text('example@email.com',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 40),
              rowTiles(
                  ProfileSetting(),
                  Icon(
                    Icons.person_pin,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Profile Settings'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
              rowTiles(
                  ChangePassword(),
                  Icon(
                    Icons.lock,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Change Password'),

              ///line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
              rowTiles(
                  NotificationSettings(),
                  Icon(
                    Icons.notifications,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Notification Settings'),

              ///line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),

              rowTiles(
                  LocationSettings(),
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Location Settings'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
              rowTiles(
                  LanguageSettings(),
                  Icon(
                    Icons.language,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Language Settings'),

              ///line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),

              SizedBox(height: 10),
              rowTiles2(
                  Icon(
                    Icons.share,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Share App'),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
              SizedBox(height: 10),
              rowTiles2(
                  Icon(
                    Icons.thumb_up_alt_rounded,
                    color: Color.fromRGBO(52, 107, 33, 1),
                    size: 25.0,
                  ),
                  'Rate  Us'),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
              SizedBox(height: 10),
              rowTiles2(
                  Icon(
                    Icons.logout,
                    color: Color.fromRGBO(52, 107, 33, 1.0),
                    size: 25.0,
                  ),
                  'Logout', ontap: () async {
                final prefs = await SharedPreferences.getInstance();
                await GoogleSignIn().signOut();
                prefs.clear().whenComplete(
                      () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyappSTF()),
                          (route) => false),
                );
              }),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0,
                  indent: 0,
                  endIndent: 1,
                ),
              ),
            ],
          ),
        ));
  }

  rowTiles2(Icon icon, String title, {VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap ?? null,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }

  rowTiles(Widget pageName, Icon menuIcon, String title) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageName));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            menuIcon,
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }
}