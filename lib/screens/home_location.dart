import 'package:flutter/material.dart';

class HomeLocation extends StatefulWidget {
  const HomeLocation({Key? key}) : super(key: key);

  @override
  State<HomeLocation> createState() => _HomeLocationState();
}

class _HomeLocationState extends State<HomeLocation> {

  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Home Location',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('+Add Location',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(20,20,20,1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 0,
              indent: 0,
              endIndent: 1,
            ),

          ],
        ),
      ),
    ));
  }
}
