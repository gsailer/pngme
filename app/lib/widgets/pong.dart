import 'package:flutter/material.dart';

class Pong extends StatelessWidget {
  final String name;
  final String id;
  Pong({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("$name wants to know your availablity"),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.green,
              onPressed: () => print("Accept $id")),
          IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () => print("Decline $id"))
        ]),
      ],
    );
  }
}
