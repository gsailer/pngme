import 'dart:convert';
import 'package:http/http.dart' as http;

const String API_AUTHORITY = "pngme.azurewebsites.net";
const String WS_ENDPOINT = "wss://pngme.azurewebsites.net/sessions/join";

class User {
  String name;
  String type;
  String id;
  User({this.name, this.type, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["client_id"],
      name: json["name"],
      type: json["client_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "client_id": id,
        "client_type": type,
        "name": name,
      };
}

Future<List<User>> getCurrentUsers() async {
  final response = await http.get(Uri.https(API_AUTHORITY, "sessions/"));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body).isEmpty
        ? <User>[]
        : jsonDecode(response.body)
            .map<User>((element) => User.fromJson(element))
            .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load users');
  }
}
