import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weshop/screens/Sign_In.dart';
import 'package:weshop/screens/bottom_bar.dart';
import 'package:weshop/screens/getstarted.dart';

import 'firebase_options.dart';
import 'providers/list_provider.dart';
import 'providers/logincontroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

//  void main() {
//    // WidgetsFlutterBinding.ensureInitialized();
//    // await Firebase.initializeApp();
//   runApp(MyApp());
// }

///stl
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('user_id'));
    if (prefs.getString('user_id') != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<loginController>(
            create: (context) => loginController()),
        ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(),
        )
      ],
      child: MaterialApp(
        useInheritedMediaQuery: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: isLoggedIn == true ? BottomBar() : MyappSTF(),
      ),
    );
  }
}

///stf
class MyappSTF extends StatefulWidget {
  const MyappSTF({Key? key}) : super(key: key);

  @override
  State<MyappSTF> createState() => _MyappSTFState();
}

class _MyappSTFState extends State<MyappSTF> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/Frame.png")),
            SizedBox(
              height: 60,
            ),
            Text(
              'Welcome to',
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            RichText(
              text: TextSpan(
                  text: 'the',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' WeShop',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 173, 25, 1),
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 30),

            Text(
              'Simple Shopping list app for pantry check and quick shopping. Make list in seconds and share it and see changes live.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 20.0,
            ),

            ///5th row
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GetStarted()));
                },
                child: Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.5,
            ),
            Container(
              width: width,
              height: height * 0.05,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    ///color: Color.fromRGBO(255, 255, 255, 1),
                    foregroundColor: Color.fromRGBO(0, 173, 25, 1),
                    side: BorderSide(color: Color.fromRGBO(0, 173, 25, 1)),
                    disabledForegroundColor: Colors.black.withOpacity(0.38),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => signin1()));
                  },
                  child: Text(
                    'I\'m already a member',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 173, 25, 1),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}