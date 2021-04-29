import 'package:app/providers/earable.dart';
import 'package:app/providers/session_state.dart';
import 'package:app/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './users.dart';

class SessionScreen extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[UserPage(), SettingsPage()];

  Future<Widget> _pongHandler(BuildContext context) async {
    Future<void> handlePong(sessionState) async {
      print("Pong process triggered");
      Provider.of<EarableState>(context, listen: false).classifyGesture().then(
          (response) => Provider.of<SessionState>(context, listen: false)
              .sendPong(sessionState.toPong, response));
    }

    SessionState sessionState = Provider.of<SessionState>(context);
    if (sessionState.requiresPong) {
      handlePong(sessionState);
    }
    return Container(width: 0, height: 0);
  }

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
      body: Column(children: [
        Expanded(
            child: _widgetOptions[
                Provider.of<SessionState>(context).selectedIndex]),
        Expanded(
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
      ]),
    );
  }
}
