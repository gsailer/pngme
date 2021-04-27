import 'package:flutter/material.dart';

class JoinSession extends StatefulWidget {
  @override
  JoinState createState() => JoinState();
}

class JoinState extends State<JoinSession> {
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Session"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Please enter your name to connect to the local session."),
                TextField(
                  controller: textController,
                  autofocus: true,
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/session'),
                child: Text("Join"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
