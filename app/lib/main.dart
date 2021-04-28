import 'package:app/providers/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/initial.dart';
import './screens/gestures.dart';
import './screens/join.dart';
import './screens/session.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SessionState()),
      ],
      child: MaterialApp(
        title: 'pngme.',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) => InitialScreen(),
          '/gestures': (context) => GestureRecording(),
          '/join': (context) => JoinSession(),
          '/session': (context) => SessionScreen(),
        },
      ),
    );
  }
}
