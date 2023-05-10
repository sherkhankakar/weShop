import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weshop/providers/list_provider.dart';

import '../constant/widget_constants.dart';

///stf
class AddItem extends StatefulWidget {
  const AddItem({
    Key? key,
    required bool isVisible,
    required bool isVisible2,
    required bool isVisible3,
    required bool isVisible4,
    required bool isVisible5,
    required this.listId,
  }) : super(key: key);
  final String listId;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool isVisible2 = true;
  bool isVisible1 = false;
  bool isVisible3 = true;

  late double height;
  late double width;

  ValueNotifier<int> currentIndex = ValueNotifier(-1);
  Color _selectedColor = Colors.green; // initial border color
  Color _unselectedColor = Colors.black; // initial border color

  // bool _isLeftSelected = false;
  // bool _isRightSelected = false;

  List<String> units = ['Dozen', 'Half Dozen'];

  // void handleLeftContainerTap() {
  //   setState(() {
  //     _isLeftSelected = true;
  //     _isRightSelected = false;
  //   });
  // }

  // void handleRightContainerTap() {
  //   setState(() {
  //     _isLeftSelected = false;
  //     _isRightSelected = true;
  //   });
  // }

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
                      Navigator.of(context).pop();
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
        body: (Column(
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
            Expanded(
              child: FutureBuilder<dynamic>(
                future: Provider.of<ListProvider>(context, listen: false)
                    .getAllItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error while loading data from the server'),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data['data'].isEmpty) {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return containerTile(
                          snapshot.data['data'][index]['name'],
                          'Dozen',
                          'Half Dozen',
                          () {
                            // handleLeftContainerTap();
                            return null;
                          },
                          () {
                            // handleRightContainerTap();
                            return null;
                          },
                          index,
                          snapshot.data['data'][index]['id'].toString(),
                        );
                      },
                      itemCount: snapshot.data['data'].length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  containerTile(
    String title,
    String largeQuantity,
    String smallQuantity,
    Function? tap1(),
    Function? tap2(),
    int currInd,
    String itemId,
  ) {
    final provider = Provider.of<ListProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
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
                height: 35,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Text(
                      'Select Unit:',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(width: 20),
                    // Consumer<ListProvider>(
                    //   builder: (context, dropdownValue, child) =>
                    //       DropdownButton<String>(
                    //     value: dropdownValue.selectedValue,
                    //     onChanged: (String? value) {
                    //       dropdownValue.setSelectedValue(value!);
                    //     },
                    //     items: [
                    //       DropdownMenuItem<String>(
                    //         value: 'Dozen',
                    //         child: Text('Dozen'),
                    //       ),
                    //       DropdownMenuItem<String>(
                    //         value: 'Option 2',
                    //         child: Text('Option 2'),
                    //       ),
                    //       DropdownMenuItem<String>(
                    //         value: 'Option 3',
                    //         child: Text('Option 3'),
                    //       ),
                    //     ],
                    //   ),
                    // )

                    Expanded(
                      child: ListView.builder(
                        itemCount: units.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return unitsRow(index, currInd);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 25,
                  margin: EdgeInsets.only(bottom: 10, right: 5, top: 5),
                  child: ElevatedButton(
                    onPressed: () async {
                      WidgetConstants.showSnackBar(
                          context, 'Adding item to list...');
                      provider
                          .addItemsToList(widget.listId, itemId)
                          .whenComplete(() {
                        if (provider.msg == 'List added successfully') {
                          WidgetConstants.hideSnackBar(context);
                          WidgetConstants.showSnackBar(
                              context, 'Item added to the list successfully');
                          Navigator.of(context).pop();
                        } else {
                          WidgetConstants.hideSnackBar(context);
                          WidgetConstants.showSnackBar(context, provider.msg);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide.none),
                    ),
                    child: Text('Add Item'),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget unitsRow(int index, int currInd) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return GestureDetector(
          onTap: () {
            currentIndex.value = index;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: currentIndex.value == index
                    ? _selectedColor
                    : _unselectedColor,
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              units[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }
}
