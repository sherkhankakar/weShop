import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weshop/translations/locale_keys.g.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key, required this.grosListId}) : super(key: key);
  final String grosListId;

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final double qrSize = 200.0;
  String data = '';

  void qrCodeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data = '${prefs.getString('user_id')!}, ${widget.grosListId}';
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    qrCodeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.scan_qr_code.tr(),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            SizedBox(height: 15),
            Text(
              LocaleKeys.scan_this_code_to_access.tr(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            QrImageView(
              data: data,
              version: QrVersions.auto,
              size: qrSize,
            ),
          ],
        ),
      ),
    );
  }
}
