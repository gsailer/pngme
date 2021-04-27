import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  UserState createState() => UserState();
}

class _User {
  String name;
  String type;
  String id;
  _User({this.name, this.type, this.id});
}

class UserState extends State<UsersPage> {
  List<_User> users = [
    _User(name: "Bob", id: "37928492040", type: "pinger"),
    _User(name: "Uwe", id: "fsks82893", type: "pinger"),
    _User(name: "Klaus", id: "7872992", type: "ponger"),
    _User(name: "Lilly", id: "73892910", type: "pinger"),
    _User(name: "Eve", id: "16289356", type: "ponger"),
    _User(name: "Jill", id: "273892012", type: "pinger"),
    _User(name: "Rob", id: "2839201003", type: "pinger"),
    _User(name: "Sam", id: "16849507", type: "pinger"),
    _User(name: "Jane", id: "28393881", type: "pinger")
  ];

  addUser(_User user) {
    setState(() {
      users.add(user);
    });
  }

  removeUser(_User user) {
    setState(() {
      users.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int position) => ListTile(
        title: Text(users[position].name),
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(),
    ));
  }
}
