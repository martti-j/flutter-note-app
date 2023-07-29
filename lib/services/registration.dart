import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<bool> registration(String username, String password) async {

  var uri = Uri.parse('http://10.0.2.2:8000/registration/');

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
    return true;
  } else {
    return false;
  }
}