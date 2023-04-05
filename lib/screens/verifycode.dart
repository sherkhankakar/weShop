import 'package:provider/provider.dart';
import 'package:weshop/providers/logincontroller.dart';

import 'forgotpassword.dart';
import 'package:flutter/material.dart';

import 'newpassword.dart';

///stl
class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifyCodeSTF(email: widget.email),
    );
  }
}

///stf
class VerifyCodeSTF extends StatefulWidget {
  const VerifyCodeSTF({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<VerifyCodeSTF> createState() => _VerifyCodeSTFState();
}

class _VerifyCodeSTFState extends State<VerifyCodeSTF> {
  late double width;
  late double height;

  final otpController = TextEditingController();

  ///variables
  var isOtpSent = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ///Arrow icon
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        size: 25.0,
                        color: Color.fromRGBO(52, 107, 33, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///2nd row text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 17.0,
                    left: 15.0,
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(20, 20, 20, 1)),
                  ),
                ),
              ],
            ),

            ///3rd row Text
            SizedBox(
              height: 56.0,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'Enter the 6-digit verification code we sent to your email',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///4th row text
            SizedBox(
              height: 2.0,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'address.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///5th row verfication code
            SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    6,
                    (index) => SizedBox(
                          width: 48,
                          height: 48,
                          child: Container(
                            // margin: EdgeInsets.only(left: 10.0,),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: otpController,
                              cursorColor: Colors.black54,
                              onChanged: (value) {
                                if (value.length == 1 && index <= 5) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 1) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              style: TextStyle(
                                color: Color.fromRGBO(100, 100, 100, 1),
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.only(left: 10.0,right: 10.0,),
                                isDense: true,

                                border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(100, 100, 100, 1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(100, 100, 100, 1))),
                                // hintText: "*",
                              ),
                            ),
                          ),
                        )),
              ),
            ),

            ///Confirm password btn
            Container(
              margin: EdgeInsets.only(),
              width: width * 0.93,
              height: height * 0.053,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                ),
                onPressed: () {
                  Provider.of<loginController>(context, listen: false)
                      .verifyResetPassword(widget.email, otpController.text)
                      .whenComplete(
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => NewPassword(
                              email: widget.email,
                            ),
                          ),
                        ),
                      );
                },
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),

            ///last text
            SizedBox(
              height: 16.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 63.0, right: 63.0),
              child: Row(
                children: [
                  Container(
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Didn\'t receive a code?',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(20, 20, 20, 1),
                              )),
                          TextSpan(
                            text: 'Resend Code',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 173, 25, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
