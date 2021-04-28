import 'package:app/providers/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<SessionState>(context).users;
    return Scaffold(
      body: RefreshIndicator(
        child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int position) => ListTile(
            title: Text(users[position].name),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
        onRefresh: () =>
            Provider.of<SessionState>(context, listen: false).refreshUsers(),
      ),
    );
  }
}
