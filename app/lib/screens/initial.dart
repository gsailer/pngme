import 'package:app/providers/earable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect Earables")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/esense.jpeg")),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "If you want to be notified on the Earables, make sure they are paired in the Bluetooth system settings.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Provider.of<EarableState>(context).connecting
                ? LinearProgressIndicator()
                : Container(width: 0, height: 0),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                EarableState earableState =
                    Provider.of<EarableState>(context, listen: false);
                earableState.listenToESense();
                await earableState.connectToESense();
                Navigator.of(context).pushReplacementNamed('/gestures');
              },
              child: Text("Connect"),
            ),
            TextButton(
                child: Text("Skip"),
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/join'))
          ],
        ),
      ),
    );
  }
}
