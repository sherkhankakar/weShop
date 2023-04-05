import 'package:provider/provider.dart';
import 'package:weshop/providers/logincontroller.dart';
import 'package:email_otp/email_otp.dart';

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
  final TextEditingController emailcontroller = TextEditingController();
  EmailOTP myauth = EmailOTP();

  ///function to generate otp

  late double height;
  late double width;

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
                  'Forgot Password',
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
                'Enter email associated with your account and well send you a verification code to reset your password',
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
                controller: emailcontroller,
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
                  emailcontroller.text.isNotEmpty
                      ? Provider.of<loginController>(context, listen: false)
                          .forgotPassword(emailcontroller.text)
                          .whenComplete(
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => VerifyCode(
                                  email: emailcontroller.text,
                                ),
                              ),
                            ),
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
                        ? CircularProgressIndicator()
                        : Text(
                            'Continue',
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
