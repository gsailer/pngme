import 'package:flutter/material.dart';

class GestureRecording extends StatelessWidget {
  void _recordGesture(String type) {
    print("Recording $type");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record Gestures"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Accept Gesture",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Currently not set"),
                TextButton(
                  onPressed: () => _recordGesture("accept"),
                  child: Text("Record"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Decline Gesture",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Currently not set"),
                TextButton(
                  onPressed: () => _recordGesture("decline"),
                  child: Text("Record"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/join'),
            child: Text("Done"),
          ),
        ],
      ),
    );
  }
}
