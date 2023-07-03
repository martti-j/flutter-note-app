import 'package:flutter/material.dart';
import 'package:note_app/constants/routes.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute, (route) => false);
        },
        child: const Text('Back'),
      ),
    );
  }
}
