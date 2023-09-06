import 'package:flutter/material.dart';
import 'package:note_app/views/notes_view.dart';
import 'package:note_app/services/notes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  final NotesView noteview = const NotesView();

  Future<String> _getUsername() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'username');
    if (value == null) {
      return 'null';
    }
    return value;
  }

  late final TextEditingController _tittle;
  late final TextEditingController _content;

  @override
  void initState() {
    _tittle = TextEditingController();
    _content = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tittle.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New note'),
      ),
      body: 
      Column(
        children: [
          TextField(
            controller: _tittle,
            decoration: const InputDecoration(hintText: 'Tittle...'),
          ),
          TextField(
            controller: _content,
            decoration: const InputDecoration(hintText: 'Content...'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.pop(context);
              String username = await _getUsername();
              addNote(_tittle.text, _content.text, username);
              //noteview.updateNoteList();
              navigator;
            },
            child: const Text('Add'),
          ),
        ],
      )
    );
  }
}