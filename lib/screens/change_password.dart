import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  
  
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: const Text('Change Password',
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
          children: [
            SizedBox(height: 20),
            textfieldContainer('Current Password'),
            SizedBox(height: 15),
            textfieldContainer('New Password'),
            SizedBox(height: 15),
            textfieldContainer('Confirm Password'),
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

  textfieldContainer(String hint){
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 20,),
      child: Center(
        child: TextFormField(
          //controller: Ctr,
          keyboardType: TextInputType.name,
          obscureText: true,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            focusColor: Color.fromRGBO(0, 173, 25, 1),

            focusedBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  width: 2,
                    color: Colors.green
                )),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                      color: Colors.black54
                  )),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.black45
              )),
        ),
      ),
    );
  }

}
