import 'package:app/providers/earable.dart';
import 'package:app/providers/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  final _tcName = TextEditingController();
  final _tcEarable = TextEditingController();

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
                    controller: _tcName,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Earable ID",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _tcEarable,
                    decoration: InputDecoration(
                        hintText: Provider.of<EarableState>(context).name),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Earable Status",
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      Provider.of<EarableState>(context).deviceStatus,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                Provider.of<EarableState>(context).deviceStatus != "connected"
                    ? IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: () async {
                          EarableState earableState =
                              Provider.of<EarableState>(context, listen: false);
                          earableState.listenToESense();
                          await earableState.connectToESense();
                        })
                    : Container(width: 0, height: 0),
              ],
            ),
          ),
          Provider.of<EarableState>(context).connecting
              ? LinearProgressIndicator()
              : Container(width: 0, height: 0),
          Divider(
            color: Colors.black,
          ),
          Provider.of<EarableState>(context).deviceStatus != "Not connected"
              ? (ListTile(
                  title: Text(
                    "Reconfigure Gestures",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/gestures'),
                ))
              : Container(width: 0, height: 0),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                child: Text("Save"),
                onPressed: () {
                  if (_tcName.text != "") {
                    Provider.of<SessionState>(context, listen: false)
                        .changeName(_tcName.text);
                  }
                  if (_tcEarable.text != "") {
                    Provider.of<EarableState>(context, listen: false)
                        .changeEarable(_tcEarable.text);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
