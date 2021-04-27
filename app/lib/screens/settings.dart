import 'package:app/widgets/pong.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  final _textController = TextEditingController(text: "Current Name");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Name", style: Theme.of(context).textTheme.bodyText1),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _textController,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              "Reconfigure Gestures",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () => Navigator.of(context).pushNamed('/gestures'),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: Text("Save"),
              onPressed: () => showDialog(
                builder: (context) => Pong(name: "Bob", id: "1337"),
                context: context,
              ),
            ),
          )
        ],
      ),
    );
  }
}
