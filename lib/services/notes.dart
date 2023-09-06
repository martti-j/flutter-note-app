import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List> getNotes() async {
  var uri = Uri.parse('http://10.0.2.2:8000/notes/');

  var response = await http.get(uri);

  final List answer = convert.jsonDecode(response.body);

  return answer;
}

void addNote(String tittle, String content, String username) async {
  var uri = Uri.parse('http://10.0.2.2:8000/note/');
  var body = convert.jsonEncode(<String, String>{
    'Tittle': tittle, 'Content': content, 'Writer': username
  });
  var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

  var response = await http.post(uri, headers: header, body: body);

  print('Response status: ${response.statusCode}');
}
