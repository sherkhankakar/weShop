import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import '../constant/widget_constants.dart';
import '../main.dart';
import 'Sign_In.dart';
import '../models/datamodel.dart';

import 'bottom_bar.dart';
import '../providers/logincontroller.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetStartedSTF(),
    );
  }
}

///stf
class GetStartedSTF extends StatefulWidget {
  const GetStartedSTF({Key? key}) : super(key: key);

  @override
  State<GetStartedSTF> createState() => _GetStartedSTFState();
}

class _GetStartedSTFState extends State<GetStartedSTF> {
  ///yaha sa last
  loginPageUI() {
    return Consumer<loginController>(builder: (context, model, child) {
      if (model.usersDetails != null) {
        return Center(
          child: alreadyLoggedInScreen(model),
        );
      } else {
        return notLoggedInScreen();
      }
    });
  }

  alreadyLoggedInScreen(loginController model) {
    return Column(
      children: [
        Container(
          child: CircleAvatar(
            backgroundImage:
                Image.network(model.usersDetails!.photoURL ?? "").image,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            Text(
              model.usersDetails!.displayName ?? "",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
        ActionChip(
          avatar: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Icon(Icons.login),
          ),
          label: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Text(
              "logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () {
            Provider.of<loginController>(context, listen: false)
                .allowUserToSignOut();
          },
        ),
      ],
    );
  }

  notLoggedInScreen() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/1.png'),
            ),
            Container(
              child: GestureDetector(
                child: Image.asset('assets/images/1.png'),
                onTap: () {
                  Provider.of<loginController>(context, listen: false)
                      .allowUserToSignInWithFB();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///fb work
  String welcome = "Facebook";
  Map<String, dynamic>? _userData;
  loginController? provider;

  AccessToken? _accessToken;
  bool _checking = true;

  void _printCredentials() {
    print(
      'Data access: ${_accessToken!.toJson()}',
    );
  }

  Future<void> _login() async {
    _logOut();
    // final LoginResult result = await FacebookAuth.instance
    //     .login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.dialogOnly
        // .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
        );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();

      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
      print('_userData: $userData');
      log(_accessToken!.grantedPermissions![2]);
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      // Sign in with Google
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Use the credential to authenticate with your backend server
      if (googleUser != null && googleUser.email.isNotEmpty) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication.whenComplete(
          () {
            provider!
                .registerNewUser(googleUser.email, googleUser.id.toString(),
                    googleUser.displayName ?? 'Google User')
                .then((value) async {
              print('kakar $value');
              if (provider!.msg == 'The email has already been taken.') {
                final GoogleSignInAccount? googleUser =
                    await _googleSignIn.signInSilently().then((value) {
                  print('sher khan $value');
                  if (value != null) {
                    loginWithGoogle(
                      gEmail: value.email,
                      gPass: value.id.toString(),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error while logging in with google'),
                      ),
                    );
                  }
                  return null;
                });
                print(googleUser);
              } else {
                loginWithGoogle(
                  gEmail: googleUser.email,
                  gPass: googleUser.id.toString(),
                );
              }
            });
          },
        );

        final String? accessToken = googleAuth.accessToken;
        final String? idToken = googleAuth.idToken;

        print(accessToken);
        print(idToken);
      }

      print(googleUser);
    } catch (error) {
      // Handle the error
    }
  }

  late DataModel _datamodel;

  ///cONTROLLERS FOR CONTAROLL THE FIELD

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  ///Create function for registration with the help of internet
  late double width;
  late double height;

  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    provider = Provider.of<loginController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///1St row icon
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyApp()));
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 25.0,
                  color: Color.fromRGBO(52, 107, 33, 1),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
            ),

            ///full name input field
            SizedBox(
              height: 36.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 17.0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.053,
              child: TextFormField(
                controller: nameController,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 173, 25, 1), width: 1.2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(100, 100, 100, 1), width: 1.2),
                  ),
                  hintText: 'Full Name',
                ),
              ),
              // validator: (password) {
              //   if (isPasswordValid(password)) return null;
              //   else
              //     return 'Enter a valid password';
              // },
            ),

            ///email input fields
            SizedBox(
              height: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: 17.0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.053,
              child: TextFormField(
                controller: emailController,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 173, 25, 1), width: 1.2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(100, 100, 100, 1), width: 1.2),
                  ),
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              // validator: (password) {
              //   if (isPasswordValid(password)) return null;
              //   else
              //     return 'Enter a valid password';
              // },
            ),

            ///password input fields
            Container(
              margin: EdgeInsets.only(top: 17.0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.053,
              child: TextFormField(
                controller: passwordController,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: new Icon(
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

            ///5th row confirm password field
            Container(
              margin: EdgeInsets.only(top: 17.0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.053,
              child: TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _obscureText2,
                cursorColor: Color.fromRGBO(100, 100, 100, 1),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                      icon: new Icon(
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

            ///Get started btn
            SizedBox(
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 17.0, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.053,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                ),
                onPressed: () {
                  registerUser();
                },
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mylist()));
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 19.0,
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Divider(
                    color: Colors.black45,
                    height: 5,
                    thickness: 1,
                  ),
                ),
                Container(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(100, 100, 100, 1),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 20.0,
                  ),
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Divider(
                    color: Colors.black45,
                    height: 5,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            ///btns row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _signInWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/google.png'),
                        SizedBox(width: 15),
                        Text(
                          'Google',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: _login,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/facebook-alt.png'),
                        SizedBox(width: 10),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20)
              ],
            ),

            ///have an cccount
            SizedBox(
              height: 16.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => signin1()));
              },
              child: Text(
                'Already have an account?',
                style: TextStyle(
                  color: Color.fromRGBO(20, 20, 20, 1),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Connect Register Api in flutter correct method
  void registerUser() async {
    final provider = Provider.of<loginController>(context, listen: false);
    WidgetConstants.showSnackBar(context, 'Registering...');

    ///ya register ki api ka link ha
    if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      provider
          .registerNewUser(
        emailController.text,
        passwordController.text,
        nameController.text,
      )
          .whenComplete(() {
        if (provider.msg == 'Successfully registered') {
          WidgetConstants.showSnackBar(context, 'Successfully registered');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => signin1(),
              ),
              (route) => false);
        } else {
          WidgetConstants.hideSnackBar(context);
          WidgetConstants.showSnackBar(context, provider.msg);
        }
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide all the details'),
        ),
      );
    }
  }

  void loginWithGoogle({String? gEmail, String? gPass}) async {
    ///ye login ki api ka link ha

    await provider!.login(gEmail!, gPass!).whenComplete(
      () {
        if (provider!.msg == 'Successful') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomBar(),
              ),
              (route) => false);
        } else {
          WidgetConstants.hideSnackBar(context);
          WidgetConstants.showSnackBar(context, provider!.msg);
        }
      },
    );
  }
}
