import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> login(String username, String password) async {

  var uri = Uri.parse('http://10.0.2.2:8000/login/');

  Map data = {
    'username': username,
    'password': password
  };

  var body = convert.json.encode(data);

  var response = await http.post(uri,
      headers: {'Content-Type': 'application/json'},
      body: body
  );

  if (response.statusCode == 200) {
    const storage = FlutterSecureStorage();
    await storage.write(key: "username", value:username);
    return true;
  } else {
    return false;
  }
}

Future<String?> isLoggedIn() async {
  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: "username");
  return value;
}

void logout() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: "username");
}