import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/alert_dialog.dart';
import '../components/item_screen_component.dart';
import '../constant/widget_constants.dart';
import '../models/list_model.dart';
import '../providers/list_provider.dart';
import '../translations/locale_keys.g.dart';
import 'add_item.dart';
import 'qr_scanner_screen.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key, required this.listId, required this.listName});
  final String listId;
  final String listName;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  ListProvider? provider;

  final priceCtr = TextEditingController();
  final qtyCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          LocaleKeys.list_label.tr(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogComponent(
                    listId: widget.listId,
                  );
                },
              );
            },
            icon: Image.asset('assets/images/Vector (1).png'),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                _menuItem(Icons.delete_outline, LocaleKeys.delete.tr(),
                    isDelete: true),
                _menuItem(Icons.share, LocaleKeys.share.tr()),
                _menuItem(
                  Icons.qr_code_scanner_rounded,
                  LocaleKeys.scan_qr_code.tr(),
                  isQr: true,
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddItem(
                    listId: widget.listId,
                  )));
          // _showPopupMenu3();
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 173, 25, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ListModel>(
              future: provider!.fetchListedItems(widget.listId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error while fetching data from the server'),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.data!.isEmpty) {
                    return Center(
                      child: Text(LocaleKeys.no_data_found.tr()),
                    );
                  } else {
                    return Column(
                      children: [
                        ListTile(
                            title: Text(
                              LocaleKeys.total.tr(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 173, 25, 1),
                              ),
                            ),
                            trailing: Consumer<ListProvider>(
                              builder: (context, lp, child) {
                                return Text(
                                  'PKR ${lp.grandTotal[widget.listName]}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(20, 20, 20, 1),
                                  ),
                                );
                              },
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = snapshot.data!.data![index];
                              if (snapshot.data!.data!.isNotEmpty)
                                return ItemScreenComponent(
                                  priceCtr: priceCtr,
                                  qtyCtr: qtyCtr,
                                  data: data,
                                  index: index,
                                );
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                }
              },
            ),
          ),
          Selector<ListProvider, bool>(
            selector: (_, myType) => provider!.title,
            builder: (context, value, child) {
              return value == true
                  ? Container(
                      width: double.maxFinite,
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      child: ElevatedButton(
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
                              if (provider!.msg ==
                                  'item deleted successfully') {
                                WidgetConstants.hideSnackBar(context);
                                setState(() {});
                                WidgetConstants.showSnackBar(
                                    context, provider!.msg);
                                provider!.getTitle(false);
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
          )
        ],
      ),
    );
  }

  PopupMenuItem _menuItem(IconData iconData, String title,
      {bool? isDelete = false, bool? isQr = false}) {
    return PopupMenuItem(
      onTap: isDelete == true && isQr == false
          ? () {
              provider!.getTitle(
                  !Provider.of<ListProvider>(context, listen: false).title);
            }
          : () {},
      child: InkWell(
        onTap: isQr == true && isDelete == false
            ? () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => QRViewExample(),
                  ),
                )
            : null,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Icon(
                iconData,
                color: Color.fromRGBO(52, 107, 33, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              child: Text(
                title,
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
    );
  }
}
