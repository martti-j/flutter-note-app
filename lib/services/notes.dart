import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List> getNotes() async {
  var uri = Uri.parse('http://10.0.2.2:8000/notes/');

  var response = await http.get(uri);

  final List answer = convert.jsonDecode(response.body);

  return answer;
}