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

  ///popup menu1
  void _showPopupMenu1() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(180, 80, 600, 500),
      items: [
        PopupMenuItem(
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
                child: InkWell(
                  onTap: () {
                    title.value = true;
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.87),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: InkWell(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 280,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 15.0,
                                left: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'Sort By',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 13.0,
                                    ),
                                    child: Text(
                                      'Price: High to low',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Radio(
                                      activeColor:
                                      Color.fromRGBO(52, 107, 33, 1),
                                      value: 1,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 13.0,
                                    ),
                                    child: Text(
                                      'Price: low to high',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Radio(
                                      activeColor:
                                      Color.fromRGBO(52, 107, 33, 1),
                                      value: 2,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 13.0,
                                    ),
                                    child: Text(
                                      'Data modified',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Radio(
                                      activeColor:
                                      Color.fromRGBO(52, 107, 33, 1),
                                      value: 3,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 13.0,
                                    ),
                                    child: Text(
                                      'Alphabetically (A-Z)',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Radio(
                                      activeColor:
                                      Color.fromRGBO(52, 107, 33, 1),
                                      value: 4,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 13.0,
                                    ),
                                    child: Text(
                                      'Alphabetically (Z-A)',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(20, 20, 20, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Radio(
                                      activeColor:
                                      Color.fromRGBO(52, 107, 33, 1),
                                      value: 5,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                });
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 280,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Sort By',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color:
                                          Color.fromRGBO(100, 100, 100, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 13.0,
                                      ),
                                      child: Text(
                                        'Price: High to low',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(20, 20, 20, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Radio(
                                        activeColor:
                                        Color.fromRGBO(52, 107, 33, 1),
                                        value: 1,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 13.0,
                                      ),
                                      child: Text(
                                        'Price: low to high',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(20, 20, 20, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Radio(
                                        activeColor:
                                        Color.fromRGBO(52, 107, 33, 1),
                                        value: 2,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 13.0,
                                      ),
                                      child: Text(
                                        'Data modified',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(20, 20, 20, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Radio(
                                        activeColor:
                                        Color.fromRGBO(52, 107, 33, 1),
                                        value: 3,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 13.0,
                                      ),
                                      child: Text(
                                        'Alphabetically (A-Z)',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(20, 20, 20, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Radio(
                                        activeColor:
                                        Color.fromRGBO(52, 107, 33, 1),
                                        value: 4,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 13.0,
                                      ),
                                      child: Text(
                                        'Alphabetically (Z-A)',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(20, 20, 20, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Radio(
                                        activeColor:
                                        Color.fromRGBO(52, 107, 33, 1),
                                        value: 5,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 280,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 15.0,
                                          left: 12.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Sort By',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      100, 100, 100, 1),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 13.0,
                                              ),
                                              child: Text(
                                                'Price: High to low',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      20, 20, 20, 1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10.0,
                                              ),
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    52, 107, 33, 1),
                                                value: 1,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 13.0,
                                              ),
                                              child: Text(
                                                'Price: low to high',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      20, 20, 20, 1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10.0,
                                              ),
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    52, 107, 33, 1),
                                                value: 2,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 13.0,
                                              ),
                                              child: Text(
                                                'Data modified',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      20, 20, 20, 1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10.0,
                                              ),
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    52, 107, 33, 1),
                                                value: 3,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 13.0,
                                              ),
                                              child: Text(
                                                'Alphabetically (A-Z)',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      20, 20, 20, 1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10.0,
                                              ),
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    52, 107, 33, 1),
                                                value: 4,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 13.0,
                                              ),
                                              child: Text(
                                                'Alphabetically (Z-A)',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      20, 20, 20, 1),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10.0,
                                              ),
                                              child: Radio(
                                                activeColor: Color.fromRGBO(
                                                    52, 107, 33, 1),
                                                value: 5,
                                                groupValue: _value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mylist2()));
                      },
                      child: Text(
                        'Sort',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    setState(() {
                      if (_isVisible4 = false) {}
                      if (_isVisible5 = true) {}
                    });
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
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
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
    return Card(
      elevation: 3.0,
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
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(
                top: 4.0,bottom: 10
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
            margin: EdgeInsets.only(
              top: 14.0,
            ),
            width: width * 0.05,
            height: height * 0.02,
            child: Card(
              color: Color.fromRGBO(52, 107, 33, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
              child: Container(
                margin: EdgeInsets.only(
                  left: 2.2,
                ),
                child: Text(
                  'L',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green
            ),
            child: Center(child: Icon(Icons.edit,color: Colors.white,size: 17,)),
          ),

          ///Stack1
          Spacer(),
          rightContainer('qty', '01'),
          SizedBox(width: 9),
          rightContainer('pkr', '180'),
          SizedBox(width: 9),
          rightContainer('total', '180'),
          SizedBox(width: 25)
        ],
      ),
    );
  }

  Widget rightContainer(String type, String text) {
    return Stack(
      children: [
        Container(
          width: width * 0.13,
          height: height * 0.04,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: Color.fromRGBO(0, 173, 25, 1),
                )),
            child: Container(
              margin: EdgeInsets.only(
                left: 12.0,
                top: 5.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: -4,
          child: Container(
            child: Card(
              color: Color.fromRGBO(52, 107, 33, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              child: Container(
                margin: EdgeInsets.only(
                  left: 2.0,
                  top: 1.0,
                ),
                child: Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    fontSize: 7.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}