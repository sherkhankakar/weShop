import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/list_provider.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key,
      this.isColorLess = false,
      this.onTap,
      required this.buttonText});
  final bool? isColorLess;
  final VoidCallback? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context, listen: false);
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap ??
            () {
              provider.getEditValue(!provider.isEdit);
              provider.setCurrentIndex(-1);
            },
        child: Text(buttonText),
        style: OutlinedButton.styleFrom(
            foregroundColor: isColorLess == false ? Colors.green : Colors.white,
            backgroundColor: isColorLess == true ? Colors.green : Colors.white,
            side: BorderSide(
              color: Colors.green,
              width: 2,
            ),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: Colors.green,
                width: 20,
              ),
            )),
      ),
    );
  }
}
