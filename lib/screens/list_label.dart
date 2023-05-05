import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/qr_code.dart';
import '../constant/widget_constants.dart';
import '../providers/list_provider.dart';
import 'add_item.dart';

class ListLabel extends StatefulWidget {
  const ListLabel({Key? key, required this.listId}) : super(key: key);
  final String listId;

  @override
  State<ListLabel> createState() => _ListLabelState();
}

class _ListLabelState extends State<ListLabel> {
  ///for radio button
  int _value = 1;
  ListProvider? provider;

  List<String> options = [
    'low to high',
    'high to low',
    'A-Z',
    'Z-A',
    'Date Modified',
  ];
  String? _selectedOption;

  ///popup menu1
  void _showPopupMenu1() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(180, 80, 600, 500),
      items: [
        PopupMenuItem(
          onTap: () {
            title.value = true;
          },
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Icon(
                  Icons.delete_outline,
                  color: Color.fromRGBO(52, 107, 33, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                  ),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);

              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: options
                          .map(
                            (option) => PopupMenuItem<String>(
                          value: option,
                          child: RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                              Navigator.pop(context, value);
                            },
                            controlAffinity:
                            ListTileControlAffinity.trailing,
                          ),
                        ),
                      )
                          .toList(),
                    );
                  });
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: ImageIcon(
                    AssetImage('assets/images/Vector (2).png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'Sort',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Icon(
                  Icons.share,
                  color: Color.fromRGBO(52, 107, 33, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {});

                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mylist2()));
                  },
                  child: Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(20, 20, 20, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Color.fromRGBO(52, 107, 33, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                ),
                child: Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  ///add contributor popup menu
  void _showPopupMenu3() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(40, 300, 50, 100),
      items: [
        PopupMenuItem(
          child: Container(
            height: height * 0.25,
            child: Column(
              children: [
                ///1st row close icon
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                    color: Color.fromRGBO(52, 107, 33, 1),
                  ),
                ),

                ///2nd row
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Add Contributor',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///3rd row
                SizedBox(
                  height: 4.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          displayText,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(100, 100, 100, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///4th row buttons
                SizedBox(
                  height: 22.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.32,
                        height: height * 0.05,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Color.fromRGBO(0, 173, 25, 1),
                                )),
                            onPressed: () {
                              // changeText();
                            },
                            child: Text(
                              'Limited Access',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(100, 100, 100, 1),
                              ),
                            )),
                      ),
                      Container(
                        width: width * 0.32,
                        height: height * 0.05,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Color.fromRGBO(0, 173, 25, 1),
                                )),
                            onPressed: () {
                              // changeText2();
                            },
                            child: Text(
                              'Full Access',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(100, 100, 100, 1),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),

                ///5th row button
                SizedBox(
                  height: 17.0,
                ),
                Container(
                  margin: EdgeInsets.only(),
                  width: width * 0.7,
                  height: height * 0.045,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => QrCode()));
                    },
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  bool? isChecked = false;
  bool? isChecked2 = false;

  late double height;
  late double width;

  bool _isVisible1 = true;
  bool _isVisible2 = false;
  bool _isVisible3 = false;
  bool _isVisible4 = true;
  bool _isVisible5 = false;

  ///changing text 1
  var displayText = "Select Access Type ";
  ValueNotifier<bool> title = ValueNotifier(false);
  // var String = ['Need approval to make changes'];

  // void changeText() {
  //   setState(() {
  //     displayText = String[Random().nextInt(String.length)];
  //   });
  // }

  ///changing text 2
  // var displayText2 = "Select Access Type ";

  // var String2 = ['Make changes without approval'];

  // void changeText2() {
  //   setState(() {
  //     displayText = String2[Random().nextInt(String2.length)];
  //   });
  // }

  @override
  void initState() {
    provider = Provider.of<ListProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print(widget.listId);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor:Color.fromRGBO(0,173,25,1),
        //   title: Row(
        //     children: [
        //       Container(
        //         child: Icon(Icons.arrow_back_ios_new),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(left: 30.0,),
        //         child: const Text('List Label',
        //           style: TextStyle(
        //             fontSize: 18.0,
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(left: 122.0,),
        //         child: InkWell(
        //           onTap: (){
        //             _showPopupMenu3();
        //           },
        //           child: ImageIcon(
        //             AssetImage('assets/images/Vector (1).png'),
        //
        //
        //           ),
        //         ),
        //
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(),
        //         child: IconButton(
        //           onPressed: (){
        //             _showPopupMenu1();
        //           },
        //           icon: Icon(Icons.more_vert_sharp,size: 23.0,),
        //
        //         ),
        //       ),
        //     ],
        //   ),
        //   automaticallyImplyLeading: false,
        // ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'List Label',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    _showPopupMenu3();
                  },
                  child: Image.asset('assets/images/Vector (1).png')),
              IconButton(
                onPressed: () {
                  _showPopupMenu1();
                },
                icon: Icon(
                  Icons.more_vert_sharp,
                  size: 23.0,
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddItem(
                  isVisible: _isVisible1,
                  isVisible2: _isVisible2,
                  isVisible3: _isVisible3,
                  isVisible4: _isVisible4,
                  isVisible5: _isVisible5,
                  listId: widget.listId,
                )));
            // _showPopupMenu3();
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
        ),
        body: (Column(
          children: [
            SizedBox(
              height: 23.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 173, 25, 1),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 16.0,
                  ),
                  child: Text(
                    'PKR 440',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(20, 20, 20, 1),
                    ),
                  ),
                ),
              ],
            ),

            ///1st card
            SizedBox(height: 15.0),
            Expanded(
              child: FutureBuilder<dynamic>(
                future: provider!.fetchListedItems(widget.listId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error while fetching data from the server'),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data['data'].isEmpty) {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          return tileCard(snapshot.data['data'][index], index);
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: title,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return value == true
                    ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                    ),
                    onPressed: () {
                      WidgetConstants.showSnackBar(
                          context, 'Deleting selected lists');
                      provider!.deleteItems({
                        'gros_list_id': provider!.listIdForItems,
                        'item_id': provider!.idsList[0],
                      }).whenComplete(() {
                        if (provider!.msg == 'item deleted successfully') {
                          WidgetConstants.hideSnackBar(context);
                          setState(() {});
                          WidgetConstants.showSnackBar(
                              context, provider!.msg);
                          title.value = false;
                        } else {
                          WidgetConstants.hideSnackBar(context);
                          WidgetConstants.showSnackBar(
                              context, provider!.msg);
                        }
                      });
                    },
                    child: Text('Delete'))
                    : SizedBox();
              },
            ),
            SizedBox(height: kBottomNavigationBarHeight),

            ///Expanded card
            // Container(
            //   margin: EdgeInsets.only(),
            //   child: Card(
            //     elevation: 5.0,
            //     child: ExpansionTile(
            //       title: Row(
            //         children: [
            //           Container(
            //             margin: EdgeInsets.only(),
            //             child: Image.asset('assets/images/Group 13.png'),
            //           ),
            //           Container(
            //             margin: EdgeInsets.only(
            //               left: 6.0,
            //             ),
            //             child: Text(
            //               'Item Prices In',
            //               style: TextStyle(
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             margin: EdgeInsets.only(
            //               left: 3.0,
            //             ),
            //             child: Text(
            //               'Lahore',
            //               style: TextStyle(
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.green,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       children: [
            //         Container(
            //           width: width * 0.93,
            //           height: height * 0.081,
            //           child: Card(
            //             elevation: 10.0,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Column(
            //                   children: [
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                         right: 92.0,
            //                         top: 10.0,
            //                       ),
            //                       child: Text(
            //                         'Milk',
            //                         style: TextStyle(
            //                           fontSize: 16.0,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                         top: 4.0,
            //                         left: 10.0,
            //                       ),
            //                       child: Row(
            //                         children: [
            //                           Container(
            //                             child: Text(
            //                               'Starting From:',
            //                               style: TextStyle(
            //                                 fontSize: 12.0,
            //                                 fontWeight: FontWeight.w400,
            //                                 color: Colors.green,
            //                               ),
            //                             ),
            //                           ),
            //                           Container(
            //                             margin: EdgeInsets.only(
            //                               left: 3.0,
            //                             ),
            //                             child: Text(
            //                               'PKR 60-80',
            //                               style: TextStyle(
            //                                   fontSize: 12.0,
            //                                   fontWeight: FontWeight.w400),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(
            //                     right: 10.0,
            //                   ),
            //                   child: Icon(
            //                     Icons.close,
            //                     size: 20.0,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Container(
            //           width: width * 0.93,
            //           height: height * 0.081,
            //           child: Card(
            //             elevation: 10.0,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Column(
            //                   children: [
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                         right: 92.0,
            //                         top: 10.0,
            //                       ),
            //                       child: Text(
            //                         'Juice',
            //                         style: TextStyle(
            //                           fontSize: 16.0,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.only(
            //                         top: 4.0,
            //                         left: 10.0,
            //                       ),
            //                       child: Row(
            //                         children: [
            //                           Container(
            //                             child: Text(
            //                               'Starting From:',
            //                               style: TextStyle(
            //                                 fontSize: 12.0,
            //                                 fontWeight: FontWeight.w400,
            //                                 color: Colors.green,
            //                               ),
            //                             ),
            //                           ),
            //                           Container(
            //                             margin: EdgeInsets.only(
            //                               left: 3.0,
            //                             ),
            //                             child: Text(
            //                               'PKR 35-280',
            //                               style: TextStyle(
            //                                   fontSize: 12.0,
            //                                   fontWeight: FontWeight.w400),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(
            //                     right: 10.0,
            //                   ),
            //                   child: Icon(
            //                     Icons.close,
            //                     size: 20.0,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        )),
      ),
    );
  }

  Widget tileCard(dynamic data, int index) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          Consumer<ListProvider>(
            builder: (context, myType, child) {
              return ValueListenableBuilder(
                valueListenable: title,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return title.value == true
                      ? Checkbox(
                      value: myType.myDataList[index].isChecked,
                      onChanged: (value) {
                        myType.toggleItem(data['id'], isListedItem: true);
                      })
                      : SizedBox(width: 20);
                },
              );
            },
          ),
          Container(
              margin: EdgeInsets.only(
                top: 4.0,
              ),
              child: FutureBuilder<String>(
                future: provider!.getSingleItem(data['item_id']),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                    );
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    return Text('Loading...');
                  }
                },
              )),
          Container(
            margin: EdgeInsets.only(top: 16.0, left: 3),
            decoration: BoxDecoration(
                color: Color.fromRGBO(52, 107, 33, 1),
                borderRadius: BorderRadius.circular(4)),
            width: 13,
            height: 15,
            child: Center(
              child: Text(
                'L',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(52, 107, 33, 1),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 15,
            ),
          ),

          ///Stack1
          Spacer(),
          rightContainer('qty', '01'),
          SizedBox(width: 12),
          rightContainer('pkr', '180'),
          SizedBox(width: 12),
          rightContainer('total', '180'),
          SizedBox(width: 25)
        ],
      ),
    );
  }

  Widget rightContainer(String type, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(7)),
          width: 45,
          height: 30,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(20,-5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
            decoration: BoxDecoration(
                color: Color.fromRGBO(52, 107, 33, 1),
                borderRadius: BorderRadius.circular(3)
            ),
            child: Center(
              child: Text(
                type.toUpperCase(),
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}