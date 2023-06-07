import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weshop/providers/list_provider.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.ctr,
      required this.type,
      required this.index,
      this.text});
  final TextEditingController ctr;
  final String type;
  final int index;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context, listen: false);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(7)),
          width: 45,
          height: 30,
          child: Center(
            child: TextFormField(
              readOnly:
                  provider.isEdit == true && provider.currentIndex == index
                      ? false
                      : true,
              controller: provider.currentIndex == index ? ctr : null,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: text ?? '180',
                contentPadding: EdgeInsets.only(left: 8),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(7)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(7)),
              ),
              validator: (value) {
                if (value == null && value!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          right: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
                color: Color.fromRGBO(52, 107, 33, 1),
                borderRadius: BorderRadius.circular(3)),
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
