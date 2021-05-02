import 'package:app/providers/session_state.dart';
import 'package:app/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './users.dart';

class SessionScreen extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[UserPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: Provider.of<SessionState>(context).selectedIndex,
        onTap: Provider.of<SessionState>(context, listen: false).setIndex,
      ),
      body: _widgetOptions[Provider.of<SessionState>(context).selectedIndex],
    );
  }
}
