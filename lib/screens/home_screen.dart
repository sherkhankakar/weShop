import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../constant/widget_constants.dart';
import '../providers/list_provider.dart';
import 'list_label.dart';

///stf
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///show save button when field is fill
  final emailController = TextEditingController();
  bool _isButtonEnabled = false;
  ListProvider? provider;

  @override
  void initState() {
    provider = Provider.of<ListProvider>(context, listen: false);
    super.initState();
    emailController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty;
    });
  }

  ///for active button
  bool isButtonActive = true;

  String datatochange = "Delete";

  ///ya function check box ma use ho raha text ko update karna k lie
  void changedata() {
    setState(() {
      datatochange = "1 item Selected";
    });
  }

  String datatochange1 = "Share";

  ///ya function check box ma use ho raha text ko update karna k lie
  void changedata1() {
    setState(() {
      datatochange1 = "1Selected";
    });
  }

  String datatochange2 = "Edit";

  ///ya function check box ma use ho raha text ko update karna k lie
  void changedata2() {
    setState(() {
      datatochange2 = "1Selected";
    });
  }

  ///apply visibility
  bool _isVisible = true;
  bool _isVisible2 = false;
  bool _isVisible3 = true;
  bool _isVisible4 = false;
  bool _isVisible5 = true;
  bool _isVisible6 = false;
  bool _isVisible7 = false;
  bool _isVisible8 = false;
  bool _isVisible9 = true;
  bool _isVisible10 = false;
  bool _isVisible11 = false;
  bool _isVisible12 = false;
  bool _isVisible13 = false;
  bool? isChecked = false;

  ///control navbar into 2nd navbar
  Widget appBarTitle = new Text("My app bar title");

  final _textController = TextEditingController();

  bool _validate = false;

  String UserPost = "";

  String deletepost = "";

  ValueNotifier<bool> isEmptyList = ValueNotifier(false);

  ///popup menu 1
  void _showPopupMenu3({bool? isEditing = false, String? listId}) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(70, 300, 170, 150),
      items: [
        PopupMenuItem(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(52, 107, 33, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5.0,
                    ),
                    child: Center(
                        child: Text(
                      isEditing == true ? "Update List" : "New List",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5.0,
                      top: 7.0,
                    ),
                    child: Center(
                        child: Text(
                      "Enter new list name",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(100, 100, 100, 1),
                      ),
                    )),
                  ),

                  ///input field
                  Container(
                    width: width * 0.93,
                    height: height * 0.07,
                    margin: EdgeInsets.only(
                      top: 17.0,
                    ),
                    child: TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      // maxLengthEnforcement: true,
                      maxLength: 10,

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 5.0,
                          left: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(100, 100, 100, 1),
                              width: 1.2),
                        ),
                        hintText: 'List Name',
                      ),
                    ),

                    // validator: (password) {
                    //   if (isPasswordValid(password)) return null;
                    //   else
                    //     return 'Enter a valid password';
                    // },
                  ),
                  // Text("${name}"),
                  ///btn
                  SizedBox(
                    height: 14.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: MediaQuery.of(context).size.height * 0.042,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                      ),
                      onPressed: () {
                        // store.dispatch(ReplayAction(timerBloc, varBloc.fireAnalytics));
                        // Navigator.pop(context);
                        // UserPost = _textController.text;
                        // setState(() {
                        //   _textController.text.isEmpty
                        //       ? _validate = false
                        //       : _validate = true;
                        //   if (_isVisible = false) {
                        //   } else if (_isVisible2 = true) {}
                        // });
                        isEditing == false
                            ? provider!
                                .addNewList(_textController.text)
                                .whenComplete(() {
                                if (provider!.msg ==
                                    'List added successfully') {
                                  Navigator.of(context).pop();
                                  setState(() {});
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                } else {
                                  Navigator.of(context).pop();
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                }
                                _textController.clear();
                              })
                            : provider!
                                .updateListName(_textController.text, listId!)
                                .whenComplete(() {
                                if (provider!.msg ==
                                    'List updated successfully') {
                                  Navigator.of(context).pop();
                                  setState(() {});
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                } else {
                                  Navigator.of(context).pop();
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                }
                                _textController.clear();
                              });
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
        ),
      ],
      elevation: 4.0,
    );
  }

  ///pop up menu 2
  void _showPopupMenu4() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(220, 80, 0, 500),
      items: [
        ///2nd item delete button
        PopupMenuItem(
          onTap: () {
            title.value = 'Delete';
          },
          child: Row(
            children: [
              const Icon(
                Icons.delete_outline,
                color: Color.fromRGBO(52, 107, 33, 1),
              ),
              SizedBox(width: 15),
              Text(
                'Delete',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const Icon(
                Icons.qr_code_scanner_rounded,
                color: Color.fromRGBO(52, 107, 33, 1),
              ),
              SizedBox(width: 15),
              Text(
                'Scan QR Code',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ],
      elevation: 4.0,
    );
  }

  ///bottom navbar
  int _currentIndex = 0;

  late double width;
  late double height;

  static get actions => false;

  ValueNotifier<String> title = ValueNotifier('My Lists');

  /// for checkbox
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // final tabs = [
    //   ///List Screen
    //   Column(
    //     children: [
    //       SizedBox(
    //         height: 20.0,
    //       ),
    //       ///List card
    //       Visibility(
    //         visible: _isVisible2,
    //         child: Container(
    //           margin: EdgeInsets.symmetric(horizontal: 10),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height * 0.096,
    //           child: InkWell(
    //             onDoubleTap: changedata1,
    //             onTap: () {
    //               Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (context) => ListLabel()));
    //             },
    //             child: Card(
    //               elevation: 3.0,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     height: 40,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             ///check boxxxxxx
    //                             Visibility(
    //                               visible: _isVisible4,
    //                               child: Container(
    //                                 margin: EdgeInsets.only(),
    //                                 child: Visibility(
    //                                   child: InkWell(
    //                                     onLongPress: changedata,
    //                                     child: Checkbox(
    //                                       side: BorderSide(color: Colors.green),
    //                                       value: isChecked,
    //                                       activeColor: Colors.green,
    //                                       onChanged: (newBool) {
    //                                         setState(() {
    //                                           isChecked = newBool;
    //                                           if (_isVisible6 = true) {}
    //                                         });
    //                                       },
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             ///checkbox 2
    //                             Visibility(
    //                               visible: _isVisible8,
    //                               child: Container(
    //                                 margin: EdgeInsets.only(),
    //                                 child: Visibility(
    //                                   child: InkWell(
    //                                     onLongPress: changedata1,
    //                                     child: Checkbox(
    //                                       side: BorderSide(color: Colors.green),
    //                                       value: isChecked,
    //                                       activeColor: Colors.green,
    //                                       onChanged: (newBool) {
    //                                         setState(() {
    //                                           isChecked = newBool;
    //                                           if (_isVisible10 = true) {}
    //                                         });
    //                                       },
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             ///Visibility 3
    //                             Visibility(
    //                               visible: _isVisible12,
    //                               child: Container(
    //                                 margin: EdgeInsets.only(),
    //                                 child: Visibility(
    //                                   child: InkWell(
    //                                     onDoubleTap: changedata2,
    //                                     child: Checkbox(
    //                                       side: BorderSide(color: Colors.green),
    //                                       value: isChecked,
    //                                       activeColor: Colors.green,
    //                                       onChanged: (newBool) {
    //                                         setState(() {
    //                                           isChecked = newBool;
    //                                           if (_isVisible13 = true) {}
    //                                         });
    //                                       },
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.only(left: 10),
    //                               child: Text(
    //                                 maxLines: 1,
    //                                 overflow: TextOverflow.ellipsis,
    //                                 UserPost,
    //                                 style: TextStyle(
    //                                   fontWeight: FontWeight.w500,
    //                                   fontSize: 18.0,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(right: 10),
    //                           child: Text(
    //                             'PKR 0.00',
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: 14.0,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 10),
    //                     child: Align(
    //                       alignment: Alignment.topLeft,
    //                       child: Text(
    //                         'items: 0',
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.w400,
    //                           fontSize: 13.0,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 140.0,
    //       ),
    //       /// apply visibilty
    //       Visibility(
    //         visible: _isVisible,
    //         child: Center(
    //           child: Column(
    //             children: [
    //               Image.asset('assets/images/Frame (1).png'),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 'Create list to show here',
    //                 style: TextStyle(
    //                   fontSize: 13.0,
    //                   fontWeight: FontWeight.w400,
    //                   color: Color.fromRGBO(151, 151, 151, 1),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       // SizedBox(
    //       //   height: 200.0,
    //       // ),
    //       Visibility(
    //         visible: _isVisible9,
    //         child: Container(
    //           margin: EdgeInsets.only(right: 30.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: Color.fromRGBO(0, 173, 25, 1),
    //                   shape: CircleBorder(),
    //                   padding: EdgeInsets.all(16),
    //                 ),
    //                 onPressed: () {
    //                   _showPopupMenu3();
    //                 },
    //                 child: Icon(Icons.add),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       ///Delete button

    //       Visibility(
    //         visible: true,
    //         child: Container(
    //           margin: EdgeInsets.only(top: 150.0, left: 20, right: 20),
    //           width: width,
    //           height: height * 0.05,
    //           child:
    //       ),
    //       ///Share Button
    //       Visibility(
    //         visible: _isVisible10,
    //         child: Container(
    //           margin: EdgeInsets.only(top: 140.0, left: 20, right: 20),
    //           width: width,
    //           height: height * 0.05,
    //           child: ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Color.fromRGBO(0, 173, 25, 1),
    //             ),
    //             onPressed: () async {
    //               ///ya kam phone ki gallery ma sa image kasa pick karni ha islie kia ha
    //               // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //               // if(image == null)return;
    //               // await Share.shareFiles([image.path]);
    //               Share.share(
    //                   "https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
    //             },
    //             child: Text('Share'),
    //           ),
    //         ),
    //       ),
    //       ///Edit Button
    //       Visibility(
    //         visible: _isVisible13,
    //         child: Container(
    //           margin: EdgeInsets.only(top: 140.0, left: 20, right: 20),
    //           width: width,
    //           height: height * 0.05,
    //           child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: Colors.green,
    //               ),
    //               onPressed: () async {
    //                 ///ya kam phone  ki gallery ma sa image kasa pick karni ha islie kia ha
    //                 // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //                 // if(image == null)return;
    //                 // await Share.shareFiles([image.path]);
    //                 // Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
    //                 _showPopupMenu3();
    //               },
    //               child: Text('Edit')),
    //         ),
    //       ),
    //     ],
    //   ),
    // ];
    ///popup menu phla yaha call hoti ha but humna uper menu ma kam kia ha to islie function ko bhi uper call kara gan

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showPopupMenu3();
          },
          backgroundColor: Color.fromRGBO(0, 173, 25, 1),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            ///1st appbar
            ValueListenableBuilder(
              valueListenable: title,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return AppBar(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  centerTitle: false,
                  title: Row(
                    children: [
                      if (value != 'My Lists')
                        IconButton(
                          onPressed: () {
                            title.value = 'My Lists';
                          },
                          icon: Icon(
                            Icons.close,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          title.value,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    if (value == 'My Lists')
                      IconButton(
                        onPressed: () async {},
                        icon: Icon(Icons.share),
                      ),
                    if (value == 'My Lists')
                      IconButton(
                        onPressed: () {
                          _showPopupMenu4();
                        },
                        icon: Icon(
                          Icons.more_vert_sharp,
                          size: 25.0,
                        ),
                      ),
                  ],
                  automaticallyImplyLeading: false,
                );
              },
            ),

            ///2nd appbar
            Visibility(
              visible: _isVisible4,
              child: Container(
                child: AppBar(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_isVisible4 = false) {}
                                if (_isVisible6 = false) {}
                                if (_isVisible5 = true) {}
                                if (_isVisible3 = true) {}
                                if (_isVisible9 = true) {}
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 50.0,
                        ),
                        child: Text(
                          datatochange,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///3rd appbar
            Visibility(
              visible: _isVisible7,
              child: Container(
                child: AppBar(
                  backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_isVisible7 = false) {}
                                if (_isVisible10 = false) {}
                                if (_isVisible8 = false) {}
                                if (_isVisible12 = false) {}
                                if (_isVisible9 = true) {}
                                if (_isVisible5 = true) {}
                                if (_isVisible3 = true) {}
                              });
                            },
                            child: Icon(Icons.close)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 50.0,
                        ),
                        child: Text(datatochange1),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///4th app bar
            ///
            ///
            Visibility(
              visible: _isVisible11,
              child: Container(
                child: AppBar(
                  backgroundColor: Colors.green,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_isVisible11 = false) {}
                                if (_isVisible3 = true) {}
                                if (_isVisible5 = true) {}
                                if (_isVisible4 = false) {}
                                if (_isVisible8 = false) {}
                                if (_isVisible12 = false) {}
                                if (_isVisible9 = true) {}
                                if (_isVisible13 = false) {}
                              });
                            },
                            child: Icon(Icons.close)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 50.0,
                        ),
                        child: Text(datatochange2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///Bottom navbar
            // Container(child: tabs[_currentIndex]),
            Expanded(
              child: StreamBuilder<dynamic>(
                stream: provider!.getLists(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error while loading data from the server'),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data['data']['glists'].isEmpty) {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return customCard(
                          snapshot.data['data']['glists'][index],
                          index,
                        );
                      },
                      itemCount: snapshot.data['data']['glists'].length,
                    );
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
                return value == 'Delete'
                    ? Container(
                        width: width,
                        margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(0, 173, 25, 1),
                            ),
                            onPressed: () {
                              WidgetConstants.showSnackBar(
                                  context, 'Deleting selected lists');
                              provider!
                                  .deleteList(provider!.idsList[0])
                                  .whenComplete(() {
                                if (provider!.msg ==
                                    'List deleted successfully') {
                                  WidgetConstants.hideSnackBar(context);
                                  setState(() {});
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                } else {
                                  WidgetConstants.hideSnackBar(context);
                                  WidgetConstants.showSnackBar(
                                      context, provider!.msg);
                                }
                              });
                            },
                            child: Text('Delete')),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customCard(dynamic data, int index) {
    data['list_item'].isEmpty
        ? isEmptyList.value = false
        : isEmptyList.value = true;
    print(data['list_item'].length);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ListLabel(listId: data['id'].toString()),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        elevation: 3.0,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Consumer<ListProvider>(
            builder: (context, myType, child) {
              return ValueListenableBuilder(
                valueListenable: title,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return title.value == 'Delete'
                      ? Checkbox(
                          value: myType.myDataList[index].isChecked,
                          onChanged: (value) {
                            myType.toggleItem(data['id']);
                          })
                      : SizedBox();
                },
              );
            },
          ),
          minLeadingWidth: 0,
          title: Row(
            children: [
              Text(
                data['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _showPopupMenu3(
                      isEditing: true, listId: data['id'].toString());
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          subtitle: ValueListenableBuilder(
            valueListenable: isEmptyList,
            builder: (BuildContext context, bool value, Widget? child) {
              return Text(
                'items: ${provider!.gListLength[index]}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                    color: Colors.black),
              );
            },
          ),
          trailing: Text(
            'PKR 0.00',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}

/*
ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return value == 'Delete'
                  ? Selector<ListProvider, bool>(
                      selector: (_, myType) => provider!.isChecked,
                      builder: (context, isChecked, child) {
                        return
                      },
                    )
                  : SizedBox();
            },
          ),
 */
