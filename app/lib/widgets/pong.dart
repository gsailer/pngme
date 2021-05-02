import 'package:app/providers/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pong extends StatelessWidget {
  final String name;
  final String id;
  Pong({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    SessionState sessionState =
        Provider.of<SessionState>(context, listen: false);
    return SimpleDialog(
      title: Text("$name wants to know if you are available"),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.green,
              onPressed: () {
                print("Accept $id");
                sessionState.sendPong(id, "accept");
                Navigator.of(context).pop();
              }),
          IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () {
                print("Decline $id");
                sessionState.sendPong(id, "decline");
                Navigator.of(context).pop();
              })
        ]),
      ],
    );
  }
}
