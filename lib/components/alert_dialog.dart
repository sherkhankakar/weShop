import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/qr_code.dart';
import '../translations/locale_keys.g.dart';

class AlertDialogComponent extends StatelessWidget {
  const AlertDialogComponent({super.key, required this.listId});
  final String listId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height / 3.7,
        child: Column(
          children: [
            ///1st row close icon
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Color.fromRGBO(52, 107, 33, 1),
                  ),
                )),

            ///2nd row
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      LocaleKeys.add_contributer.tr(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(20, 20, 20, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///3rd row
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    LocaleKeys.select_access.tr(),
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(100, 100, 100, 1),
                    ),
                  ),
                ),
              ],
            ),

            ///4th row buttons
            SizedBox(
              height: 22.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    color: Color.fromRGBO(0, 173, 25, 1),
                  )),

                  // changeText();

                  onPressed: () {},
                  child: Text(
                    LocaleKeys.limited_acces.tr(),
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(100, 100, 100, 1),
                    ),
                  ),
                )),
                SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        color: Color.fromRGBO(0, 173, 25, 1),
                      )),
                      onPressed: () {
                        // changeText2();
                      },
                      child: Text(
                        LocaleKeys.full_access.tr(),
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      )),
                ),
              ],
            ),

            ///5th row button
            SizedBox(
              height: 17.0,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QrCodeScreen(
                          grosListId: listId,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    LocaleKeys.continue_word.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
