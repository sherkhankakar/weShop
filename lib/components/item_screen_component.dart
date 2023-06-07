import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/list_model.dart';
import '../providers/list_provider.dart';
import '../translations/locale_keys.g.dart';
import 'button_component.dart';
import 'text_field_component.dart';

class ItemScreenComponent extends StatelessWidget {
  const ItemScreenComponent(
      {super.key,
      required this.data,
      required this.priceCtr,
      required this.qtyCtr,
      required this.index});
  final TextEditingController priceCtr;
  final TextEditingController qtyCtr;
  final int index;

  final Data data;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context, listen: false);
    ValueNotifier<int> currentIndex = ValueNotifier(-1);
    print('object: ${data.itemPrice}');
    return Selector<ListProvider, int>(
      selector: (_, list) => provider.currentIndex,
      builder: (context, currentValue, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: provider.currentIndex == index ? 150 : 60,
          alignment: Alignment.center,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Consumer<ListProvider>(
                    builder: (context, myType, child) {
                      return myType.title == true
                          ? Checkbox(
                              value: myType.myDataList[index].isChecked,
                              onChanged: (value) {
                                myType.toggleItem(data.id!, isListedItem: true);
                              })
                          : SizedBox(width: 20);
                    },
                  ),
                  FutureBuilder(
                      future: provider.getSingleItem(
                        data.itemId ?? '0',
                        data.itemPrice ?? '0',
                        data.itemQty ?? '0',
                      ),
                      builder: (context, snapshot) {
                        print('future builder');
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!['data']['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          );
                        } else {
                          return Text('Loading...');
                        }
                      }),
                  Container(
                    width: 13,
                    height: 15,
                    margin: EdgeInsets.only(top: 16.0, left: 3),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(52, 107, 33, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'L',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.setCurrentIndex(index);
                      log(currentIndex.toString());
                      provider.getEditValue(true);
                    },
                    child: Container(
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
                  ),
                  Spacer(),
                  TextFieldComponent(
                    index: index,
                    ctr: priceCtr,
                    type: 'price',
                    text: data.itemPrice,
                  ),
                  TextFieldComponent(
                    index: index,
                    ctr: qtyCtr,
                    type: 'Qty',
                    text: data.itemQty,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (data.itemId != null)
                        Consumer<ListProvider>(
                          builder: (context, lp, child) {
                            return Container(
                              width: 45,
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black54, width: 2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                data.itemId == null ||
                                        data.itemPrice == null ||
                                        data.itemQty == null
                                    ? '0'
                                    : lp.totalPrice[data.itemId],
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      Positioned(
                        bottom: -5,
                        right: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(52, 107, 33, 1),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                ],
              ),
              Selector<ListProvider, bool>(
                selector: (_, listPro) => provider.isEdit,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value == true && provider.currentIndex == index,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonComponent(
                                buttonText: LocaleKeys.cancel_word.tr(),
                              ),
                              SizedBox(width: 15),
                              ButtonComponent(
                                isColorLess: true,
                                buttonText: LocaleKeys.update.tr(),
                                onTap: () {
                                  provider
                                      .updateListItem(
                                    data.grosListId!,
                                    data.itemId!,
                                    priceCtr.text,
                                    qtyCtr.text,
                                    provider.currentIndex,
                                  )
                                      .whenComplete(() {
                                    if (provider.msg ==
                                        'List updated successfully') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(provider.msg),
                                        ),
                                      );
                                      log('message: updating total...');
                                      provider.getLists();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(provider.msg),
                                        ),
                                      );
                                    }
                                  });
                                  provider.getEditValue(!provider.isEdit);
                                  provider.setCurrentIndex(-1);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
