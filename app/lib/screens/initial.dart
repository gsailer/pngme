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
                  "Make sure the Earables are paired in the system settings to receive sound on your Earables.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () async {
                Provider.of<EarableState>(context, listen: false)
                    .listenToESense();
                await Provider.of<EarableState>(context, listen: false)
                    .connectToESense();
                Navigator.of(context).pushReplacementNamed('/gestures');
              },
              child: Text("Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
