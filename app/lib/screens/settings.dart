import 'package:app/providers/session_state.dart';
import 'package:app/widgets/pong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  final _textController = TextEditingController();
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
                    decoration: InputDecoration(
                        hintText: Provider.of<SessionState>(context).me.name),
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
                onPressed: () {
                  Provider.of<SessionState>(context, listen: false)
                      .changeName(_textController.text);
                }),
          )
        ],
      ),
    );
  }
}
