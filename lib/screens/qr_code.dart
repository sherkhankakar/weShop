import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 173, 25, 1),
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Text(
                    LocaleKeys.add_contributer.tr(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: 300,
              color: Colors.blueAccent,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.scan_qr_code.tr(),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Text(LocaleKeys.scan_this_code_to_access.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                ],
              ),
            ),
          )),
    );
  }
}
