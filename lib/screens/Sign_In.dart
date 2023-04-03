import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:weshop/screens/bottom_bar.dart';
import '../main.dart';
import '../models/datamodel.dart';
import 'forgotpassword.dart';
import 'getstarted.dart';
import 'logincontroller.dart';
import 'loginwithfacebook.dart';
import 'package:flutter/material.dart';

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
  const signin1STF({Key? key}) : super(key: key,);

  @override
  State<signin1STF> createState() => _signin1STFState();
}

class _signin1STFState extends State<signin1STF> {
  ///yaha sa last
  loginPageUI()
  {
    return Consumer<loginController>(builder: (context,model,child){
      if(model.usersDetails != null){
        return Center(
          child: alreadyLoggedInScreen(model),
        );
      }else{
        return notLoggedInScreen();
      }
    });
  }
  alreadyLoggedInScreen(loginController model){
    return Column(
      children: [
        Container(
          child: CircleAvatar(
            backgroundImage: Image.network(model.usersDetails!.photoURL ?? "").image,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            Text(
              model.usersDetails!.displayName ?? "",
              style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
            ),
          ],
        ),
        ActionChip(
          avatar: Padding(
            padding: EdgeInsets.only(left: 15.0,right: 15.0,),
            child: Icon(Icons.login),
          ),
          label: Padding(
            padding: EdgeInsets.only(left: 15.0,right: 15.0,),
            child: Text("logout",style: TextStyle(color: Colors.white),),
          ),
          onPressed: (){
            Provider.of<loginController>(context, listen: false).allowUserToSignOut();
          },
        ),
      ],
    );

  }
  notLoggedInScreen(){
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
                onTap: (){
                  Provider.of<loginController>(context, listen: false).allowUserToSignInWithFB();
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
  Map<String,dynamic>? _userData;
 Future <UserCredential> signInFacebook() async {
   final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email,']);
   if(loginResult == LoginStatus.success){
     final userData = await FacebookAuth.instance.getUserData();
     _userData = userData;
   }else{
     print(loginResult.message);
   }
   setState(() {
     welcome = _userData!['email'];
   });
   final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
   return FirebaseAuth.instance.signInWithCredential(oAuthCredential);

  }
  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }



  late DataModel _datamodel;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // int id =40;

  late double width;
  late double height;

  bool _obscureText = true;


  GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // String token;


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


    var obscureText = true;


    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _FormKey,
              child: Column(
                children: [
                  ///ICON
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(),
                          child: IconButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
                            },
                            icon:Icon( Icons.arrow_back_outlined,size: 25.0,color: Color.fromRGBO(52,107,33,1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// Signin text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 23.0,left:15.0, ),
                        child: Text('Sign In',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(20,20,20,1),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///btns row
                  Container(
                    margin: EdgeInsets.only(top: 50.0,),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 19.0,),
                          width: MediaQuery.of(context).size.width*0.43,
                          height: MediaQuery.of(context).size.height*0.05,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color.fromRGBO(234,234,234,1) ),
                              ),
                              onPressed: (){
                                _googleSignIn.signIn().then((value){
                                  String userName = value!.displayName!;
                                  String profilePicture = value!.photoUrl!;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset('assets/images/google.png'),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 25.0,),
                                    child: Text('Google',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(20,20,20,1),

                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 9.0,),
                          width: MediaQuery.of(context).size.width*0.43,
                          height: MediaQuery.of(context).size.height*0.05,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color.fromRGBO(234,234,234,1) ),
                              ),
                              onPressed: () async{
                                // signInFacebook();
                                // signInWithFacebook();
                                // final LoginResult result = await FacebookAuth.instance.login();
                                // if (result.status == LoginStatus.success) {
                                //   final AccessToken accessToken = result.accessToken!;
                                //   // Use the access token to make Facebook API calls
                                // } else {
                                //   print(result.message);
                                // }
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithFacebook()));


                              },
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset('assets/images/facebook-alt.png'),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 25.0,),
                                    child: Text('facebook',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(20,20,20,1),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// Horizontal lines row
                  Container(
                    margin: EdgeInsets.only(top: 20.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 19.0,),
                          width: width*0.38,
                          child: Divider(
                            color: Color.fromRGBO(210,209,209,1),
                            height: 5,
                            thickness: 1,
                            indent: 1,
                            endIndent: 3,
                          ),
                        ),
                        Container(
                          child: Text('Or',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(100,100,100,1),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right:20.0,),
                          width: width*0.38,
                          child: Divider(
                            color: Color.fromRGBO(210,209,209,1),
                            height: 5,
                            thickness: 1,
                            indent: 1,
                            endIndent: 3,
                          ),
                        ),
                      ],
                    ),
                  ),


                  ///Email input field
                  Container(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 17.0,),
                          width: width*0.93,
                          height: height*0.053,
                          child: TextFormField(
                            controller: email,
                            validator: (value){
                              if(value == null || value.isEmpty ){
                                // return 'Please enter your email';
                              }
                            },
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: Color.fromRGBO(100,100,100,1),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 17.0,top:10.0,),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(0, 173, 25, 1), width: 1.2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(100,100,100,1), width: 1.2),
                              ),
                              hintText: 'Email',
                            ),
                          ),
                          // validator: (password) {
                          //   if (isPasswordValid(password)) return null;
                          //   else
                          //     return 'Enter a valid password';
                          // },
                        ),
                        ///password
                        Container(
                          margin: EdgeInsets.only(top: 17.0,),
                          width: width*0.93,
                          height: height*0.053,
                          child: TextFormField(
                            controller: password,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: _obscureText,
                            cursorColor: Color.fromRGBO(100,100,100,1),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0,top:10.0,),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(0,173,25,1), width: 1.2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(100,100,100,1), width: 1.2),
                                ),
                                hintText: 'Password',
                                suffixIcon:  GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: new Icon(
                                    _obscureText ?
                                    Icons.visibility_off: Icons.visibility,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                )
                            ),
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
                      ],
                    ),
                  ),

















                  ///forgot password
                  Container(
                    margin: EdgeInsets.only(right: 14.5,top: 10.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => forgotpassword()));
                          },
                          child: Container(
                            child: Text('Forgot password?',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.black
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ///SIGN IN btn
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(),
                    width: MediaQuery.of(context).size.width*0.93,
                    height: MediaQuery.of(context).size.height*0.053,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0,173,25,1),
                      ),
                      onPressed:() async{
                        // loginUser;
                        // _handleLogin();
                        loginUser();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomBar()));
                      },

                      child: Text('Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(255,255,255,1),
                        ),
                      ),
                    ),
                  ),
                  ///account text container
                  SizedBox(
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetStarted()));
                    },
                    child: Container(
                      child: Center(
                        child: Text('Don\'t have an account?',
                          style: TextStyle(
                            color: Color.fromRGBO(20,20,20,1),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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
  void loginUser() async{
    ///ye login ki api ka link ha
    var url ="http://192.168.18.60/admindashboard/weshop/public/api/login";
    var data={
      "email" : email.text,
      "password" : password.text,
    };
    var bodyy=json.encode(data);
    var urlParse= Uri.parse(url);
    Response response =  await http.post(
        urlParse,
        body: bodyy,
        headers: {
          "Content-Type": "application/json",
        }
    );

    var dataa=jsonDecode(response.body);
    print(dataa);
    print(response.body);
  }

}
///how to connect external sdk in flutter



