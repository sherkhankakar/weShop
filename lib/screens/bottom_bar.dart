import 'package:flutter/material.dart';
import 'package:weshop/screens/notification_screen.dart';
import 'package:weshop/screens/settings_screen.dart';

import 'home_screen.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        elevation: 0,
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Color.fromRGBO(0, 173, 25, 1),
          unselectedItemColor: Colors.black45,
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
              fontWeight: FontWeight.w500),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  'assets/images/list.png',
                )), label: 'My Lists'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: _onTappedBar,
          currentIndex: _selectedIndex,
        ),

      ),
      body: PageView(
      controller: _pageController,
      children: const <Widget>[
        HomeScreen(),
        NotificationScreen(),
        SettingScreen(),
      ],
      onPageChanged: (page) {
        setState(() {
          _selectedIndex = page;
        });
      },
    ),
    );
  }



}
