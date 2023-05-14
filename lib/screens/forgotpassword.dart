import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:weshop/constant/widget_constants.dart';
import 'package:weshop/providers/logincontroller.dart';
import 'package:email_otp/email_otp.dart';
import 'package:weshop/translations/locale_keys.g.dart';

// import 'package:emailotp/otp_screen.dart';
import 'Sign_In.dart';
import 'package:flutter/material.dart';

import 'verifycode.dart';

///stl
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forgotSTF(),
    );
  }
}

///stf
class forgotSTF extends StatefulWidget {
  const forgotSTF({Key? key}) : super(key: key);

  @override
  State<forgotSTF> createState() => _forgotSTFState();
}

class _forgotSTFState extends State<forgotSTF> {
  ///Text editing controller
  final TextEditingController emailCtr = TextEditingController();
  EmailOTP myauth = EmailOTP();

  ///function to generate otp

  late double height;
  late double width;
  loginController? provider;
  @override
  void initState() {
    provider = Provider.of<loginController>(context, listen: false);
    super.initState();
  }
  // get myauth => true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            /// 1st row arrow icon
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => signin1()));
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 25.0,
                  color: Color.fromRGBO(52, 107, 33, 1),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  LocaleKeys.forgot_password.tr(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
            ),

            ///3rd row text
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                LocaleKeys.forgot_password_description.tr(),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(100, 100, 100, 1),
                ),
              ),
            ),

            ///5th row email
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: emailCtr,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            ///6th row continue btn
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: width,
              height: height * 0.053,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                ),
                onPressed: () async {
                  // myauth.setConfig(
                  //     appEmail: "hamzaconzummate29@gmail.com",
                  //     appName: "Email OTP",
                  //     userEmail: emailcontroller.text,
                  //     otpLength: 6,
                  //     otpType: OTPType.digitsOnly);
                  // if (await myauth.sendOTP() == true) {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text("OTP has been sent"),
                  //   ));
                  //   Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (context) => VerifyCode()));
                  //   // Navigator.of(context).push(MaterialPageRoute(
                  //   //     builder: (context) => Otp(otpController: )));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text("Oops, OTP send failed"),
                  //   ));
                  // }
                  emailCtr.text.isNotEmpty
                      ? provider!
                          .forgotPassword(emailCtr.text)
                          .whenComplete(
                          () {
                            if (provider!.msg == 'Successful') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => VerifyCode(
                                    email: emailCtr.text,
                                  ),
                                ),
                              );
                            } else {
                              WidgetConstants.showSnackBar(
                                context,
                                provider!.msg,
                              );
                            }
                          },
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter your email'),
                          ),
                        );
                },
                child: Selector<loginController, bool>(
                  selector: (_, ctr) => ctr.isLoading,
                  builder: (context, isLoading, child) {
                    return isLoading == true
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                            LocaleKeys.continue_word.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
