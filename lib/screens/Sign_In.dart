import 'package:flutter/material.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../constant/widget_constants.dart';
import '../screens/bottom_bar.dart';
import '../main.dart';
import 'forgotpassword.dart';
import 'getstarted.dart';
import '../providers/logincontroller.dart';

import 'loginwithfacebook.dart';

// import 'package:form_field_validator/form_field_validator.dart';
class signin1 extends StatelessWidget {
  const signin1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signin1STF(),
    );
  }
}

///stf
class signin1STF extends StatefulWidget {
  const signin1STF({Key? key})
      : super(
          key: key,
        );

  @override
  State<signin1STF> createState() => _signin1STFState();
}

class _signin1STFState extends State<signin1STF> {
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

  Future<UserCredential> signInFacebook() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: ['email,']);
    if (loginResult == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(loginResult.message);
    }
    setState(() {
      welcome = _userData!['email'];
    });
    final OAuthCredential oAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  loginController? provider;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
              print(value);
              if (provider!.msg == 'The email has already been taken.') {
                final GoogleSignInAccount? googleUser =
                    await _googleSignIn.signInSilently().then((value) {
                  print('value $value');
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

  // int id =40;

  //late double width;
  late double height;

  bool _obscureText = true;

  GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  @override
  void initState() {
    provider = Provider.of<loginController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _FormKey,
              child: Column(
                children: [
                  ///ICON
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        size: 25.0,
                        color: Color.fromRGBO(52, 107, 33, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(20, 20, 20, 1),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _signInWithGoogle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('assets/images/google.png'),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Google',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(20, 20, 20, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginWithFacebook()));
                          },
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
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
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
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
                      ),
                    ],
                  ),

                  ///Email input field
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: 17.0, left: 20, right: 20),
                          height: height * 0.053,
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: Color.fromRGBO(100, 100, 100, 1),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 17.0,
                                top: 10.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 173, 25, 1),
                                    width: 1.2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(100, 100, 100, 1),
                                    width: 1.2),
                              ),
                              hintText: 'Email',
                            ),
                          ),
                        ),

                        ///password
                        Container(
                          margin:
                              EdgeInsets.only(top: 17.0, left: 20, right: 20),
                          height: height * 0.053,
                          child: TextFormField(
                            controller: password,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: _obscureText,
                            cursorColor: Color.fromRGBO(100, 100, 100, 1),
                            validator: (password) {
                              if (password != null || password!.isNotEmpty)
                                return null;
                              else
                                return 'Enter a valid password';
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 15.0,
                                  top: 10.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 173, 25, 1),
                                      width: 1.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(100, 100, 100, 1),
                                      width: 1.2),
                                ),
                                hintText: 'Password',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: new Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  ///forgot password
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  ///SIGN IN btn
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.053,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                        ),
                        onPressed: () {
                          loginUser();

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => BottomBar()));
                        },
                        child: Selector<loginController, bool>(
                          selector: (_, ctr) => ctr.isLoading,
                          builder: (context, isLoading, child) {
                            return provider!.isLoading == true
                                ? CircularProgressIndicator()
                                : Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  );
                          },
                        )),
                  ),

                  ///account text container
                  SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GetStarted()));
                    },
                    child: Text(
                      'Don\'t have an account?',
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
          ],
        ),
      ),
    );
  }

  ///Login user correct api
  void loginUser({String? gEmail, String? gPass}) async {
    ///ye login ki api ka link ha

    if (email.text.isEmpty || password.text.isEmpty) {
      WidgetConstants.showSnackBar(context, 'Please proivde the above details');
    } else {
      await provider!
          .login(gEmail ?? email.text, gPass ?? password.text)
          .whenComplete(
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

///how to connect external sdk in flutter
