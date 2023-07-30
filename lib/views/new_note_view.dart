import 'package:flutter/material.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      )
    );
  }
}