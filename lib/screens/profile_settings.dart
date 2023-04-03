import 'package:flutter/material.dart';
class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late double width;
  late double height;
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: const Text('Profile Settings',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          },icon: Icon(Icons.arrow_back_ios_rounded)),
          centerTitle: true,

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(child: Image.asset('assets/images/Ellipse (2).png')),
            SizedBox(height: 40),

            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: Center(
                child: TextFormField(
                  controller: nameCtr,
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Colors.black54
                          )),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.black45
                      )),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: Center(
                child: TextFormField(
                  controller: emailCtr,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                              color: Colors.black54
                          )),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          color: Colors.black45
                      )),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(0, 173, 25, 1),
              ), child: Text('Save')),
            )

          ],
        ),

      ),
    );
  }
}

