import 'list_label.dart';
import 'package:flutter/material.dart';

///stf
class AddItem extends StatefulWidget {
  const AddItem({
    Key? key,
    required bool isVisible,
    required bool isVisible2,
    required bool isVisible3,
    required bool isVisible4,
    required bool isVisible5,
  }) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool isVisible2 = true;
  bool isVisible1 = false;
  bool isVisible3 = true;

  late double height;
  late double width;

  int currentIndex = 0;
  Color _selectedColor = Colors.green; // initial border color
  Color _unselectedColor = Colors.black; // initial border color

  bool _isLeftSelected = false;
  bool _isRightSelected = false;

  void handleLeftContainerTap() {
    setState(() {
      _isLeftSelected = true;
      _isRightSelected = false;
    });
  }

  void handleRightContainerTap() {
    setState(() {
      _isLeftSelected = false;
      _isRightSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          title: Row(
            children: [
              Container(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isVisible2 = true) {}
                        if (isVisible3 = true) {}
                        if (isVisible1 = false) {}
                      });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ListLabel()));
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 30.0,
                ),
                child: const Text(
                  'Add Item',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: (Column(
            children: [
              SizedBox(
                height: 30.0,
              ),

              ///Search bar
              Container(
                margin: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                width: width * 0.9,
                height: height * 0.05,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 173, 25, 1),
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromRGBO(100, 100, 100, 1),
                      )),
                      contentPadding: EdgeInsets.only(top: 8.0),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(100, 100, 100, 1),
                        fontSize: 18.0,
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.only(),
                        child: Icon(
                          Icons.search,
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                        // child: Image.asset('assets/icons/search.png'),
                        width: 18,
                      )),
                ),
              ),

              ///card
              SizedBox(
                height: 20.0,
              ),
              containerTile(
                "Milk",
                'L',
                'mL', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },
              ),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Eggs", 'Dozen', 'Half Dozen', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Ketchup", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Flour", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Mayonnaise", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Salt", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Sugar", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Juice", 'L', 'mL', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
              SizedBox(
                height: 10.0,
              ),
              containerTile("Cheese", 'kg', 'Half kg', () {
                handleLeftContainerTap();
                return null;
              },() {
                handleRightContainerTap();
                return null;
              },),
            ],
          )),
        ),
      ),
    );
  }

  containerTile(String title, String largeQuantity, String smallQuantity,
      Function? tap1(), Function? tap2()) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          children: [
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Text(
                    'Select Unit:',
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: tap1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _isLeftSelected
                              ? _selectedColor
                              : _unselectedColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        largeQuantity,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: tap2,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _isRightSelected
                              ? _selectedColor
                              : _unselectedColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        smallQuantity,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
