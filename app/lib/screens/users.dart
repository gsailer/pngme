import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/session_state.dart';
import '../widgets/ping.dart';
import '../api.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<SessionState>(context).users;
    User me = Provider.of<SessionState>(context).me;
    List<User> filteredUsers = users.where((user) => user.id != me.id).toList();
    return Scaffold(
      body: RefreshIndicator(
        child: filteredUsers.length > 0
            ? ListView.separated(
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int position) =>
                    filteredUsers[position].id != me.id
                        ? ListTile(
                            title: Text(filteredUsers[position].name),
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    PingDialog(user: filteredUsers[position])),
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
        onRefresh: () =>
            Provider.of<SessionState>(context, listen: false).refreshUsers(),
      ),
    );
  }
}
