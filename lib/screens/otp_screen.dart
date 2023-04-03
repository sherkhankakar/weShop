import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreenScreen extends StatefulWidget {
  const OtpScreenScreen({Key? key,required this.myauth}) : super(key: key);
  final EmailOTP myauth ;
  @override
  State<OtpScreenScreen> createState() => _OtpScreenScreenState();
}

class _OtpScreenScreenState extends State<OtpScreenScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();

  String otpController = "123456";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.dialpad_rounded, size: 50),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Enter Mary's PIN",
            style: TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpScreen(
                otpController: otp1Controller,
              ),
              OtpScreen(
                otpController: otp2Controller,
              ),
              OtpScreen(
                otpController: otp3Controller,
              ),
              OtpScreen(
                otpController: otp4Controller,
              ),
              OtpScreen(
                otpController: otp5Controller,
              ),
              OtpScreen(
                otpController: otp6Controller,
              ),


            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Rider can't find a pin",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (await widget.myauth.verifyOTP(otp: otp1Controller.text +
                  otp2Controller.text +
                  otp3Controller.text +
                  otp4Controller.text +
                  otp5Controller.text +
                  otp6Controller.text
              ) == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
                // Navigator.push(context,
                //     // MaterialPageRoute(builder: (context) => const Home()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP"),
                ));
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}