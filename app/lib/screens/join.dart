import 'package:flutter/material.dart';

class JoinSession extends StatelessWidget {
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
                TextField(),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => null,
                child: Text("Join"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
