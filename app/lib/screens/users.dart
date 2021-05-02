import 'package:app/providers/earable.dart';
import 'package:app/widgets/pong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session_state.dart';
import '../widgets/ping.dart';
import '../api.dart';

class UserPage extends StatelessWidget {
  Future<Widget> _pongHandler(BuildContext context) async {
    Future<void> handlePong(sessionState) async {
      print("Pong process triggered");
      if (Provider.of<EarableState>(context, listen: false).deviceStatus ==
          "connected") {
        Provider.of<EarableState>(context, listen: false)
            .classifyGesture()
            .then((response) =>
                Provider.of<SessionState>(context, listen: false)
                    .sendPong(sessionState.toPong, response));
      } else {
        print("Earables not connected. Showing Dialog.");
        User recipient = Provider.of<SessionState>(context, listen: false)
            .userByID(sessionState.toPong);
        await Future.delayed(Duration(milliseconds: 50));
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Pong(name: recipient.name, id: recipient.id));
      }
    }

    SessionState sessionState = Provider.of<SessionState>(context);
    if (sessionState.requiresPong) {
      handlePong(sessionState);
    }
    return Container(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<SessionState>(context).users;
    User me = Provider.of<SessionState>(context).me;
    List<User> filteredUsers = users.where((user) => user.id != me.id).toList();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              child: filteredUsers.length > 0
                  ? ListView.separated(
                      itemCount: filteredUsers.length,
                      itemBuilder: (BuildContext context, int position) =>
                          filteredUsers[position].id != me.id
                              ? ListTile(
                                  title: Text(filteredUsers[position].name),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => PingDialog(
                                          user: filteredUsers[position])),
                                )
                              : null,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).padding.bottom),
                        child: Text(
                          "No Users available",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
              onRefresh: () => Provider.of<SessionState>(context, listen: false)
                  .refreshUsers(),
            ),
          ),
          Container(
            child: FutureBuilder(
                future: _pongHandler(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Container(width: 0, height: 0);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(width: 0, height: 0);
                  } else {
                    if (snapshot.hasError)
                      return Container(width: 0, height: 0);
                    else
                      return snapshot.data;
                  }
                }),
          ),
        ],
      ),
    );
  }
}
