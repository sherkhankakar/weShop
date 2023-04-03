import 'package:flutter/material.dart';

class Frgone extends StatefulWidget {
  const Frgone({Key? key}) : super(key: key);

  @override
  State<Frgone> createState() => _FrgoneState();
}

class _FrgoneState extends State<Frgone> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
