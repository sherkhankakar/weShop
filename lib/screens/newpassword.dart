import 'package:provider/provider.dart';
import 'package:weshop/providers/logincontroller.dart';
import 'package:weshop/screens/bottom_bar.dart';

import 'Sign_In.dart';
import 'package:flutter/material.dart';

///stl
class NewPassword extends StatelessWidget {
  // final int id;
  // NewPassword({required this.id});
  const NewPassword({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewPasswordSTF(
        email: email,
      ),
    );
  }
}

///stf
class NewPasswordSTF extends StatefulWidget {
  const NewPasswordSTF({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<NewPasswordSTF> createState() => _NewPasswordSTFState();
}

class _NewPasswordSTFState extends State<NewPasswordSTF> {
  late double height;
  late double width;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  int id = 40;
  bool _obscureText = true;
  bool _obscureText2 = true;

  // get http => null;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ///1st row icon
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    child: IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyCode()));
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
                    'New Password',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(20, 20, 20, 1)),
                  ),
                ),
              ],
            ),

            ///3rd row text
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
                      'Enter your new password',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(100, 100, 100, 1)),
                    ),
                  ),
                ],
              ),
            ),

            ///4th row password field
            Container(
              margin: EdgeInsets.only(
                top: 17.0,
              ),
              width: width * 0.93,
              height: height * 0.053,
              child: TextFormField(
                controller: password,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 15.0,
                      top: 10.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 173, 25, 1), width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(100, 100, 100, 1), width: 1.2),
                    ),
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )),
                // validator: MultiValidator(
                //     [
                //       RequiredValidator(
                //           errorText: 'Please enter email')
                //     ]
                //
                // ),
              ),
              // validator: (password) {
              //   if (isPasswordValid(password)) return null;
              //   else
              //     return 'Enter a valid password';
              // },
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 26.0,),
            //   width: width*0.93,
            //   height: height*0.053,
            //   child: TextFormField(
            //     // autovalidateMode: AutovalidateMode.onUserInteraction,
            //     obscureText: _obscureText,
            //     cursorColor:Color.fromRGBO(100,100,100,1),
            //     decoration: InputDecoration(
            //         contentPadding: EdgeInsets.only(top: 10.0,left: 10.0,),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.green, width: 1.2),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Color.fromRGBO(100,100,100,1), width: 1.2),
            //         ),
            //         hintText: 'Password',
            //         suffixIcon:  GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               _obscureText = !_obscureText;
            //             });
            //           },
            //           child: new Icon(
            //             _obscureText ?
            //             Icons.visibility_off: Icons.visibility,
            //             color: Colors.grey,
            //             size: 20,
            //           ),
            //         )
            //     ),
            //     // validator: MultiValidator(
            //     //     [
            //     //       RequiredValidator(
            //     //           errorText: 'Please enter email')
            //     //     ]
            //     //
            //     // ),
            //
            //
            //   ),
            //   // validator: (password) {
            //   //   if (isPasswordValid(password)) return null;
            //   //   else
            //   //     return 'Enter a valid password';
            //   // },
            //
            // ),
            ///5th row confirm password field
            Container(
              margin: EdgeInsets.only(
                top: 17.0,
              ),
              width: width * 0.93,
              height: height * 0.053,
              child: TextFormField(
                controller: confirmpassword,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText2,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 15.0,
                      top: 10.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 173, 25, 1), width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(100, 100, 100, 1), width: 1.2),
                    ),
                    hintText: 'Confirm Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                      child: new Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )),
                // validator: MultiValidator(
                //     [
                //       RequiredValidator(
                //           errorText: 'Please enter email')
                //     ]
                //
                // ),
              ),
              // validator: (password) {
              //   if (isPasswordValid(password)) return null;
              //   else
              //     return 'Enter a valid password';
              // },
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 17.0,),
            //   width: width*0.93,
            //   height: height*0.053,
            //   child: TextFormField(
            //     // autovalidateMode: AutovalidateMode.onUserInteraction,
            //     obscureText: _obscureText2,
            //     cursorColor: Color.fromRGBO(100,100,100,1),
            //     decoration: InputDecoration(
            //         contentPadding: EdgeInsets.only(top: 10.0,left: 10.0,),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.green, width: 1.2),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Color.fromRGBO(100,100,100,1), width: 1.2),
            //         ),
            //         hintText: 'Confirm Password',
            //         suffixIcon:  GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               _obscureText2 = !_obscureText2;
            //             });
            //           },
            //           child: new Icon(
            //             _obscureText2 ?
            //             Icons.visibility_off: Icons.visibility,
            //             color: Colors.grey,
            //             size: 20,
            //           ),
            //         )
            //     ),
            //     // validator: MultiValidator(
            //     //     [
            //     //       RequiredValidator(
            //     //           errorText: 'Please enter email')
            //     //     ]
            //     //
            //     // ),
            //
            //
            //   ),
            //   // validator: (password) {
            //   //   if (isPasswordValid(password)) return null;
            //   //   else
            //   //     return 'Enter a valid password';
            //   // },
            //
            // ),
            ///Confirm password btn
            SizedBox(
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.only(),
              width: width * 0.93,
              height: height * 0.053,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                ),
                onPressed: () {
                  resetUser();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => signin1()));
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
          ],
        ),
      ),
    );
  }

  void resetUser() async {
    ///ya register ki api ka link ha
    await Provider.of<loginController>(context, listen: false)
        .resetPassword(widget.email, password.text)
        .whenComplete(() => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => BottomBar()),
            (route) => false));
  }
}
