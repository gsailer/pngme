import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api.dart';
import '../providers/session_state.dart';

class PingDialog extends StatelessWidget {
  final User user;
  PingDialog({@required this.user});

  @override
  Widget build(BuildContext context) {
    var channel = Provider.of<SessionState>(context, listen: false).channel;
    var me = Provider.of<SessionState>(context).me;
    return SimpleDialog(
      title: Text("Availability for ${user.name}"),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
              child: Text("Check"),
              onPressed: () {
                channel.sink.add(jsonEncode({
                  "mtype": "PING",
                  "sender": me.id,
                  "recipient": user.id,
                }));
                Navigator.of(context).pop();
              }),
          TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop())
        ]),
      ],
    );
  }
}
