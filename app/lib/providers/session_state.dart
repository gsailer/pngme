import 'dart:convert';

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
      notifyListeners();
    }
  }

  void closeChannel() {
    if (channel != null) {
      channel.sink.close();
      channel = null;
      notifyListeners();
    }
  }

  void changeConnectionAttributes() {
    closeChannel();
    openChannel();
  }

  void sendPong(User recipient, String status) {
    Map<String, dynamic> message = {
      "mtype": "PONG",
      "sender": me.id,
      "recipient": recipient.id,
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
    channel.sink.close();
    super.dispose();
  }
}
