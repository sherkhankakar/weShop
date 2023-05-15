import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late double width;
  late double height;
  bool isNotificationShowing = false;
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(0, 173, 25, 1),
              title: Text(
                LocaleKeys.notifications.tr(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: Container(
              height: height,
              margin: EdgeInsets.all(0),
              child: ListView.builder(
                itemCount: 3, // Number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  // Return a widget for each item in the list
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      notificationCard(index, 'Name',
                          LocaleKeys.notification_description.tr(), '5 min'),
                    ],
                  );
                },
              ),
            )));
  }

  notificationCard(int index, String title, String subTitle, String time) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      child: GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
              isNotificationShowing = true;
            });
          },
          child: currentIndex == index
              ? !isNotificationShowing
                  ? Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/Avatar.png'),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)),
                                Text(subTitle,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54)),
                              ],
                            ),
                          ),
                          Text(time),
                          SizedBox(width: 10),
                        ],
                      ))
                  : Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset('assets/images/Avatar.png'),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)),
                                Text(subTitle,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        isNotificationShowing = false;
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            //color: Colors.green,
                                            border:
                                                Border.all(color: Colors.green)),
                                        child: Icon(
                                          Icons.close,
                                          color: Color.fromRGBO(0, 173, 25, 1),
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        isNotificationShowing = false;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      child: Icon(Icons.check),
                                      backgroundColor:
                                          Color.fromRGBO(0, 173, 25, 1),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text('5 min')
                            ],
                          )
                        ],
                      ))
              : Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/images/Avatar.png'),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400)),
                            Text(subTitle,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54)),
                          ],
                        ),
                      ),
                      Text(time),
                      SizedBox(width: 10),
                    ],
                  ))),
    );
  }
}
