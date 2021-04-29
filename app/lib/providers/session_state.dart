import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../api.dart';

class SessionState extends ChangeNotifier {
  WebSocketChannel channel;
  User me = User(name: "anon", id: Uuid().v4(), type: "ponger");
  List<User> users = [];

  void openChannel() {
    if (channel == null) {
      final url = "$WS_ENDPOINT/${me.id}?name=${me.name}&client_type=ponger";
      channel = IOWebSocketChannel.connect(url);
      listenForPing();
      notifyListeners();
    }
  }

  void closeChannel() {
    if (channel != null) {
      subscription.cancel();
      channel.sink.close();
      channel = null;
      notifyListeners();
    }
  }

  void changeConnectionAttributes() {
    closeChannel();
    openChannel();
  }

  StreamSubscription subscription;

  Future<void> listenForPing() async {
    subscription = channel.stream.listen((event) async {
      var data = jsonDecode(event);
      if (data["mtype"] == "PING" && data["recipient"] == me.id) {
        AudioCache player = AudioCache();
        player.play("knock.mp3");
        print("Played knock");
        var response = _listenForGesture();
        sendPong(data["sender"], response);
      }
    });
  }

  String _listenForGesture() {
    return "accept";
  }

  void sendPong(String recipientId, String status) {
    Map<String, dynamic> message = {
      "mtype": "PONG",
      "sender": me.id,
      "recipient": recipientId,
      "status": status
    };
    channel.sink.add(jsonEncode(message));
  }

  void updateUsers() async {
    users = await getCurrentUsers();
    notifyListeners();
  }

  Future<void> refreshUsers() async {
    updateUsers();
  }

  void changeName(String newName) {
    me.name = newName;
    changeConnectionAttributes();
    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    channel.sink.close();
    super.dispose();
  }
}
